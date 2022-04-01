//
//  Habit.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 30.03.2022.
//

import Foundation

struct Habit: Codable, Identifiable, Hashable {
    var id: String
    var description: String
    var emoji: String
    
}
