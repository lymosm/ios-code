//
//  addView.swift
//  iExpense
//
//  Created by lymos on 2022/7/3.
//

import SwiftUI

struct addView: View {
    @State private var name = ""
    @State private var type = "personal"
    @State private var amount = 0.0
    @ObservedObject var expenses: expensesObj
    @Environment(\.dismiss) var dismiss
    
    static let types = ["bussscc", "personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("name", text: $name)
                Picker("types", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add New Expense", displayMode: .inline)
            .toolbar{
                Button("save"){
                    let items = expenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(items)
                    dismiss() // close add view
                }
            }
        }
    }
}

struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView(expenses: expensesObj())
    }
}
