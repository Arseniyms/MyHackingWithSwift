//
//  Cardify.swift
//  Memorize
//
//  Created by Arseniy Matus on 27.01.2022.
//

import SwiftUI


struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double{
        get{ rotation }
        set{ rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: drawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: drawingConstants.lineWidth)
            }
            else{
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    
    
    private struct drawingConstants{
        static let cornerRadius: CGFloat = 25
        static let lineWidth: CGFloat = 3
    }
}


extension View{
    func cardify(isFaceUp:Bool)-> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

