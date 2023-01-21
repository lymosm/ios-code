//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by lymos on 2023/1/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView{
        GeometryReader{geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                    Button("Place Order"){
                        placeOrder()
                    }.padding()
                }
            }
            
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showConfirmation){
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        }
        
        
    }
    
    // send the post to server 
    func placeOrder(){
        guard let param = try? JSONEncoder().encode(order) else {
            print("Failed to encode order data")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = param
        
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else{
                print("No Data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let decodeOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.showConfirmation = true
                self.confirmationMessage = "Your order for \(decodeOrder.quantity) x \(Order.types[decodeOrder.type].lowercased()) cupcakes is on its way"
            }else{
                print("Invalid reponse from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
