//
//  contactModel.swift
//  test-swift
// 联系人模型
//  Created by lymos on 2021/12/4.
//

import Foundation

class contactItem: Identifiable, Codable{
    var id = UUID()
    var name = ""
    var email = ""
    var is_contacted = false
}

class contactModel: ObservableObject{
    @Published var peopleObj: [contactItem]
    init(){
        self.peopleObj = []
    }
    
    func toggleStatus(_ contact_item: contactItem){
        contact_item.is_contacted.toggle()
        objectWillChange.send() // 通知对象改变 刷新变更
    }
}
