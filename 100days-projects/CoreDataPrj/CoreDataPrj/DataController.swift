//
//  DataController.swift
//  CoreDataPrj
// 此类暂时无用，设置重复合并在 Persistence.swift中写
//  Created by lymos on 2023/2/12.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "CoreDataPrj")
    init(){
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Core Data Failed to loaded \(error.localizedDescription)")
                return
            }
            // 设置重复合并
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
