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
    
    // MARK: Overall Testing
    func testComplete(){
        testInfo()
        testContentStandard()
        testLearningObjective()
        testSummative()
    }
    
    // MARK: View Testing
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
    
    func testLearningObjective(){
//        app/*@START_MENU_TOKEN@*/.staticTexts["Continue →"]/*[[".buttons[\"Continue →\"].staticTexts[\"Continue →\"]",".staticTexts[\"Continue →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Content Standard →"]/*[[".buttons[\"Save and Continue to Content Standard →\"].staticTexts[\"Save and Continue to Content Standard →\"]",".staticTexts[\"Save and Continue to Content Standard →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Learning Objectives →"]/*[[".buttons[\"Save and Continue to Learning Objectives →\"].staticTexts[\"Save and Continue to Learning Objectives →\"]",".staticTexts[\"Save and Continue to Learning Objectives →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tip: Pick a Specific Verb to Make\nYour Learning Objective Measureable"]/*[[".cells.staticTexts[\"Tip: Pick a Specific Verb to Make\\nYour Learning Objective Measureable\"]",".staticTexts[\"Tip: Pick a Specific Verb to Make\\nYour Learning Objective Measureable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.tables.staticTexts["Contrast"]/*[[".cells.tables",".cells.staticTexts[\"Contrast\"]",".staticTexts[\"Contrast\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery.tables.staticTexts["Prioritize"].tap()
        let what1 = tablesQuery.cells.containing(.button, identifier:"Objective 1").children(matching: .textView).element(boundBy: 0)
        what1.tap()
        what1.typeText("Sample Objective 1 what statement")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let how1 = tablesQuery.cells.containing(.button, identifier:"Objective 1").children(matching: .textView).element(boundBy: 1)
        how1.tap()
        how1.typeText("Sample Objective 1 how statement")
         app.toolbars["Toolbar"].buttons["Done"].tap()
        let end1 = tablesQuery.cells.containing(.button, identifier:"Objective 1").children(matching: .textView).element(boundBy: 2)
        end1.tap()
        end1.typeText("Sample Objective 1 additional statement")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Objective 2"]/*[[".cells.buttons[\"Objective 2\"]",".buttons[\"Objective 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.tables.staticTexts["Prioritize"].swipeDown()
        tablesQuery.tables.staticTexts["Analyze"].tap()
    }
    func testSummative(){
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Restore My Last Saved Lesson Plan")/*[[".cells.containing(.staticText, identifier:\"Browse My Lesson Plan PDFs\")",".cells.containing(.staticText, identifier:\"Get Inspired From Community\")",".cells.containing(.staticText, identifier:\"Restore My Last Saved Lesson Plan\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Content Standard →"]/*[[".buttons[\"Save and Continue to Content Standard →\"].staticTexts[\"Save and Continue to Content Standard →\"]",".staticTexts[\"Save and Continue to Content Standard →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Learning Objectives →"]/*[[".buttons[\"Save and Continue to Learning Objectives →\"].staticTexts[\"Save and Continue to Learning Objectives →\"]",".staticTexts[\"Save and Continue to Learning Objectives →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Summative Assessment →"]/*[[".buttons[\"Save and Continue to Summative Assessment →\"].staticTexts[\"Save and Continue to Summative Assessment →\"]",".staticTexts[\"Save and Continue to Summative Assessment →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        let tipStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tip: "]/*[[".cells.staticTexts[\"Tip: \"]",".staticTexts[\"Tip: \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tipStaticText.swipeUp()
        
        let summativeTextView = app.tables/*@START_MENU_TOKEN@*/.textViews["SummativeTextView"]/*[[".cells.textViews[\"SummativeTextView\"]",".textViews[\"SummativeTextView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        summativeTextView.tap()
        summativeTextView.typeText("Sample Summative Statement")
        app.toolbars["Toolbar"].buttons["Done"].tap()
    }
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
            coordinate.tap()
        }
    }
}
