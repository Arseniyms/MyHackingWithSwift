//
//  Bundle-decoder.swift
//  HotProspect
//
//  Created by Arseniy Matus on 01.05.2022.
//

import Foundation

extension Bundle {
    func decode<T:Codable> (_ url: URL) -> T {
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode")
        }
        
        return loaded
    }
}
