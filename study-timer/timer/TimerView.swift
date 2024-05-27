//
//  Timer.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView(effect: UIBlurEffect(style: effect))
        }

        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//            uiView.effect = UIBlurEffect(style: effect)
        }
}

struct TimerView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    @State var startAnimation = false
    @State private var expanded: Bool = false
    @State private var buttonVisible: Bool = true
        
    var body: some View {
        VStack {
            ZStack{
                if buttonVisible {
                    Button(action: {
                        expanded.toggle()
                        vm.start(minutes: vm.minutes)
                        startAnimation.toggle()
                    }) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: expanded ? 200 : 100, height: expanded ? 200 : 100)
                            .overlay(
                                Text("start")
                                    .font(.system(size: 30, weight: .heavy, design: .default))
                                    .foregroundColor(.white)
                            )
                            .opacity(!expanded ? 0.75 : 0)
                            .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: expanded)
                    }
                    
                    .onChange(of: expanded) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    buttonVisible = false
                                }
                            }
                        }
                    }
                }
                else {
                TimerAnimation(startAnimation: $startAnimation)
                
                Text("\(vm.time)")
                    .font(.system(size: 50, weight: .medium))
                    .foregroundColor(.white)
                     
                 }
            }
            .padding()
            .frame(width: width, height: width)
            
            
//            Slider(value: $vm.minutes, in: 1...10, step: 1)
//                .padding()
//                .disabled(vm.isActive)
//                .animation(.easeInOut, value: vm.minutes)
//                .frame(width: width)

            HStack(spacing:50) {
                
//                Button("Reset", action: vm.reset)
//                    .frame(width: 200, height: 80)
//                    .tint(.blue)
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            vm.updateCountdown()
        }
        
    }
}

struct TimerAnimation: View {
    @Binding var startAnimation: Bool
//    @State var startAnimation = false
    @State private var animationTimer: Timer?

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
                .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: startAnimation)
                .onAppear {
                    if startAnimation {
                        startAnimationTimer()
                    }
                }
//                Button("Start Animation") {
//                    if animationTimer == nil {
//                        startAnimation = true
//                        startAnimationTimer()
//                    }
//                }
            }
            .onDisappear {
                stopAnimationTimer()
            }
        }
    }
    private func startAnimationTimer() {
//        startAnimation = true
        startAnimation.toggle()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            startAnimation.toggle()
        }
    }
    private func stopAnimationTimer() {
        animationTimer?.invalidate()
        animationTimer = nil
        startAnimation = false
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
