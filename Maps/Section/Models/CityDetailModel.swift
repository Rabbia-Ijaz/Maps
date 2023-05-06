//
//  CityDetailModel.swift
//  Maps
//
//  Created by Rabbia Ijaz on 26/04/2023.
//

import Foundation
class CityDetailModel: NSObject, Codable {
    var id: String?
    var name: String?
    var population: Int?
    var coordinates: Coordinates?
    var country: Country?
    var elevation:Int?
    var timezoneId:String?
    
    enum Codingkeys: String, CodingKey{
        case id, name, elevation, population, coordinates, country, timezoneId
    }
    
    override init() {
        super.init()
        id = ""
        name = ""
        population = 0
        elevation = 0
        coordinates = Coordinates()
        country = Country()
        timezoneId = ""
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        population = try values.decodeIfPresent(Int.self, forKey: .population) ?? 0
        elevation = try values.decodeIfPresent(Int.self, forKey: .elevation) ?? 0
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        country = try values.decodeIfPresent(Country.self, forKey: .country)
        timezoneId = try values.decodeIfPresent(String.self, forKey: .timezoneId) ?? ""
    }
    
}
