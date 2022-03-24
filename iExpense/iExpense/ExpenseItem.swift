//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Arseniy Matus on 24.03.2022.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var price: Double
}

