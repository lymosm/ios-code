//
//  ContentView.swift
//  BetterRest
//
//  Created by lymos on 2022/6/5.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
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
       
        
        Text(dateFormat1())
        
        Form{
            DatePicker("Enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
            DatePicker("Enter a date", selection: $wakeUp, in: range)
            
        }
        NavigationView{
            Form{
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep?")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%.2g") hours")
                    }
                    Text("Daliy coffee intake?")
                        .font(.headline)
                    Stepper(value: $coffeeAmount, in: 1 ... 20){
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        }else{
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
            }.navigationTitle("BetterRest")
                .toolbar{
                    Button("Calculate", action: calculateBedTime)
                }
                .alert(alertTitle, isPresented: $showAlert){
                    Button("OK"){}
                } message: {
                    Text(alertMessage)
                }
                
        }
        
    }
    
    func calculateBedTime() {
        do{
            let config = MLModelConfiguration()
            let model = try BetterRestMl(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is .."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        showAlert = true
    }
    
    func dateFormat1() -> String{
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date()
        
        let component2 = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = component2.hour ?? 0
        let minute = component2.minute ?? 0
        
        let formatter = DateFormatter();
        formatter.timeStyle = .short
        let date_string = formatter.string(from: Date())
        return date_string.appending(" Time")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
