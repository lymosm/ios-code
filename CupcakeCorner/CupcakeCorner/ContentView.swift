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
    var formDisabled: Bool{
        username.count  < 5 || email.count < 5
    }
    @ObservedObject var order = Order()
    
    var body: some View {
        
        /*
         * order form
         */
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type: ", selection:  $order.type){
                        ForEach(0..<Order.types.count, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any special requests?")
                    }
                    if order.specialRequestEnabled{
                        Toggle(isOn: $order.extraFrosting){
                            Text("Add some frosting?")
                        }
                        Toggle(isOn: $order.addSprinkles){
                            Text("Add some sprinkles")
                        }
                    }
                }
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
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
                }.disabled(username.isEmpty || email.isEmpty)
                .disabled(formDisabled)
                
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
