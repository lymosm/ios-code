//
//  ContentView.swift
//  BucketList
//
//  Created by lymos on 2023/3/19.
//

import SwiftUI

struct ContentView: View {
    let values = [2, 1, 4, 3, 9].sorted()
    let users = [
        User(firstname: "admin", lastname: "demo"),
        User(firstname: "user", lastname: "test")
    ].sorted{
        $0.lastname > $1.lastname
    }
    
    var body: some View {
        
        
        List(users){ user in
            Text("\(user.firstname) \(user.lastname)")
        }
        List(values, id: \.self){
            Text("\($0)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Identifiable{
    let id = UUID()
    let firstname: String
    let lastname: String
}
