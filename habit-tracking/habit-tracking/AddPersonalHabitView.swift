//
//  AddPersonalHabit.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 01.04.2022.
//

import SwiftUI
import Combine

struct AddPersonalHabitView: View {
    @ObservedObject var habitsDict: Habits
    @Environment(\.dismiss) var dismiss
    let emojiLimit = 1
    
    @State private var name = ""
    @State private var description = ""
    @State private var emoji = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Emoji", text: $emoji)
                    .onReceive(Just(emoji)) { _ in
                        limitText(emojiLimit)
                    }
                Button("Confirm"){
                    if !name.isEmpty {
                        habitsDict.addHabit(name: name, description: description, emoji: emoji)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add personal habit")
        }
        
    }
    
    func limitText(_ upper: Int) {
        if emoji.count > upper {
            emoji = String(emoji.prefix(upper))
        }
    }
}

struct AddPersonalHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonalHabitView(habitsDict: Habits())
    }
}
