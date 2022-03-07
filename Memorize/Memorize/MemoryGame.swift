//
//  MemoryGame.swift
//  Memorize
//
//  Created by Arseniy Matus on 10.01.2022.
//
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    var indexOfTheOneCard: Int? {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.oneAndOnly
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialIndex = indexOfTheOneCard {
                if cards[potentialIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func index(of card: Card)->Int? {
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent) {
        cards = [] // Array<Card>()
        for i in 0..<numberOfPairsOfCards {
            let content = createCardContent(i)
            cards.append(Card(content: content, id: i*2))
            cards.append(Card(content: content, id: i*2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
