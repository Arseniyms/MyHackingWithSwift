//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Arseniy Matus on 02.04.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var checkoutText = ""
    @State private var isCheckoutProceeded = false
    @State private var checkoutMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost.formatted(.currency(code: "USD")))")
                    .padding()
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
            }
        }
        .alert(checkoutText, isPresented: $isCheckoutProceeded) {
            Button("Ok") {}
        } message: {
            Text(checkoutMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            checkoutText = "Checkout done"
            checkoutMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes was successful"
            isCheckoutProceeded = true
            
        } catch {
            checkoutText = "Checkout failed"
            checkoutMessage = "Your order was unsuccessful"
            isCheckoutProceeded = true
            
        }
        
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
