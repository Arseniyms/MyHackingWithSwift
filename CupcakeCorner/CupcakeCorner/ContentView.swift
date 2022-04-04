//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Arseniy Matus on 02.04.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Amount of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.isSpecialRequests.animation())
                    if order.isSpecialRequests {
                        Toggle("Add extra frosting?", isOn: $order.isExtraFrosting)
                        Toggle("Add extra sprinkles?", isOn: $order.isSprinkled)
                    }
                }
                
                Section {
                    NavigationLink {
                        DeliveryDetailsView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
