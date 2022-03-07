//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Arseniy Matus on 07.01.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
