//
//  DetailView.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/27/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Detail View")
            Button("x") {
                presentationMode.wrappedValue.dismiss()
            }
        }
//        .onAppear {
//            circularTransition.transitionMode = .present
////            circularTransition.startingPoint = /* Set starting point for circular transition */
//            circularTransition.circleColor = .green
//            withAnimation {
//                circularTransition.duration = 1
//            }
//        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
