//
//  RandomPhotoView.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 22.03.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RandomPhotoView: View {
    
    @EnvironmentObject var image: UnsplashData
          
    var body: some View {
        VStack {
            VStack {
                ForEach(image.photoArray, id: \.id) { photo in
                    WebImage(url: URL(string: photo.urls["thumb"]!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Text(photo.created_at)
                            .font(.footnote)
                        Spacer()
                        Image(systemName: image.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title)
                            .onTapGesture {
                                image.addToFavorite()
                            }
                    }
                }
            }
            Spacer()
            if image.isConnected {
                TimerView()
            } else {
                NoConnectionView()
            }
        }
    }
}

struct RandomPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPhotoView()
    }
}
