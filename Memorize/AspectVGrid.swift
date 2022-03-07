//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Arseniy Matus on 26.01.2022.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    init(items: [Item], AspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.AspectRatio = AspectRatio
        self.content = content
    }

    var items: [Item]
    var AspectRatio: CGFloat
    var content: (Item) -> ItemView

    var body: some View {
        let width: CGFloat = 100
        LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
            ForEach(items) { item in
                content(item).aspectRatio(AspectRatio, contentMode: .fit)
            }
        }
    }
}
