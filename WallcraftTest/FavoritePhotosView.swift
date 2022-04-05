//
//  FavoritePhotosView.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 22.03.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritePhotosView: View {
    
    @EnvironmentObject var images: UnsplashData
    
    var body: some View {
        
        if images.favoriteArray.isEmpty {
            Text("Where is no photos")
        } else {
            List {
                ForEach(images.favoriteArray, id: \.id) { photo in
                    WebImage(url: URL(string: photo.urls["thumb"]!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: images.deleteFromFavorite)
            }.listStyle(.plain)
        }
    }
}

struct FavoritePhotosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePhotosView()
    }
}
