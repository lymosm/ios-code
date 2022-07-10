//
//  Mission.swift
//  moonshot
//
//  Created by lymos on 2022/7/10.
//

import Foundation

struct CrewRole: Codable{
    let name: String
    let Role: String
}

struct Mission: Codable, Identifiable{
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }else{
            return "N/A"
        }
        
    }
}

/*
 结构体嵌套
 struct Mission: Codable, Identifiable {
     struct CrewRole: Codable {
         let name: String
         let role: String
     }

     let id: Int
     let launchDate: String?
     let crew: [CrewRole]
     let description: String
 }
 */
