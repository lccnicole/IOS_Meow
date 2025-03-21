//
//  MeowUITests.swift
//  MeowUITests
//
//  Created by Marc on 20/11/20.
//

import XCTest
import UIKit
@testable import Meow

class MeowUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCatUI() throws {
        let app = XCUIApplication()
        app.launch()
        let imageView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(app.buttons["GET ME A  NEW CAT"].exists)
        XCTAssertTrue(app.buttons["ADOPT THIS CAT"].exists)
    }
    
    func testAdopterUI() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Adopted"].tap()
        XCTAssertTrue(app.collectionViews.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.exists)
        
        XCTAssertFalse(app.buttons["GET ME A  NEW CAT"].exists)
        XCTAssertFalse(app.buttons["ADOPT THIS CAT"].exists)
    }
    
    func testAdvancedUI() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Advanced"].tap()
        let imageView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(app.buttons["GET ME A  NEW CAT"].exists)
        XCTAssertTrue(app.buttons["ADOPT THIS CAT"].exists)
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textField).element
        XCTAssertTrue(textField.exists)
        XCTAssertTrue(app.staticTexts["Category"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    
}
