//
//  DetailScreenViewControllerTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 01/05/2023.
//

import XCTest

final class DetailScreenViewControllerTest: XCTestCase {

    var sut:DetailScreenViewController!
    override func setUp() {
        sut = DetailScreenViewController.getInstance(id: "1174872")
    }
    
    func mockViewModel() {
        
        let city = CityDetailModel()
        city.name = "Karachi"
        city.id = "1174872"
        city.coordinates = Coordinates()
        city.coordinates?.latitude = 24.8608
        city.coordinates?.longitude = 67.0104
        city.country = Country()
        city.country?.name = "Pakistan"
        city.country?.geonameId = 1168579
        city.timezoneId = "Asia/Karachi"
        city.elevation = 8
        city.population = 11624219
        
        sut.detailScreenViewModel.city = city
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testUIComponents() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testShowPin() {
        mockViewModel()
        XCTAssertNotNil(sut.showPin())
    }
    
    func testFetchCityDetail() {
        XCTAssertNotNil(sut.fetchCityDetail(id: "1174872"))
    }
}

