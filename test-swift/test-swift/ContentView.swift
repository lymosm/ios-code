//
//  ContentView.swift
//  test-swift
//
//  Created by lymos on 2021/10/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!ggg6")
            .padding()
    }
}

struct ContentView2: View{
    var body: some View{
        Text("This is my first app.").padding()
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView2_Previews: PreviewProvider{
    static var previews: some View{
        ContentView2()
    }
}

func myTest (name: String, val: Int) -> Void{
    print("target myTest func")
}
