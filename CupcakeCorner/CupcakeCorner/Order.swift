//
// Created by Arseniy Matus on 02.04.2022.
//

import SwiftUI


class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var isSpecialRequests = false {
        didSet {
            if !isSpecialRequests {
                isSprinkled = false
                isExtraFrosting = false
            }
        }
    }
    @Published var isSprinkled = false
    @Published var isExtraFrosting = false
    
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        !(name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty ||
          name.isBlank() || address.isBlank() || city.isBlank() || zip.isBlank())
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if isSprinkled {
            cost += Double(quantity)
        }
        
        if isExtraFrosting {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() { }
    
    enum CodingKeys: CodingKey {
        case type, quantity, isSprinkled, isExtraFrosting, name, address, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container  = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(isSprinkled, forKey: .isSprinkled)
        try container.encode(isExtraFrosting, forKey: .isExtraFrosting)
        
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        isSprinkled = try container.decode(Bool.self, forKey: .isSprinkled)
        isExtraFrosting = try container.decode(Bool.self, forKey: .isExtraFrosting)

        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}


extension String {
    func isBlank() -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
