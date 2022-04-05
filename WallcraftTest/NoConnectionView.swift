//
//  NoConnectionView.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 05.04.2022.
//

import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("You are not connected")
            Image(systemName: "wifi.slash")
        }
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
    }
}
