//
//  ContentView.swift
//  iExpense
//
//  Created by Arseniy Matus on 24.03.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddxpense = false

    let types = ["Personal", "Business"]

    @ViewBuilder func getListOfExpenses(type: String) -> some View {
        Section {
            ForEach(expenses.items) { item in
                if item.type == type {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.callout)
                        }
                        Spacer()

                        Text(item.price, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(getColor(of: item.price))
                            .font(.subheadline)
                    }
                }
            }
            .onDelete(perform: removeItems)

        } header: {
            Text(type)
        }
    }

    var body: some View {
        VStack() {
            NavigationView {
                Form {
                    ForEach(types, id: \.self) { type in
                        getListOfExpenses(type: type)
                    }
                    
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddxpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddxpense) {
                    AddView(expenses: expenses)
                }
            }
            
            Text("Total: \(expenses.getTotalExpenses().formatted(.currency(code: Locale.current.currencyCode ?? "USD")))")
                .padding()
            
        }
        
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    func getColor(of price: Double) -> Color {
        switch price {
        case 0...10:
            return .green
        case 11...100:
            return .blue
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
