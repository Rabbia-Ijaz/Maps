//
//  DetailSectionViewTest.swift
//  MapsTests
//
//  Created by Rabbia Ijaz on 30/04/2023.
//

import XCTest

final class DetailSectionViewTest: XCTestCase {

    var sut: DetailSectionView!
    override func setUp() {
        sut = DetailSectionView(title: "Population", value: "12344", imageName: "populationIcon")
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testSetupView(){
        XCTAssertNotNil(sut.setupView())
    }
    
    func testConfigureContentView(){
        XCTAssertNotNil(sut.configureContentView())
    }

}
