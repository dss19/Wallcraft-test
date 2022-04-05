//
//  ContentView.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 21.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                RandomPhotoView()
                .navigationBarTitle("Home", displayMode: .inline)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Home", systemImage: "house.fill")
                    .accessibility(label: Text("Random photos"))
            }.padding()
            NavigationView {
                FavoritePhotosView()
                .navigationBarTitle("Favorite", displayMode: .inline)
                .toolbar {
                    EditButton()
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Favorite", systemImage: "heart.fill")
                    .accessibility(label: Text("Favorite photos"))
            }
        }
    }
}

extension ContentView {
    enum Tab {
        case home
        case favorite
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
