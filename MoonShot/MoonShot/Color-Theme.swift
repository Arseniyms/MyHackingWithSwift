//
//  Color-Theme.swift
//  MoonShot
//
//  Created by Arseniy Matus on 27.03.2022.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 33 / 255, green: 33 / 255, blue: 33 / 255)
    }

    static var lightBackground: Color {
        Color(red: 50 / 255, green: 50 / 255, blue: 50 / 255)
    }

    static var lightText: Color {
        Color(red: 13 / 255, green: 115 / 255, blue: 119 / 255)
    }
}
