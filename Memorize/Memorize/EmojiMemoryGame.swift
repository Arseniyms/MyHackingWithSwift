//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Arseniy Matus on 19.01.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["😁", "🤪", "😇", "🚗", "😂", "😀", "😃", "😆", "🤣", "🥲", "☺️", "😊"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in
            emojis[index]
        }
    }

    @Published private var model = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    // MARK: - - intent(s)

    func choose(_ card: Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }

    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
