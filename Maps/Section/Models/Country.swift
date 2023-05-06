//
//  Country.swift
//  Maps
//
//  Created by Rabbia Ijaz on 29/04/2023.
//

import Foundation

class Country: NSObject, Codable {
    var name: String?
    var geonameId: Int?
    
    enum Codingkeys: String, CodingKey {
        case name, geonameId
    }
    
    override init() {
        super.init()
        name = " "
        geonameId = 0
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        geonameId = try values.decodeIfPresent(Int.self, forKey: .geonameId) ?? 0
    }
}
