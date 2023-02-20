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

    func testFetchingDataFromFile() throws {
        imagesViewModel.getNasaPicturesFromFile("NasaPicturesWrongFilename")
        XCTAssertTrue(imagesViewModel.images.isEmpty)
        XCTAssertTrue(imagesViewModel.showAlert)
        
        imagesViewModel.getNasaPicturesFromFile("NasaPicturesTest", bundle: Bundle(for: NASA_GalaryTests.self))
        
        XCTAssertTrue(!imagesViewModel.images.isEmpty)
        XCTAssertTrue(imagesViewModel.images[0].date > imagesViewModel.images[1].date)
        XCTAssertTrue(imagesViewModel.images[0].title == "M33: The Triangulum Galaxy")
    }
}
