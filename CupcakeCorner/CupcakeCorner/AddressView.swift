//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by lymos on 2023/1/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    var body: some View {
        Form{
            Section{
                TextField("name", text: $order.name)
                TextField("address", text: $order.address)
                TextField("city", text: $order.city)
                TextField("zip", text: $order.zip)
            }
            Section{
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Checkout")
                }
            }.disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery Defaults", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
