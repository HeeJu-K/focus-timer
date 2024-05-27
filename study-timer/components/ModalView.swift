//
//  ModalView.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import SwiftUI

struct ModalView: View {
    
    @Binding var isShowing: Bool
    @State private var isDragging = false
    
    @State private var curHeight: CGFloat = 550
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 750
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
    var dragPercentage: Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    var body: some View {
        ZStack (alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(startOpacity + (endOpacity - startOpacity)*dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                modalContent
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    var modalContent: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height:6)
            }
            .frame(height: 40)
            .frame(maxWidth:.infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            ZStack {
                VStack {
                    TimerView()
                    Text("Timer goes here")
                        .font(.system(size: 24, weight:.bold))
                    Text("Time display")
                        .font(.system(size: 24, weight:.regular))
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight/2)
            }
                .foregroundColor(.white)
        )
        .animation( .easeInOut(duration: 0.45), value: isDragging)
    }
    @State private var prevDragTranslation = CGSize.zero
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged{ val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                if curHeight > maxHeight {
                    curHeight = maxHeight
                }
                else if curHeight < minHeight {
                    curHeight = minHeight
                }
            }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isShowing: .constant(true))
    }
}
