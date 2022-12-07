//
//  ContentView.swift
//  flashzilla
//
//  Created by lymos on 2022/8/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("long press")
            .padding()
            .onLongPressGesture(minimumDuration: 3){
                print("long press") 
            }
        Text("double click")
            .onTapGesture(count: 2){
                print("double click")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
