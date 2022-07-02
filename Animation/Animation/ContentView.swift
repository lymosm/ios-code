//
//  ContentView.swift
//  Animation
//
//  Created by lymos on 2022/7/2.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tab me"){
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        // .animation(.default)
        // .animation(.easeOut)
        // .animation(.easeInOut(duration: 2))
        .animation(Animation.easeInOut(duration: 2).delay(1))
        
        VStack{
            Stepper("Scale Amount", value: $animationAmount.animation(), in: 1 ... 10)
            // Spacer()
            Button("ClickMe"){
                self.animationAmount += 1
            }
            .padding(20)
            .scaleEffect(animationAmount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
