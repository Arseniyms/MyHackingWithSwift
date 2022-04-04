//
//  DeliveryDetailsView.swift
//  CupcakeCorner
//
//  Created by Arseniy Matus on 02.04.2022.
//

import SwiftUI

struct DeliveryDetailsView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your name", text: $order.name)
                TextField("Enter your address", text: $order.address)
                TextField("Enter your city", text: $order.city)
                TextField("Enter your zip code", text: $order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
                .disabled(!order.hasValidAddress)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeliveryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDetailsView(order: Order())
    }
}
