//
//  SpottApi.swift
//  Maps
//
//  Created by Rabbia Ijaz on 27/04/2023.
//

import Foundation

class MapAPI:NSObject {
    let headers = [
        "X-RapidAPI-Key": "4c1a2aad26mshab4e4dc83cfcad4p1f195djsn1f5aca4a8e4c",
        "X-RapidAPI-Host": "spott.p.rapidapi.com"
    ]
    
    class func fetchData(text: String, completion: @escaping ([[String: Any]]?) -> Void) {
        if let url = URL(string:"https://spott.p.rapidapi.com/places/autocomplete?q=\(text)&type=CITY"){
            
            var request = URLRequest(url: url)
            let headers = MapAPI().headers
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            completion(dict)
                        } else {
                            print("Error: Could not decode JSON")
                            completion(nil)
                        }
                    } catch let error {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
    
    class func fetchCityDetail(id: String, completion: @escaping ([String: Any]?) -> Void) {
        if let url = URL(string:"https://spott.p.rapidapi.com/places/\(id)"){
            
            var request = URLRequest(url: url)
            let headers = MapAPI().headers
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completion(dict)
                        } else {
                            print("Error: Could not decode JSON")
                            completion(nil)
                        }
                    } catch let error {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
