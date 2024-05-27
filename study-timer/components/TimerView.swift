//
//  Timer.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var vm = ViewModel()
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        private let width: Double = 250
        
        var body: some View {
            VStack {
                Text("\(vm.time)")
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .alert("Timer done!", isPresented: $vm.showingAlert) {
                        Button("Continue", role: .cancel) {
                            // Code
                        }
                    }
                    .padding()
                    .frame(width: width, height: width)
                    .background(.thinMaterial)
                    .cornerRadius(width/2)
                    .overlay(
                            RoundedRectangle(cornerRadius: width/2)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                
                Slider(value: $vm.minutes, in: 1...10, step: 1)
                    .padding()
                    .disabled(vm.isActive)
                    .animation(.easeInOut, value: vm.minutes)
                    .frame(width: width)

                HStack(spacing:50) {
                    Button("Start") {
                        vm.start(minutes: vm.minutes)
                    }
                    .disabled(vm.isActive)
                    
                    Button("Reset", action: vm.reset)
                        .tint(.red)
                }
                .frame(width: width)
            }
            .onReceive(timer) { _ in
                vm.updateCountdown()
            }
            
        }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
