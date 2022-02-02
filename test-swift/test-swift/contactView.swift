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
     
    enum filter_type{
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
    let filter: filter_type  // 过滤类型

    @EnvironmentObject var contactArr: contactModel
    
    var filtered_contacts: [contactItem]{
        switch filter{
        case .none:
            return contactArr.peopleObj
        case .contacted:
            return contactArr.peopleObj.filter({$0.is_contacted})
        case .uncontacted:
            return contactArr.peopleObj.filter({!$0.is_contacted})
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filtered_contacts){rs in
                    VStack(alignment: .leading){
                        Text(rs.name).font(.headline)
                            Text(rs.email)
                    }.contextMenu(){
                        Button(rs.is_contacted ? "Mask as uncontacted" : "Mask as contacted"){
                            self.contactArr.toggleStatus(rs)
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                let contact_item = contactItem()
                contact_item.name = "user"
                contact_item.email = "user@123.com"
                self.contactArr.peopleObj.append(contact_item)
            }){
                Image(systemName: "plus")
                Text("Add")
            })
        }
        
    }
}

struct contactView_Previews: PreviewProvider {
    static var previews: some View {
        contactView(contact_type: .none, filter: .none)
    }
}
