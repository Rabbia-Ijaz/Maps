//
//  HomeScreenViewModel.swift
//  Maps
//
//  Created by Rabbia Ijaz on 26/04/2023.
//

import Foundation
import CoreLocation

class HomeScreenViewModel: NSObject {
    var cityList:[CityDetailModel] = []
    var selectedCityId = ""
    var searchedText = ""
    
    override init() {
        super.init()
    }
    
    //MARK: - Variable
    
    func searchedText(text:String?) -> String {
        guard let searchText = text else { return "" }
//        searchedText = searchText.trimmingCharacters(in: .whitespaces)
//        searchedText = searchText.trimmingCharacters(in: .c)
        
        return searchText.replacingOccurrences(of: " ", with: "%20")
    }
    
    func isSearchTextFieldEmpty(text:String) -> Bool {
        if text.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func isCityListEmpty() -> Bool {
        if cityList.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func parseDataIntoList(cities:[[String:Any]]) {
        cityList = []
        for city in cities {
            guard let cityDetailModel = JSONParser().convertToModel(type: CityDetailModel.self, object: city) else { return }
            cityList.append(cityDetailModel)
        }
    }
    
    func fetchCities(text: String,completion: @escaping () -> Void) {
        MapAPI.fetchData(text: text) { data in
            if let data = data {
                self.parseDataIntoList(cities: data)
//                self.cityList = self.cityList.filter({ $0.name!.hasPrefix(self.searchedText) })
                completion()
            }
            else {
                print("Error")
            }
        }
    }
    
    func getAnnotations() -> [CustomAnnotation] {
        var list:[CustomAnnotation] = []
        
        for city in cityList {
            let annotation = CustomAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: city.coordinates?.latitude ?? 0.0, longitude: city.coordinates?.longitude ?? 0.0)
            annotation.title = "Name: " + (city.name ?? "")
            annotation.subtitle = "Population: \(city.population ?? 0)"
            annotation.id = city.id
            list.append(annotation)
        }
        
        return list
    }
    
    func setSelectedCityId(id:String) {
        selectedCityId = id
    }
}
