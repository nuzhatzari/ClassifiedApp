//
//  ClassifiedAppUITests.swift
//  ClassifiedAppUITests
//
//  Created by Nuzhat Zari on 18/02/21.
//

import XCTest

class ClassifiedAppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductList() throws {
        // UI tests must launch the application that they test.
        sleep(5)
        let cell = app.tables.cells.element(boundBy: 0)
        
        XCTAssert(cell.exists, "Product List did not load.")
        sleep(2)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testProductDetail() throws {
        // UI tests must launch the application that they test.
        sleep(5)
        let cell = app.tables.cells.element(boundBy: 0)
            
        cell.tap()
        sleep(2)
        
        let lblProductName = app.staticTexts["lblProductName"]
        XCTAssert(lblProductName.exists, "Product Details did not load.")
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 0).tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
