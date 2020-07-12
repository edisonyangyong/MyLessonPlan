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
        app.tables/*@START_MENU_TOKEN@*/.otherElements["newCreatView"]/*[[".cells.otherElements[\"newCreatView\"]",".otherElements[\"newCreatView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let teachersNameTextView = app.tables.textViews["Teacher's Name"]
        teachersNameTextView.tap()
        teachersNameTextView.typeText("Edison Yang")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables.textViews["Grade"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Grade-K"]/*[[".pickers.pickerWheels[\"Grade-K\"]",".pickerWheels[\"Grade-K\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables.cells.containing(.staticText, identifier:"Subject").textViews["Subject"].tap()
        app.pickerWheels["Social Studies"].swipeDown()
        app.toolbars["Toolbar"].buttons["Keyboard"].tap()
        app/*@START_MENU_TOKEN@*/.keys["space"]/*[[".keyboards.keys[\"space\"]",".keys[\"space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let lessonTitleTextView = app.tables/*@START_MENU_TOKEN@*/.textViews["Lesson Title"]/*[[".cells.textViews[\"Lesson Title\"]",".textViews[\"Lesson Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lessonTitleTextView.tap()
        lessonTitleTextView.typeText("Sample Lesson Title")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let emailTextView =  app.tables/*@START_MENU_TOKEN@*/.textViews["Email"]/*[[".cells.textViews[\"Email\"]",".textViews[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextView.tap()
        emailTextView.typeText("Sample Email")
        app.toolbars["Toolbar"].buttons["Done"].tap()
    }
    func testContentStandard(){
//        app.tables/*@START_MENU_TOKEN@*/.otherElements["newCreatView"]/*[[".cells.otherElements[\"newCreatView\"]",".otherElements[\"newCreatView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Content Standard →"]/*[[".buttons[\"Save and Continue to Content Standard →\"].staticTexts[\"Save and Continue to Content Standard →\"]",".staticTexts[\"Save and Continue to Content Standard →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tip: copy the Content Standard\nfrom the following purple link"]/*[[".cells[\"What is Content Standard, Tip: copy the Content Standard\\nfrom the following purple link\"].staticTexts[\"Tip: copy the Content Standard\\nfrom the following purple link\"]",".staticTexts[\"Tip: copy the Content Standard\\nfrom the following purple link\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let contentStandard = app.tables/*@START_MENU_TOKEN@*/.textViews["standardTextView"]/*[[".cells.textViews[\"standardTextView\"]",".textViews[\"standardTextView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
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
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tip: Pick a Specific Verb to Make\nYour Learning Objective Measureable"]/*[[".cells.staticTexts[\"Tip: Pick a Specific Verb to Make\\nYour Learning Objective Measureable\"]",".staticTexts[\"Tip: Pick a Specific Verb to Make\\nYour Learning Objective Measureable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.tables/*@START_MENU_TOKEN@*/.tables.staticTexts["Contrast"]/*[[".cells.tables",".cells.staticTexts[\"Contrast\"]",".staticTexts[\"Contrast\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.swipeUp()
        app.tables.tables.staticTexts["Prioritize"].tap()
        let whatTextView = app.tables/*@START_MENU_TOKEN@*/.textViews["whatTextView"]/*[[".cells.textViews[\"whatTextView\"]",".textViews[\"whatTextView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        whatTextView.tap()
        whatTextView.typeText("Sample Objective 1 What Statement")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let howTextView = app.tables.textViews["howTextView"]
        howTextView.tap()
        howTextView.typeText("Sample Objective 1 How Statement")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let endTextView = app.tables.textViews["endTextView"]
        endTextView.tap()
        endTextView.typeText("Sample Objective 1 Additional Statement ")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Objective 2"]/*[[".cells.buttons[\"Objective 2\"]",".buttons[\"Objective 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.tables.staticTexts["Prioritize"].swipeDown()
        app.tables.tables.staticTexts["Analyze"].tap()
    }
    func testSummative(){
//        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Restore My Last Saved Lesson Plan")/*[[".cells.containing(.staticText, identifier:\"Browse My Lesson Plan PDFs\")",".cells.containing(.staticText, identifier:\"Get Inspired From Community\")",".cells.containing(.staticText, identifier:\"Restore My Last Saved Lesson Plan\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Content Standard →"]/*[[".buttons[\"Save and Continue to Content Standard →\"].staticTexts[\"Save and Continue to Content Standard →\"]",".staticTexts[\"Save and Continue to Content Standard →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Learning Objectives →"]/*[[".buttons[\"Save and Continue to Learning Objectives →\"].staticTexts[\"Save and Continue to Learning Objectives →\"]",".staticTexts[\"Save and Continue to Learning Objectives →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Save and Continue to Summative Assessment →"]/*[[".buttons[\"Save and Continue to Summative Assessment →\"].staticTexts[\"Save and Continue to Summative Assessment →\"]",".staticTexts[\"Save and Continue to Summative Assessment →\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tip: "]/*[[".cells.staticTexts[\"Tip: \"]",".staticTexts[\"Tip: \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
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
