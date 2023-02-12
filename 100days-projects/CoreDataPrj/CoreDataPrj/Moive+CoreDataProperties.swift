//
//  Moive+CoreDataProperties.swift
//  CoreDataPrj
//
//  Created by lymos on 2023/2/11.
//
//

import Foundation
import CoreData


extension Moive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moive> {
        return NSFetchRequest<Moive>(entityName: "Moive")
    }

    @NSManaged public var title: String
    @NSManaged public var director: String
    @NSManaged public var year: Int16
    
    public var wrappedTitle: String{
        title ?? "Unknow title"
    }
}

extension Moive : Identifiable {

}
