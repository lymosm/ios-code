//
//  ContentView.swift
//  Instafilter
//
//  Created by lymos on 2023/3/4.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showImagePicker = false
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image"){
                self.showImagePicker = true
            }
        }
        .sheet(isPresented: $showImagePicker){
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
