//
//  TimerView.swift
//  WallcraftTest
//
//  Created by Dmitry Samoylov on 30.03.2022.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timer: UnsplashData
    
    var body: some View {
        
        HStack {
            Text("Next photo at:")
                .font(.footnote)
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 30, height: 30)
                Circle()
                    .trim(from: 0, to: timer.timerTo)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: -90))

                Text("\(timer.timerCount)")
                    .font(.footnote)
            }
            Text("seconds")
                .font(.footnote)
        }
        .padding()
        .onReceive(timer.time) { (_) in
            timer.timer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
