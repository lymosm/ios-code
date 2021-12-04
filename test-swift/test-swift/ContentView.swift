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

struct ZStackViewTest: View{
    var body: some View{
        ZStack{
            Color(red: 1, green: 0.8, blue: 0)
                .edgesIgnoringSafeArea(.all) // 占满
            Text("ZStack Test")
              //  .background(Color.red)
        }
       // .background(Color.red)
    }
}

struct stackTest: View{
    var body: some View{
        // 加参数 spacing: 20 间隔
        VStack(alignment: .leading){
            Text("qqq")
            Text("3333")
            Button(action: {
                print("button was tapped")
            }){
                Image(systemName: "pencil")
            }
            Spacer() // 推到顶部
        }
        
    }
}

struct ContentTabView: View{
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
                    Image(systemName: "sun.max")
                    Text("发现")
                    
                }
            Text("Tab 3")
                .tabItem{
                    Image(systemName: "list.star")
                    Text("订单")
                }
            meView()
                .tabItem{
                    Image(systemName: "person")
                    Text("我的二维码")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentTabView_Previews: PreviewProvider{
    static var previews: some View{
        ContentTabView()
    }
}

func myTest (name: String, val: Int) -> Void{
    print("target myTest func")
}
