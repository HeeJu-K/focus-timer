//
//  ContentView.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showModal = false;
    @State private var showDetailsView = false;
    
    let circularTransition = CircularTransition()
    
    let buttonsData = [
        ButtonData(text: "Reading", color: LinearGradient(gradient:Gradient(colors: [.blue, .purple]), startPoint: .leading,endPoint: .trailing), hours: "1:00hr"),
        ButtonData(text: "Exercise", color: LinearGradient(gradient:Gradient(colors: [.red, .orange]), startPoint: .leading,endPoint: .trailing), hours: "0:40hr"),
        ButtonData(text: "Leetcode", color: LinearGradient(gradient:Gradient(colors: [.brown, .yellow]), startPoint: .leading,endPoint: .trailing), hours: "2:00hr"),
        ButtonData(text: "Work", color: LinearGradient(gradient:Gradient(colors: [.gray, .pink]), startPoint: .leading,endPoint: .trailing), hours: "8:00hr"),
        ]
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Tasks")
                    .font(.system(size: 40, weight: .heavy, design: .default))
                Spacer()
                List(buttonsData, id: \.text) { buttonData in
                    Button(action: {showModal = true}) {
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(buttonData.text)
                                .font(.system(size: 35, weight: .bold, design: .default))
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
                    .background(buttonData.color)
//                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 5, y: 10)
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
                
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .sheet(isPresented: $showDetailsView){
//                    DetailView()
////                        .transition(.circularTransition)
//                        .environmentObject(circularTransition)
//                }
            
            ModalView(isShowing: $showModal)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
    }
    
}

struct ButtonData: Identifiable {
    let id = UUID()
    let text: String
    let color: LinearGradient
    let hours: String
}
//extension AnyTransition {
//    static var circularTransition: AnyTransition {
//        let transition = CircularTransition()
//        return AnyTransition.asymmetric(
//            insertion: .identity,
//            removal: .identity
//        ).animation(.easeInOut(duration: transition.duration))
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
