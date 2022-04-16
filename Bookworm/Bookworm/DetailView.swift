//
//  DetailView.swift
//  Bookworm
//
//  Created by Arseniy Matus on 09.04.2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Unknown")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "UNKNOWN")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(book: <#T##Book#>)
//    }
//}
