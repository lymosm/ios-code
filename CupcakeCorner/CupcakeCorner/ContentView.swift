//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by lymos on 2023/1/20.
//

import SwiftUI

struct Response: Codable{
    var results: [Result]
}
struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}
struct ContentView: View {
    
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        
        /**
         * form check
         */
        Form{
            Section{
                TextField("username", text: $username)
                TextField("email", text: $email)
            }
            Section{
                Button("Creating Account"){
                    print("Creating Account...")
                }
            }
        }
        
        /*
            * get list from itunes.apple.com
            */
        List(results, id: \.trackId){item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData(){
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")else{
            print("Invalid url")
            return
        }
        let result = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: result){data, response, error in
            
            if let data = data{
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    DispatchQueue.main.async{
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
