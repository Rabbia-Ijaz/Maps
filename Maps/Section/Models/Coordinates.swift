//
//  Coordinates.swift
//  Maps
//
//  Created by Rabbia Ijaz on 27/04/2023.
//

import Foundation
class Coordinates: NSObject, Codable {
    var longitude: Double?
    var latitude: Double?
    
    enum Codingkeys: String, CodingKey {
        case longitude, latitude
    }
    
    override init() {
        super.init()
        longitude = 0.0
        latitude = 0.0
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
    }
}
