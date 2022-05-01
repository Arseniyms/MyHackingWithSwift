//
//  Prospects.swift
//  HotProspect
//
//  Created by Arseniy Matus on 29.04.2022.
//

import Foundation
import CloudKit

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = "tes"
    fileprivate(set) var isContacted = false
    
    enum CodingKeys: CodingKey {
        case id, name, email
    }
    
    func encode(to encoder: Encoder) throws {
        var container  = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]

    
    init() {
        let pathDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let filePath = pathDirectory.appendingPathComponent("prospects.json")
        
        people = Bundle.main.decode(filePath)
    }
    
    func save() {
        let pathDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let filePath = pathDirectory.appendingPathComponent("prospects.json")
        
        let json = try? JSONEncoder().encode(people)
        
        do {
            try json!.write(to: filePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
        
    }
    
    func add(_ person: Prospect) {
        people.append(person)
        save()
    }
    
    func toggle(_ person: Prospect) {
        objectWillChange.send()
        person.isContacted.toggle()
        save()
    }
}
