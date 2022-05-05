//
//  ViewExtension.swift
//  FlashZilla
//
//  Created by Arseniy Matus on 05.05.2022.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at index: Int, in count: Int) -> some View {
        let offset = Double(count - index)
        return self.offset(x: 0, y: offset * 10)
    }
}
