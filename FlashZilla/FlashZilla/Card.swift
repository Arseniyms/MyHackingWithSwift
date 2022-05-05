//
//  Card.swift
//  FlashZilla
//
//  Created by Arseniy Matus on 05.05.2022.
//

import Foundation


struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is 2+2", answer: "4")
}
