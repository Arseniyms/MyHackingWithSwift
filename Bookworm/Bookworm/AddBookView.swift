//
//  AddBookView.swift
//  Bookworm
//
//  Created by Arseniy Matus on 03.04.2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating: Int = 3
    @State private var review = ""
    
    private var isValid: Bool {
        title.isEmpty || author.isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            Section {
                TextEditor(text: $review)
                RatingView(rating: $rating)
            } header: {
                Text("Review this book")
            }
            
            Section {
                Button("Save the book") {
                    let newBook = Book(context: moc)
                    
                    newBook.id = UUID()
                    newBook.title = title
                    newBook.genre = genre
                    newBook.rating = Int16(rating)
                    newBook.author = author
                    newBook.review = review
                    
                    try? moc.save()
                    dismiss()
                }
                .disabled(isValid)
            }
        }
        .navigationTitle("Add book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBookView()
        }
    }
}
