//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Arseniy Matus on 10.05.2022.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not locate \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file)")
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Could not decode \(file)")
        }
        
        return decoded
    }
}
