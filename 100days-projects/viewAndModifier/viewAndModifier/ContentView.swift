//
//  ContentView.swift
//  viewAndModifier
//
//  Created by lymos on 2022/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isColor = false
    let textm = Text("tdddd")
    var body: some View {
        Text("Hello, world!666")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // .background(Color.red)
            // .edgesIgnoringSafeArea(.horizontal)
        Button("Click to change color"){
            print(type(of: self.body))
            self.isColor.toggle()
        }
        .frame(width: 200, height: 200)
        .background(isColor ? Color.red : Color.green)
        Text("dddd")
            .padding()
            .background(Color.green)
            .padding()
            .background(.blue)
        VStack{
            Text("222")
                .font(.largeTitle)
            Text("333")
            Text("9999")
                .blur(radius: 1)
            textm
                .foregroundColor(.red)
            myView(str: "ddd")
                .myStyle()
            myView(str: "aaaa")
                .modifier(Title())
        }
        .font(.title)
        GridStack(rows: 4, columns: 4){row, col in
            Text("R\(row) C\(col)")
        }
        GridStack(rows: 4, columns: 4){row, col in
            HStack{
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

struct myView: View{
    var str: String
    var body: some View{
        Text(str)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Title: ViewModifier{
    
    func body(content: Content) -> some View{
        content
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
    }
}

// 扩展成View prop
extension View{
    func myStyle() -> some View{
        self.modifier(Title())
    }
}

struct GridStack<Content: View>: View{
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
        var body: some View{
            VStack{
                ForEach(0..<rows, id:\.self){row in
                    HStack{
                        ForEach(0..<columns, id:\.self){column in
                            self.content(row, column)
                        }
                    }
                }
            }
        }
    
}
