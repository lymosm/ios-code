//
//  CoreDataPrjApp.swift
//  CoreDataPrj
//
//  Created by lymos on 2023/2/11.
//

import SwiftUI

@main
struct CoreDataPrjApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
