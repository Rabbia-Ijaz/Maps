//
//  JSONParser.swift
//  Maps
//
//  Created by Rabbia Ijaz on 27/04/2023.
//

import Foundation
final class JSONParser : NSObject {
    override init() { super.init() }
    
    //MARK: - Codable
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    //MARK: - Public Methods
    func convertToModel <T: Codable> (type: T.Type, object: Any?) -> T? {
        
        if let object = object as? Dictionary<AnyHashable, Any> {
            return convertStringToModel(type: type, string: object.toJSONString())
        }
        
        if let object = object as? Array<Any> {
            return convertStringToModel(type: type, string: object.toJSONString())
        }
        
        if let object = object as? String {
            return convertStringToModel(type: type, string: object)
        }
        
        return nil
    }
    
    func convertModelToString <T: Codable> (model: T?) -> String? {
        guard let data = convertModelToData(model: model) else { return nil }
        return String.init(data: data, encoding: .utf8)
    }
    
    //MARK: - Private Methods
    private func convertStringToModel <T: Codable> (type: T.Type, string: String?) -> T? {
        guard let data = convertStringToData(string: string) else { return nil }
        
        do {
            return try jsonDecoder.decode(type.self, from: data)
        } catch let error {
            print("JSON Decoding Error: \(error)")
            return nil
        }
    }
    
    private func convertStringToData (string: String?) -> Data? {
        guard let string = string, string.count > 0 else { return nil }
        return string.data(using: .utf8)
    }
    
    private func convertModelToData <T: Codable> (model: T?) -> Data? {
        guard let model = model else { return nil }
        
        do {
            return try jsonEncoder.encode(model)
        } catch let error {
            print("JSON Encoding Error: \(error)")
            return nil
        }
    }
}
