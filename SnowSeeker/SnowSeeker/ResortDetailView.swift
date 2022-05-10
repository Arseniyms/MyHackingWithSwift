//
//  ResortDetailView.swift
//  SnowSeeker
//
//  Created by Arseniy Matus on 10.05.2022.
//

import SwiftUI

struct ResortDetailView: View {
    var resort: Resort
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailView(resort: Resort.example)
    }
}
