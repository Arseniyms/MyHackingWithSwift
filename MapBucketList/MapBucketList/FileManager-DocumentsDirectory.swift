//
//  FileManager-DocumentsDirectory.swift
//  MapBucketList
//
//  Created by Arseniy Matus on 21.04.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
