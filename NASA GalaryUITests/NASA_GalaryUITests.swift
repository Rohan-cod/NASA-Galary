//
//  NASA_GalaryUITests.swift
//  NASA GalaryUITests
//
//  Created by Rohan  Gupta on 17/02/23.
//

import XCTest

final class NASA_GalaryUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        let trifidNebulaGridImage = app.scrollViews.otherElements.otherElements["Grid Image: https://apod.nasa.gov/apod/image/1912/M20_volskiy.jpg"]
        XCTAssertTrue(trifidNebulaGridImage.exists)
        trifidNebulaGridImage.tap()
        
        let trifidNebulaDetailImage = app.collectionViews.otherElements["Detail Image: https://apod.nasa.gov/apod/image/1912/M20_volskiy.jpg"]
        XCTAssertTrue(trifidNebulaDetailImage.exists)
        trifidNebulaDetailImage.swipeRight(velocity: .slow)
        
        let closeButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Close"]
        XCTAssertTrue(closeButton.exists)
        closeButton.tap()
        
        trifidNebulaGridImage.tap()
        trifidNebulaDetailImage.swipeLeft(velocity: .slow)
        closeButton.tap()
        
        trifidNebulaGridImage.tap()
        let infoButton = app.collectionViews.otherElements["Info Button"]
        XCTAssertTrue(infoButton.exists)
        infoButton.tap()
        
        let trifidNebulaAlert = app.alerts["Messier 20 and 21"]
        XCTAssertTrue(trifidNebulaAlert.exists)

        let ok = trifidNebulaAlert.scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(ok.exists)
        ok.tap()
        
        let explanationOpenButton = app.collectionViews.buttons["Forward"]
        XCTAssertTrue(explanationOpenButton.exists)
        explanationOpenButton.tap()
        
        let explanation = app.collectionViews.scrollViews.otherElements.otherElements["Explanation"]
        XCTAssertTrue(explanation.exists)
        
        let explanationCloseButton = app.collectionViews.buttons["Go Down"]
        XCTAssertTrue(explanationCloseButton.exists)
        explanationCloseButton.tap()
        XCTAssertFalse(explanation.exists)
        
        trifidNebulaDetailImage.swipeDown(velocity: .slow)
        if closeButton.exists {
            closeButton.tap()
        }
                                        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
