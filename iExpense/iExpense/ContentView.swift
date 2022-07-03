//
//  ContentView.swift
//  iExpense
//
//  Created by lymos on 2022/7/3.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = expensesObj()
    @State private var showAddView = false
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items, id: \.id ){ item in
                    HStack{
                        Text(item.name)
                        Text(item.type)
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                    
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("iExpense")
            .toolbar{
                Button(action: {
                   // let expense = expenseItem(name: "Admin", type: "type1", amount: 2)
                   // self.expenses.items.append(expense)
                    self.showAddView = true
                }){
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView){
                addView(expenses: self.expenses)
            }
        }
        
    }
    
    func removeItem(at offsets: IndexSet){
        self.expenses.items.remove(atOffsets: offsets)
    }
}

struct expenseItem: Identifiable, Codable{
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class expensesObj: ObservableObject{
    @Published var items = [expenseItem](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([expenseItem].self, from: items){
                self.items = decoded
                return 
            }
        }
        self.items = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
