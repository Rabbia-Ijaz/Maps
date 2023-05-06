//
//  HomeScreenViewModelTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 30/04/2023.
//

import XCTest

final class HomeScreenViewModelTest: XCTestCase {

    var sut: HomeScreenViewModel!
    override func setUp() {
        sut = HomeScreenViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }

    func testFetchCities() {
        sut.fetchCities(text: "Karachi") {
            [weak self] in
            XCTAssertNotNil(self?.sut.cityList)
        }
    }
    
    func testSearchedText() {
        XCTAssertEqual(sut.searchedText(text: "Karachi"),"Karachi")
    }
    
    func testIsSearchTextFieldEmpty() {
        XCTAssertTrue(sut.isSearchTextFieldEmpty(text: ""))
        XCTAssertFalse(sut.isSearchTextFieldEmpty(text: "a"))
    }
    
    func testIsCityListEmpty(){
        XCTAssertTrue(sut.isCityListEmpty())
        sut.fetchCities(text: "Karachi") {
            [weak self] in
            XCTAssertNotNil(self?.sut.cityList)
            XCTAssertFalse(((self?.sut.isCityListEmpty()) != nil))
        }
        
    }
    
    func testGetAnnotations() {
        sut.fetchCities(text: "Karachi") {
            [weak self] in
            XCTAssertNotNil(self?.sut.cityList)
        }
        XCTAssertNotNil(sut.getAnnotations())
    }
    
    func testSetSelectedCityId() {
        sut.setSelectedCityId(id: "123")
        XCTAssertEqual(sut.selectedCityId, "123")
    }
}
