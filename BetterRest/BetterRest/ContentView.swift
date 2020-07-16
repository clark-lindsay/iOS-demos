//
//  ContentView.swift
//  BetterRest
//
//  Created by Clark Lindsay on 6/25/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: SectionHeader(text: "Your ideal bedtime")) {
                    Text(calculateSleepTime())
                        .font(.largeTitle)
                }
                Section(header:
                    SectionHeader(text: "When do you want to wake up?")) {
                    DatePicker("Please enter your desired wakeup time.", selection: $wakeUp, in: ...Date().addingTimeInterval(86400), displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header:
                SectionHeader(text: "Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section(header:
                    SectionHeader(text: "Daily coffee intake")) {
                    Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                        if (coffeeAmount == 1) {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
            }
                .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateSleepTime() -> String {
        print("Calculating...")
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let secondsFromMidnight = minute * 60 + hour * 60 * 60
        
        do {
           let prediction = try model.prediction(input: SleepCalculatorInput(wake: Double(secondsFromMidnight), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            print("There was an error calculating your bedtime.")
            return ""
        }
    }
}

struct SectionHeader: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
