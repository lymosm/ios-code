//
//  ContentView.swift
//  CoreDataPrj
//
//  Created by lymos on 2023/2/11.
//

import SwiftUI
import CoreData

struct Student: Hashable{
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let students = [Student(name: "Admin"), Student(name: "User")]
    
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
   // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe = 'te'")) var ships: FetchedResults<Ship>
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "te")) var ships: FetchedResults<Ship>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe BEGINSWITH %@", "t")) var ships: FetchedResults<Ship>
    // 过滤符号有 in beginswith > < [c]不区分大小写等
    
    
    @State private var lastNameFilter = "A"
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        
        // section 6
        VStack{
            List{
                ForEach(countries, id: \.self){ country in
                    Section(header: Text(country.wrappedFullName)){
                        ForEach(country.candyArray, id: \.self){ candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add Candys"){
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "CHs"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "CH"
                candy2.origin?.fullName = "Switzerland"
                
                try? moc.save()
            }
        }
        
        // section 5
        VStack{
            FetchedList(filter: lastNameFilter)
            Button("Add Singers"){
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            Button("Show A"){
                self.lastNameFilter = "A"
            }
            Button("Show S"){
                self.lastNameFilter = "S"
            }
        }
        
        
        
        // section 4
        VStack{
            List(ships, id: \.self){ship in
                Text(ship.name ?? "Unknown")
            }
            
            Button("Add Example"){
                let ship1 = Ship(context: moc)
                ship1.name = "aaaa"
                ship1.universe = "au"
                
                let ship2 = Ship(context: moc)
                ship2.name = "df4sct"
                ship2.universe = "au"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Esdefff"
                ship3.universe = "te"
                
                try? moc.save()
            }
            
        }
        
        
        
        // section 3
        VStack{
            List(wizards, id: \.self){ wizard in
               Text(wizard.name ?? "Unknown")
            }
            
            Button("Add"){
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Poper"
            }
            
            Button("Save"){
                do{
                    try moc.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
        // section 2
        List{
            ForEach(students, id: \.self){ student in
                Text("\(student.name)")
            }
        }
        
        
        // section 1
        List{
            ForEach([2, 4, 6], id: \.self){
                Text("\($0) is Even ")
            }
        }
        
        
        
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
