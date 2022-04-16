//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Arseniy Matus on 03.04.2022.
//

import SwiftUI

struct EmojiRatingView: View {
    var rating: Int16 = 3

    var body: some View {
        switch rating {
        case 1:
            return Text("😢")
        case 2:
            return Text("😔")
        case 3:
            return Text("🙂")
        case 4:
            return Text("😀")
        default:
            return Text("😍")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView()
    }
}
