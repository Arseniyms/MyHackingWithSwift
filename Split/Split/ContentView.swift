//
//  ContentView.swift
//  Split
//
//  Created by Arseniy Matus on 21.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var fullPrice = 0.0
    @State private var tipPercent = 0
    @State private var amountOfPeople = 0
    @FocusState private var isFocused: Bool
    private let tipAmounts: [Int] = [10, 20, 30, 50, 0]

    private var totalPerPerson: Double {
        (fullPrice + fullPrice * Double(tipPercent) / 100) / Double(amountOfPeople + 2)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Введите сумму чека", value: $fullPrice,
                            format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                    Picker("Количество людей", selection: $amountOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) человек(а)")
                        }
                    }
                            .pickerStyle(.wheel)
                }
                Section {
                    Picker("Процент на чай", selection: $tipPercent) {
                        ForEach(tipAmounts, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                            .pickerStyle(.segmented)
                } header: {
                    Text("Введите процент для чаевых")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(tipPercent == 0 ? .red : .black)
                }
            }
                    .navigationTitle("Split")
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isFocused = false
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
