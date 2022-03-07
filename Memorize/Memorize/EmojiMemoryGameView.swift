//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Arseniy Matus on 07.01.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    @Namespace private var dealingNamespace

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                Spacer()
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }

    @State private var dealt = Set<Int>()

    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }

    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }

    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let i = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(i) * (drawingConstants.totalDealDuration / Double(game.cards.count))
        }

        return Animation.easeInOut(duration: drawingConstants.dealDuration).delay(delay)
    }

    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }

    var gameBody: some View {
        AspectVGrid(items: game.cards, AspectRatio: drawingConstants.AspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                cardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(1)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(drawingConstants.color)
    }

    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                cardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: drawingConstants.undealtWidth, height: drawingConstants.undealtHeight)
        .foregroundColor(drawingConstants.color)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }

    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }

    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
}

struct cardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                    .padding(drawingConstants.backCirclePadding)
                    .opacity(drawingConstants.backCircleOpacity)
                Text(card.content)
                    .padding(5)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: drawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
}

private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (drawingConstants.fontSize / drawingConstants.fontScale)
}

private func fontScale(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * drawingConstants.fontScale)
}

private enum drawingConstants {
    static let fontScale: CGFloat = 0.7
    static let backCirclePadding: CGFloat = 5
    static let backCircleOpacity: CGFloat = 0.4
    static let fontSize: CGFloat = 25

    static let AspectRatio: CGFloat = 2 / 3
    static let undealtHeight: CGFloat = 90
    static let undealtWidth = undealtHeight * AspectRatio
    static let color = Color.red
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
