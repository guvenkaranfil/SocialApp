//
//  SocialAppUITests.swift
//  SocialAppUITests
//
//  Created by Güven Karanfil on 18.09.2022.
//

import XCTest

class SocialAppUITests: XCTestCase {
    func test_init_showsPostsNavigationBarTitle() {
        let app = XCUIApplication()
        app.launch()
        
        let navBarTitle = app.staticTexts["Posts"]
        
        XCTAssert(navBarTitle.exists)
    }
    
    func test_init_hidesLoaderGradually() {
        let app = XCUIApplication()
        app.launch()
        
        let loaderView = app.otherElements["feedListLoader"]
        
        XCTAssertFalse(loaderView.waitForExistence(timeout: 3.0))
    }
}
