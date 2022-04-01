//
//  Habits.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 31.03.2022.
//

import Foundation

class Habits: ObservableObject {
    @Published var habits = [Habit : Int]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit : Int].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        habits = [:]
    }
    
    func addHabit(name: String, description: String, emoji: String){
        habits[Habit(id: name, description: description, emoji: emoji)] = 0
    }
    
    func changeAmount(of habit: Habit, by num: Int) {
        if let amount = habits[habit] {
            if amount + num >= 0 {
                habits[habit] = amount + num
            }
        }
    }
}
