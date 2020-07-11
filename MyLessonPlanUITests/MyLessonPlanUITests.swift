//
//  MyLessonPlanUITests.swift
//  MyLessonPlanUITests
//
//  Created by Yong Yang on 7/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import XCTest

class MyLessonPlanUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS": "YES"]
        continueAfterFailure = false
        app.launch()
    }
    
    func testComplete(){
        testInfo()
        testContentStandard()
    }
    
    func testInfo(){
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Restore My Last Saved Lesson Plan")/*[[".cells.containing(.staticText, identifier:\"Browse My Lesson Plan PDFs\")",".cells.containing(.staticText, identifier:\"Get Inspired From Community\")",".cells.containing(.staticText, identifier:\"Restore My Last Saved Lesson Plan\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
        let teachersName = tablesQuery.cells.containing(.staticText, identifier:"Teacher's Name").children(matching: .textView).element
        teachersName.tap()
        teachersName.typeText("Edison Yang")
        tablesQuery.cells.containing(.staticText, identifier:"Grade").children(matching: .textView).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Grade-K"]/*[[".pickers.pickerWheels[\"Grade-K\"]",".pickerWheels[\"Grade-K\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Subject").children(matching: .textView).element.tap()
        app.pickerWheels["Social Studies"].swipeDown()
        doneButton.tap()
        let lessonTitle = tablesQuery.cells.containing(.staticText, identifier:"Lesson Title").children(matching: .textView).element
        lessonTitle.tap()
                lessonTitle.typeText("Sample Title")
        let email = tablesQuery.cells.containing(.staticText, identifier:"Email").children(matching: .textView).element
        email.tap()
        email.typeText("Sample Email")
        app.toolbars["Toolbar"].buttons["Done"].tap()
    }
    
    func testContentStandard(){
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Content Standard →"]/*[[".buttons[\"Save and Continue to Content Standard →\"].staticTexts[\"Save and Continue to Content Standard →\"]",".staticTexts[\"Save and Continue to Content Standard →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
//        tablesQuery.buttons["Hawai’i State DOE Subject Matter Standards"].tap()
//        app/*@START_MENU_TOKEN@*/.otherElements["URL"]/*[[".otherElements[\"BrowserView?WebViewProcessID=25831\"]",".otherElements[\"TopBrowserBar\"]",".buttons[\"Address\"]",".otherElements[\"Address\"]",".otherElements[\"URL\"]",".buttons[\"URL\"]"],[[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tip: copy the Content Standard\nfrom the following purple link"]/*[[".cells[\"What is Content Standard, Tip: copy the Content Standard\\nfrom the following purple link\"].staticTexts[\"Tip: copy the Content Standard\\nfrom the following purple link\"]",".staticTexts[\"Tip: copy the Content Standard\\nfrom the following purple link\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        let contentStandard = app.tables.cells.containing(.button, identifier:"3").children(matching: .textView).element
        contentStandard.tap()
        app.staticTexts["Done"].tap()
         contentStandard.tap()
        contentStandard.typeText("Sample Content Standard")
        app.toolbars["Toolbar"].buttons["Done"].tap()
    }
}
