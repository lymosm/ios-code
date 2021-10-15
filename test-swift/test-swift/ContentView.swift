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
    @State private var selectdTab = 0
    @State private var showingAlert = false
    var body: some View{
     //   Text("This is my first app.").padding()
        TabView(selection: $selectdTab){
            Button("show alert"){
                self.showingAlert = true
            }.alert(isPresented: $showingAlert){
                Alert(
                    title: Text("Hello"),
                    message: Text("message"),
                    dismissButton: .default(Text("ok"))
                )
            }
                .onTapGesture{
                    self.selectdTab = 1
                }
                .tabItem{
                    Image(systemName: "house")
                    Text("首页")
                }
            Text("Tab 2")
                .tabItem{
                    Image(systemName: "person")
                    Text("我的")
                    
                }
            Text("Tab 3")
                .tabItem{
                    Image(systemName: "list.star")
                    Text("订单")
                }
            Text("Tab 4")
                .tabItem{
                    Image(systemName: "sun.max")
                    Text("发现")
                }
        }
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
