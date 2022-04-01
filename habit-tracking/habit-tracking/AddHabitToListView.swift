//
//  AddHabitToList.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 31.03.2022.
//

import SwiftUI

struct AddHabitToListView: View {
    var habits: [Habit] = Bundle.main.decode("habits.json")
    @ObservedObject var habitsDict: Habits
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    Button {
                        habitsDict.addHabit(name: habit.id, description: habit.description, emoji: habit.emoji)
                        dismiss()
                    } label: {
                        HStack {
                            Text("\(habit.emoji)")
                            Text("\(habit.id.capitalized)")
                        }
                        .font(.title2)
                        .foregroundColor(.black)
                    }
                }
            }
        }
        
    }
}

//struct AddHabitToList_Previews: PreviewProvider {
//    static var previews: some View {
//        AddHabitToListView()
//    }
//}
