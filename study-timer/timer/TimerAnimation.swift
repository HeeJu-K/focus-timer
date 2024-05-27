//
//  TimerAnimation.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/27/24.
//

import SwiftUI

struct TimerAnimation: View {
    @State var startAnimation = true

        var body: some View {
            ZStack {
                ForEach((0...2), id: \.self) {circleSetNumber in
                    ZStack {
                        Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .offset(y: startAnimation ? 75 : 0)

                        Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottom, endPoint: .top))
                            .frame(width: 150, height: 150)
                            .offset(y: startAnimation ? -75 : 0)
                    }
                    .opacity(0.5)
                    .rotationEffect(.degrees(startAnimation ? Double(circleSetNumber*60) : 0))
                    .scaleEffect(startAnimation ? 1 : 0.2)
                    .onAppear {
                        withAnimation(.easeInOut.repeatForever(autoreverses: true).speed(0.1)) {
                             startAnimation.toggle()
                        }
                     }
                }
            }
        }
}

struct TimerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TimerAnimation()
    }
}
