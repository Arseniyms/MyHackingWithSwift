//
//  ContentView.swift
//  Time Converter
//
//  Created by Arseniy Matus on 21.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var fromTimeName = ""
    @State private var toTimeName = ""
    @State private var fromTime = 0.0
    
    enum FocusedState{
        case fromTimeState
    }
    
    @FocusState private var focusedField: FocusedState?

    private let times = ["секунды", "минуты", "часы", "дни"]

    private var convertedTime: Double {
        switch fromTimeName.lowercased() {
        case "секунды":
            switch toTimeName.lowercased() {
            case "секунды":
                return fromTime
            case "минуты":
                return fromTime / 60
            case "часы":
                return fromTime / 60 / 60
            case "дни":
                return fromTime / 60 / 60 / 24
            default:
                return 0.0
            }
        case "минуты":
            switch toTimeName.lowercased() {
            case "секунды":
                return fromTime * 60
            case "минуты":
                return fromTime
            case "часы":
                return fromTime / 60
            case "дни":
                return fromTime / 60 / 24
            default:
                return 0.0
            }
        case "часы":
            switch toTimeName.lowercased() {
            case "секунды":
                return fromTime * 60 * 60
            case "минуты":
                return fromTime * 60
            case "часы":
                return fromTime
            case "дни":
                return fromTime / 24
            default:
                return 0.0
            }
        case "дни":
            switch toTimeName.lowercased() {
            case "секунды":
                return fromTime * 60 * 60 * 24
            case "минуты":
                return fromTime * 60 * 24
            case "часы":
                return fromTime * 24
            case "дни":
                return fromTime
            default:
                return 0.0
            }
        default:
            return 0.0
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Выберите, что перевести", selection: $fromTimeName) {
                        ForEach(times, id: \.self) {
                            Text($0.firstCapitalized())
                        }
                    }
                    TextField("Введите время", value: $fromTime, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .fromTimeState)
                }
                .pickerStyle(.segmented)

                Section {
                    Picker("Выберите, во что перевести", selection: $toTimeName) {
                        ForEach(times, id: \.self) {
                            Text($0.firstCapitalized())
                        }
                    }
                    .pickerStyle(.segmented)

                    Text(convertedTime, format: .number)
                }
            }
            .navigationTitle("Time Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        focusedField = nil
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

extension String {
    func firstCapitalized() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}
