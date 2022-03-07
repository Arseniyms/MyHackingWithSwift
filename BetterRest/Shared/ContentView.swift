//
//  ContentView.swift
//  Shared
//
//  Created by Arseniy Matus on 05.03.2022.
//
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeup = calculateDefaultTime
    @State private var sleepTime = 8.0
    @State private var amountOfCoffee = 1
    
    private static var calculateDefaultTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepTime, coffee: Double(amountOfCoffee))
            
            return wakeup - prediction.actualSleep
        }
        catch {
            return ContentView.calculateDefaultTime
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 10) {
                    Text("When do you want to wake up?")
                        .fontWeight(.medium)
                    DatePicker("Please enter the time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("How much time do you want to sleep?")
                        .fontWeight(.medium)
                    
                    Stepper("\(sleepTime.formatted()) hours", value: $sleepTime, in: 1...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("How much coffee do you drink?")
                        .fontWeight(.medium)
                    
                    Picker("\(amountOfCoffee) hours", selection: $amountOfCoffee) {
                        ForEach(1...20, id: \.self) { i in
                            Text(i.formatted())
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section {
                    Text("You have to go to bed at \(calculateBedTime().formatted(date: .omitted, time: .shortened))")
                        .bold()
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate") {
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
