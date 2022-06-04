//
//  ContentView.swift
//  BetterRest
//
//  Created by lymos on 2022/6/5.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    var body: some View {
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
            Text("\(sleepAmount, specifier: "%.2g") hours")
        }
        DatePicker("Enter a date", selection: $wakeUp)
        Form{
            DatePicker("Enter a date", selection: $wakeUp)
                .labelsHidden()
        }
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now ... tomorrow
        Form{
            DatePicker("Enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
            DatePicker("Enter a date", selection: $wakeUp, in: range)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
