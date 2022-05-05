//
//  EditView.swift
//  FlashZilla
//
//  Created by Arseniy Matus on 05.05.2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = [Card]()
    @State private var prompt = ""
    @State private var answer = ""
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Prompt", text: $prompt)
                    TextField("Answer", text: $answer)
                    Button("Save",action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { i in
                        VStack(alignment:.leading) {
                            Text(cards[i].prompt)
                                .font(.headline)
                            Text(cards[i].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
            .listStyle(.grouped)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func addCard() {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedAnswer.isEmpty && !trimmedPrompt.isEmpty else { return }
        
        cards.append(Card(prompt: trimmedPrompt, answer: trimmedAnswer))
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
