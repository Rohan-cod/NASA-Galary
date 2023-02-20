//
//  NASA_GalaryTests.swift
//  NASA GalaryTests
//
//  Created by Rohan  Gupta on 17/02/23.
//

import XCTest
@testable import NASA_Galary

final class NASA_GalaryTests: XCTestCase {
    
    var imagesViewModel: ImagesViewModel!

    override func setUpWithError() throws {
        imagesViewModel = ImagesViewModel()
    }

    func testFetchingData() throws {
        imagesViewModel.getNasaPicturesFromFile()
        
        XCTAssertTrue(!imagesViewModel.images.isEmpty)
    }
    
    func testFetchingDataFromURL() async throws {
        await imagesViewModel.getNasaPicturesFromURL()
        
        XCTAssertTrue(!imagesViewModel.images.isEmpty)
    }
}
