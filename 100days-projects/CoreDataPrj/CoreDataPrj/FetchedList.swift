//
//  FetchedList.swift
//  CoreDataPrj
//
//  Created by lymos on 2023/2/12.
//

import SwiftUI

struct FetchedList: View{
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer>{
        fetchRequest.wrappedValue
    }
    
    init(filter: String){
        fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    
    var body: some View{
       // List(fetchRequest.wrappedValue, id: \.self){ singer in or
        List(singers, id: \.self){ singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
