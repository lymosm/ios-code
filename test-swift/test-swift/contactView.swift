//
//  contactView.swift
//  test-swift
//
//  Created by lymos on 2021/12/6.
//

import SwiftUI

struct contactView: View {
    enum status_type{
        case none, contacted, uncontacted
    }
    
    let contact_type: status_type
    
    var title: String{
        switch contact_type{
        case .none:
            return "All"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var body: some View {
        NavigationView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitle(title)
        }
        
    }
}

struct contactView_Previews: PreviewProvider {
    static var previews: some View {
        contactView(contact_type: .none)
    }
}
