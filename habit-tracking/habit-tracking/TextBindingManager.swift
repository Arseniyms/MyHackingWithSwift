//
//  TextBindingManager.swift
//  habit-tracking
//
//  Created by Arseniy Matus on 01.04.2022.
//

import Foundation


class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }

    let characterLimit: Int
    
    init(limit: Int) {
        characterLimit = limit
    }
}
