//
//  HomeScreenViewControllerTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 01/05/2023.
//

import XCTest

final class HomeScreenViewControllerTest: XCTestCase {

    var sut:HomeScreenViewController!
    override func setUp() {
        sut = HomeScreenViewController()
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
        
        sut.homeScreenViewModel.cityList.append(city)
    }
    
    override func tearDown() {
        sut = nil
    }

    func testUIComponents() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertNotNil(sut.shadowView)
        XCTAssertNotNil(sut.searchTextField)
    }
    
    func testShowToast() {
        XCTAssertNotNil(sut.showToast(message: "No data found"))
    }
    
    func testShowPins() {
        XCTAssertNotNil(sut.showPins())
    }
    
    func testFetchCities() {
        mockViewModel()
        XCTAssertFalse(sut.homeScreenViewModel.isCityListEmpty())
    }
    
    func testSearchButtonTapped() {
        mockViewModel()
        sut.searchTextField.text = "Karachi"
        XCTAssertNotNil(sut.searchButtonTapped())
        XCTAssertFalse(sut.homeScreenViewModel.isCityListEmpty())
    }
    
    func testRefresh() {
        sut.searchTextField.text = "Karachi"
        sut.refresh(UIButton())
        XCTAssertEqual(sut.searchTextField.text, "")
    }
}
