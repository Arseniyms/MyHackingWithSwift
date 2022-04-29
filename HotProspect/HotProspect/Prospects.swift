//
//  Prospects.swift
//  HotProspect
//
//  Created by Arseniy Matus on 29.04.2022.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = "tes"
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    init() {
        people = []
    }
    
    
    func add(_ person: Prospect) {
        people.append(person)
        //save()
    }
    
    func toggle(_ person: Prospect) {
        objectWillChange.send()
        person.isContacted.toggle()
        //save()
    }
}
