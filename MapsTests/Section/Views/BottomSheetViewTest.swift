//
//  BottomSheetViewTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 30/04/2023.
//

import XCTest

final class BottomSheetViewTest: XCTestCase {
    
    var viewModel:DetailScreenViewModel!
    var sut:BottomSheetView!
    override func setUp() {
        viewModel = DetailScreenViewModel()
        mockViewModel()
        sut = BottomSheetView(maximumHeight: 330, minimumHeight: 143, detailScreenViewModel: viewModel)
    }
    
    func mockViewModel() {
        viewModel.city = CityDetailModel()
        viewModel.city.name = "Karachi"
        viewModel.city.id = "1174872"
        viewModel.city.coordinates = Coordinates()
        viewModel.city.coordinates?.latitude = 24.8608
        viewModel.city.coordinates?.longitude = 67.0104
        viewModel.city.country = Country()
        viewModel.city.country?.name = "Pakistan"
        viewModel.city.country?.geonameId = 1168579
        viewModel.city.timezoneId = "Asia/Karachi"
        viewModel.city.elevation = 8
        viewModel.city.population = 11624219
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
    }
    
    func testConfigureSubview() {
        XCTAssertNotNil(sut.configureSubview())
    }
    
    func testConfigureTapGesture() {
        XCTAssertNotNil(sut.configureTapGesture())
    }
    
    func testButtonTapped() {
        sut.setupOtherDetailViews()
        XCTAssertNotNil(sut.buttonTapped(sut.arrowButton))
    }
 
    func testSetupCityDetailView() {
        XCTAssertNotNil(sut.setupCityDetailView)
    }
    
    func testHandleTap() {
        sut.setupOtherDetailViews()
        XCTAssertNotNil(sut.handleTap())
    }
    
}
