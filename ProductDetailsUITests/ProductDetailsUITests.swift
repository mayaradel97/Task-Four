//
//  ProductDetailsUITests.swift
//  ProductDetailsUITests
//
//  Created by Mayar Adel on 2/3/22.
//

import XCTest

class ProductDetailsUITests: XCTestCase
{

    override func setUpWithError() throws
    {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }

    func testProductDetailsScreen() throws
    {
      
        let app = XCUIApplication()
        app.launch()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.collectionViews.element(boundBy: 0).tap()
        app.staticTexts["1 - Lorem ipsum oo czsqotentbrukdkgutopykxslppqdfyecqnyvgevorbvfizvlz zsbycwbeumtttk"].tap()
        let productDescription = app.staticTexts["productDescription"]
        XCTAssertTrue(productDescription.exists)
        let productImage = app.images["productImage"]
        XCTAssertTrue(productImage.exists)

    }

    
}
