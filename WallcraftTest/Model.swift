//
//  Model.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 21.03.2022.
//

import Foundation
import Network
import SwiftUI

struct Photo: Identifiable, Codable, Equatable {
    var id: String
    var created_at: String
    var urls: [String: String]
}

final class UnsplashData: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = false
    
    
    @Published var photoArray: [Photo] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(photoArray) {
                UserDefaults.standard.set(encoded, forKey: "Current")
            }
        }
    }
    @Published var favoriteArray: [Photo] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favoriteArray) {
                UserDefaults.standard.set(encoded, forKey: "Favorite")
            }
        }
    }
    @Published var isFavorite = UserDefaults.standard.bool(forKey: "IsFavorite")
    
    @Published var startTimer = true
    @Published var timerTo: CGFloat = 30
    @Published var timerCount = UserDefaults.standard.integer(forKey: "Count")
    @Published var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status != .unsatisfied ? true : false
            }
        }        
        monitor.start(queue: queue)        
        
        if let items = UserDefaults.standard.data(forKey: "Favorite") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Photo].self, from: items) {
                self.favoriteArray = decoded
            }
        }
        
        if let items = UserDefaults.standard.data(forKey: "Current") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Photo].self, from: items) {
                self.photoArray = decoded
                return
            }
        }
        
        initialLoad()
    }
    
    func initialLoad() {
        if self.isConnected && self.photoArray.isEmpty {
            self.loadData()
        }
    }
    
    func loadData() {
        let key = "uKHYpF12BEEMCO3wepmsAyEmQfTQdqUoIf8GXCVGXik"
        let url = "https://api.unsplash.com/photos/random/?count=1&client_id=\(key)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode([Photo].self, from: data)
                for photo in json {
                    DispatchQueue.main.async {
                        self.isFavorite = false
                        self.photoArray.removeAll()
                        self.photoArray.append(photo)
                    }
                }
            } catch {
                debugPrint(error)
            }
        }.resume()
    }
    
    func deleteFromFavorite(at offsets: IndexSet) {
        favoriteArray.remove(atOffsets: offsets)
        if !photoArray.isEmpty && !favoriteArray.contains(photoArray[0]) {
            isFavorite = false
        }
    }
    
    func addToFavorite() {
        if !isFavorite {
            favoriteArray.append(contentsOf: photoArray)
        } else {
            favoriteArray.removeLast()
        }
        isFavorite.toggle()
        UserDefaults.standard.set(isFavorite, forKey: "IsFavorite")
    }
    
    func timer() {
        if self.startTimer {
            if self.timerCount != 0 {
                self.timerCount -= 1
                UserDefaults.standard.set(self.timerCount, forKey: "Count")
                withAnimation(.default) {
                    self.timerTo = CGFloat(self.timerCount) / 30
                }
            }
            else {
                withAnimation(.default) {
                    self.loadData()
                    self.timerCount = 30
                }
            }
        }
    }
}
