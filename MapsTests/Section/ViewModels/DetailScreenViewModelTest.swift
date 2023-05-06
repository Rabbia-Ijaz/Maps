//
//  DetailScreenViewModelTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 30/04/2023.
//

import XCTest

final class DetailScreenViewModelTest: XCTestCase {

    var sut: DetailScreenViewModel!
    override func setUp() {
        sut = DetailScreenViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }

    func testFetchCityDetails() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotNil(self?.sut.city)
        }
    }
    
    func testCityAndCountry() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotEqual(self?.sut.cityAndCountry, "")
        }
    }

    func testCoordinates() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotEqual(self?.sut.coordinates, "")
        }
    }

    func testPopulation() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotEqual(self?.sut.population, "")
        }
    }

    func testElevation() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotEqual(self?.sut.elevation, "")
        }
    }

    func testTimeZone() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotEqual(self?.sut.timeZone, "")
        }
    }

    func testparseDataIntoModel() {
        MapAPI.fetchCityDetail(id: "1174872") { data in
            if let data = data {
                self.sut.parseDataIntoModel(city: data)
                XCTAssertNotEqual(self.sut.city.name, "")
                
            }
            else {
                print("Error")
            }
        }
    }
    
    func testGetAnnotations() {
        sut.fetchCityDetail(id: "1174872") {
            [weak self] in
            XCTAssertNotNil(self?.sut.getAnnotation())
        }
        
    }
}
