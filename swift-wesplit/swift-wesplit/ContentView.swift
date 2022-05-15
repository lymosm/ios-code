//
//  ContentView.swift
//  swift-wesplit
//
//  Created by lymos on 2022/5/15.
//

import SwiftUI

struct ContentView: View {
    @State var tabCount = 0
    @State private var name = ""
    let students = ["A", "B", "C"]
    @State var studentCount = 0
    
    @State private var amount = 0.0
    @State private var num = 2
    @State private var tipPer = 2
    
    @FocusState private var focus: Bool
    let tips = [10, 15, 20, 25, 0]
    var sumTotal: Double{
        let count = Double(num + 2)
        let tipper = Double(tipPer)
        
        let val = amount / 100 * tipper
        let total = amount + val
        let amountPer = total / count
        return amountPer
    }
    var body: some View {
        Form{
            Section{
                Text("ddd")
                Button("tabCount: \(tabCount)"){
                    self.tabCount += 1
                }
            }
            Section{
                Text("sss")
                TextField("Enter your name", text: $name)
                Text("Your name is \(name)")
            }
        }
        .navigationBarTitle(Text("UI"))
        VStack{
            Picker("select student", selection: $studentCount){
                ForEach(0 ..< students.count, id: \.self){
                    Text(self.students[$0])
                }
            }
            Text("Your chose student is \(students[studentCount])")
        }
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .focused($focus)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $num){
                        ForEach(0 ..< 10){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("tip percentage", selection: $tipPer){
                        ForEach(0 ..< tips.count, id: \.self){
                            Text("\(self.tips[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(sumTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("done"){
                        focus = false
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
