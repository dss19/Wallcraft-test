//
//  WallcraftTestApp.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 21.03.2022.
//

import SwiftUI

@main
struct WallcraftTestApp: App {
    
    @StateObject var test = UnsplashData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(test)
        }
    }
}
