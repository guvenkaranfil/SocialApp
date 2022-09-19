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
    
    func test_() {
        let app = XCUIApplication()
        app.launch()
        
        goToPostFeedScreenAndTypePostText(app)
        pickFirstImage(app)
        submitPost(app)
        validateSubmittedPost(app)
    }
    
    // MARK: - Helpers
    
    private func goToPostFeedScreenAndTypePostText(_ app: XCUIApplication) {
        app.otherElements.buttons["postFeed"].tap()
        let postText = app.tables.cells.textViews["postFeedTextfield"]
        XCTAssertTrue(postText.waitForExistence(timeout: 2))
        postText.tap()
        postText.typeText("post text from UI Test")
    }
    
    private func pickFirstImage( _ app: XCUIApplication) {
        app.staticTexts["Pick a Photo"].tap()
        let image = app.scrollViews.images.firstMatch
        if image.waitForExistence(timeout: 5) {
            image.tap()
            XCTAssertNotNil(image)
        }
    }
    
    private func submitPost(_ app: XCUIApplication) {
        let submitbutton = app.staticTexts["Submit"]
        XCTAssertTrue(submitbutton.waitForExistence(timeout: 3))
        submitbutton.tap()
        let _ = XCTWaiter.wait(for: [XCTestExpectation(description: "Hello World!")], timeout: 2.0)
    }
    
    private func validateSubmittedPost(_ app: XCUIApplication) {
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Posts"].waitForExistence(timeout: 5.0))
        XCTAssertTrue(app.staticTexts["post text from UI TestLorem ipsum"].waitForExistence(timeout: 5.0))
    }
}
