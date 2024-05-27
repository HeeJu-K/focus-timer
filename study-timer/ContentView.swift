//
//  ContentView.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showModal = false;
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            Button(action: {showModal = true}) {
                HStack{
                    Spacer()
                        .frame(width:30)
                    Text("Study")
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "play.circle")
                        .font(.largeTitle)
                        .imageScale(.large)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(width:30)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(width: 350, height: 100)
            .background(Color.black.opacity(0.3))

            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(y: -100)

            ModalView(isShowing: $showModal)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
