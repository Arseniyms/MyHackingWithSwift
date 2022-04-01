//
//  DescirptionHabitView.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 30.03.2022.
//

import SwiftUI

struct DescirptionHabitView: View {
    @ObservedObject var habitsDict: Habits
    var habit: Habit
    
    var body: some View {
        ScrollView {
            VStack() {
                Text(habit.description)
                    .font(.title2)
                    .padding()
                HStack {
                    Button {
                        habitsDict.changeAmount(of: habit, by: -1)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    
                    Text("Total times \(habitsDict.habits[habit] ?? 0)")
                    
                    Button {
                        habitsDict.changeAmount(of: habit, by: 1)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                .font(.title)
                .padding()
            }
        }
        .navigationTitle("\(habit.emoji)\(habit.id)")
    }
}

struct DescirptionHabitView_Previews: PreviewProvider {
    static var habits: [Habit] = Bundle.main.decode("habits.json")
    static var previews: some View {
        DescirptionHabitView(habitsDict: Habits(), habit: habits[0])
    }
}
