//
//  DetailScreenViewModel.swift
//  Maps
//
//  Created by Rabbia Ijaz on 29/04/2023.
//

import Foundation
import CoreLocation


class DetailScreenViewModel: NSObject {
    var city:CityDetailModel!
    
    override init() {
        super.init()
    }
    
    var cityAndCountry: String {
        return "\(city.name ?? ""), \(city.country?.name ?? "")"
    }
    
    var coordinates: String {
        return "\(city.coordinates?.latitude ?? 0.0), \(city.coordinates?.longitude ?? 0.0)"
    }
    
    var population: String {
        return "\(city.population ?? 0)"
    }
    
    var elevation: String {
        return "\(city.elevation ?? 0)"
    }
    
    var timeZone: String {
        return "\(city.timezoneId ?? "")"
    }
    
    func parseDataIntoModel(city:[String:Any]) {
        guard let cityDetailModel = JSONParser().convertToModel(type: CityDetailModel.self, object: city) else { return }
        self.city = cityDetailModel
    }
    
    func fetchCityDetail(id: String,completion: @escaping () -> Void) {
        MapAPI.fetchCityDetail(id: id) { data in
            if let data = data {
                self.parseDataIntoModel(city: data)
                completion()
            }
            else {
                print("Error")
            }
        }
    }
    
    func getAnnotation() -> CustomAnnotation {
        let annotation = CustomAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: city.coordinates?.latitude ?? 0.0, longitude: city.coordinates?.longitude ?? 0.0)
        annotation.title = city.name ?? ""
        annotation.id = city.id
        return annotation
    }
}
