//
//  PDFcreator.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/17/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class PDFcreator{
    var jsonModel: JsonModel?
    
    func createPDFdata() -> Data {
        let pageWidth = CGFloat(8 * 72.0)
        let pageHeight = CGFloat(11 * 72.0)
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let format = UIGraphicsPDFRendererFormat()
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            
            // Property
            let sdGap = CGFloat(25.0)
            let sdGapInBox = CGFloat(5.0)
            let sdGapInBoxForMainCotent = CGFloat(25.0)
            let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
            //            let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            var pageNum = 1
            
            // MARK: Page 1 - Teacher's info + Content Standard + Objectives + Materials
            var cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Logo
            #imageLiteral(resourceName: "logo").draw(in: CGRect(x: sdGap, y: sdGap, width: 50, height: 50))
            // Title
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
            "My Lesson Plan".draw(at: CGPoint(x: 75+25, y: 50-18), withAttributes: attributes)
            // Table Outline
            cgContext.setLineCap(CGLineCap(rawValue: Int32(2.0))!)
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap+50+10) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap+50+10))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap+50+10.0))
            // Table Horizontal Lines
            let page1BoxHeight = (pageRect.height-sdGap-50-10-40)/8
            let tableTop = sdGap+50+10
            for i in 1...2{
                cgContext.move(to:CGPoint(x: sdGap, y: tableTop+page1BoxHeight*CGFloat(i)))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: tableTop+page1BoxHeight*CGFloat(i)))
            }
            // Table Vertical Lines
            let gap_width = (pageRect.width-2*sdGap)/3
            for i in 1...2{
                cgContext.move(to:CGPoint(x: sdGap+gap_width*CGFloat(i), y: tableTop))
                cgContext.addLine(to: CGPoint(x: sdGap+gap_width*CGFloat(i), y: tableTop+page1BoxHeight))
            }
            // Teacher
            "Teacher's Name:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: tableTop+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: tableTop+sdGapInBoxForMainCotent,
                        width:150,
                        body: (jsonModel!.Item!.Name!.S),
                        maxHeight: page1BoxHeight*2/3)
            // Grade Level
            "Grade Level:".draw(at: CGPoint(x: sdGap+sdGapInBox+gap_width, y: tableTop+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2+gap_width,
                        text_y: tableTop+sdGapInBoxForMainCotent,
                        width:150,
                        body: (jsonModel!.Item!.Grade!.S),
                        maxHeight: page1BoxHeight*2/3)
            // Content Area
            "Content Area:".draw(at: CGPoint(x: sdGap+sdGapInBox+gap_width*2, y: tableTop+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2+gap_width*2,
                        text_y: tableTop+sdGapInBoxForMainCotent,
                        width:150,
                        body: (jsonModel!.Item!.Subject!.S),
                        maxHeight: page1BoxHeight*2/3)
            // Lesson Title
            "Lesson Title:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: tableTop+sdGapInBox+page1BoxHeight), withAttributes: titleAttributes)
            addBodyText(
                pageRect: pageRect,
                text_x: sdGap+sdGapInBox*2,
                text_y: tableTop+page1BoxHeight+sdGapInBoxForMainCotent,
                width:nil,
                body: (jsonModel!.Item!.LessonTitle!.S),
                maxHeight: page1BoxHeight*2/3)
            // Content Standard
            "Content Standard:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: tableTop+sdGapInBox+page1BoxHeight*2), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: tableTop+page1BoxHeight*2+sdGapInBoxForMainCotent,
                        width:nil,
                        body: (jsonModel!.Item!.ContentStandard!.S),
                        maxHeight: page1BoxHeight*2*0.85)
            
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: tableTop+page1BoxHeight*CGFloat(4)))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: tableTop+page1BoxHeight*CGFloat(4)))
            // Lesson Outcomes
            "Lesson Outcome(s):".draw(at: CGPoint(x: sdGap+sdGapInBox, y: tableTop+sdGapInBox+page1BoxHeight*4), withAttributes: titleAttributes)
            let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: tableTop+page1BoxHeight*4+sdGapInBoxForMainCotent,
                        width:nil,
                        body: learningObjective,
                        maxHeight: page1BoxHeight*2*0.85)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: tableTop+page1BoxHeight*CGFloat(6)))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: tableTop+page1BoxHeight*CGFloat(6)))
            // Material
            "Materials:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: tableTop+sdGapInBox+page1BoxHeight*6), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: tableTop+page1BoxHeight*6+sdGapInBoxForMainCotent,
                        width: nil,
                        body: (jsonModel!.Item!.Materials!.S),
                        maxHeight: page1BoxHeight*2*0.85)
            
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
            
            // MARK: Page 2 - Anticipatory Set
            cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Table OutLine
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
            cgContext.strokePath()
            "Anticipatory Set:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: sdGap + sdGapInBoxForMainCotent,
                        width: nil,
                        body:(jsonModel!.Item!.Anticipatory_Set!.S),
                        maxHeight: pageRect.height*0.5*0.88)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
            "Differentiation of Anticipatory Set (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                        width: nil,
                        body:(jsonModel!.Item!.Differentiation_of_Anticipatory_Set!.S),
                        maxHeight: pageRect.height*0.25*0.9)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
            "Formative Assessment of Anticipatory Set (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                        width: nil,
                        body:(jsonModel!.Item!.Formative_Assessment_of_Anticipatory_Set!.S),
                        maxHeight: pageRect.height*0.25*0.65)
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
            
            // MARK: Presentation / Lecture + Language Support
            if jsonModel?.Item?.Presentation_Lecture_State?.S == "combined" &&
            jsonModel?.Item?.ELLP_State?.S == "combined"{
                // MARK: PL + ELLP -1
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Instructional Sequence - Presentation / Lecture + Language Support:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: 55))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: 55 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: learningObjective,
                            maxHeight: pageRect.height*0.15)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                "My Language Objective:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.My_Language_Objective?.S ?? "",
                            maxHeight: pageRect.height*0.2)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.45))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.45))
                "Advance Organizer:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.45+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.45 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Advance_Organizer?.S ?? "",
                            maxHeight: pageRect.height*0.25)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.7))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.7))
                "Key Vocabulary:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.7+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.7 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Key_Vocabulary?.S ?? "",
                            maxHeight: pageRect.height*0.25)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: PL + ELLP -2
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Combined Content Topic One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Content_Topic_One?.S ?? "",
                            maxHeight: pageRect.height*0.5*0.88)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                // Anticipatory Set Differentiation
                "Combined Meaningful Activity One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Meaningful_Activity_One?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                "Combined Check Understanding One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Check_Understanding_One?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.7)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: PL + ELLP -3
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Combined Content Topic Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Content_Topic_Two?.S ?? "",
                            maxHeight: pageRect.height*0.5*0.88)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                // Anticipatory Set Differentiation
                "Combined Meaningful Activity Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Meaningful_Activity_Two?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                "Combined Check Understanding Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Check_Understanding_Two?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.7)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: PL + ELLP -4
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Combined Content Topic Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Content_Topic_Three?.S ?? "",
                            maxHeight: pageRect.height*0.5*0.88)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                // Anticipatory Set Differentiation
                "Combined Meaningful Activity Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Meaningful_Activity_Three?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                "Combined Check Understanding Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Check_Understanding_Three?.S ?? "",
                            maxHeight: pageRect.height*0.25*0.7)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Presentation / Lecture
            if jsonModel?.Item?.Presentation_Lecture_State?.S != "empty"{
                if jsonModel?.Item?.Presentation_Lecture_State?.S != "combined" &&
                    jsonModel?.Item?.ELLP_State?.S != "combined"{
                    // MARK: PL-1
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Instructional Sequence - Presentation / Lecture:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: 55))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                    "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                    let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap + sdGapInBox*2,
                                text_y: 55 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: learningObjective,
                                maxHeight: pageRect.height*0.15)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                    "Advanced Organizer:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Advance_Organizer?.S ?? "",
                                maxHeight: pageRect.height*0.75*0.9)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: PL-2
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Presentation Lecture Content Topic One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Content_Topic_One?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    // Anticipatory Set Differentiation
                    "Presentation Lecture Meaningful Activity One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Meaningful_Activity_One?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Presentation Lecture Check Understanding One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Check_Understanding_One?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: PL-3
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Presentation Lecture Content Topic Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Content_Topic_Two?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    // Anticipatory Set Differentiation
                    "Presentation Lecture Meaningful Activity Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Meaningful_Activity_Two?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Presentation Lecture Check Understanding Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Check_Understanding_Two?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: PL-4
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Presentation Lecture Content Topic Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Content_Topic_Three?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    // Anticipatory Set Differentiation
                    "Presentation Lecture Meaningful Activity Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Meaningful_Activity_Three?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Presentation Lecture Check Understanding Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Presentation_Lecture_Check_Understanding_Three?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                }
            }
            if jsonModel?.Item?.Presentation_Lecture_State?.S == "separated"{
                // MARK: PL-(4)
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of Presentation / Lecture:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_Presentation_Lecture?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of Presentation / Lecture:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_Presentation_Lecture?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Direct Instruction
            if jsonModel?.Item?.Direct_Instruction_State?.S != "empty"{
                // MARK: DI-1
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Instructional Sequence - Direct Instruction:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: 55))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: 55 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: learningObjective,
                            maxHeight: pageRect.height*0.15)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                "Direct Instruction:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Direct_Instruction?.S ?? "",
                            maxHeight: pageRect.height*0.375*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y:  pageRect.height*0.625))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y:  pageRect.height*0.625))
                "I Do:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.625+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.625 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.I_Do?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: DI-2
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "We Do:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.We_Do?.S ?? "",
                            maxHeight: pageRect.height*0.25)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.3))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.3))
                "You Do Together:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.3+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height*0.3 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.You_Do_Together?.S ?? "",
                            maxHeight: pageRect.height*0.3*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.6))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.6))
                "You Do Independent:".draw(at: CGPoint(x: sdGap+sdGapInBox, y:  pageRect.height*0.6+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y:  pageRect.height*0.6 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.You_Do_Independent?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            if jsonModel?.Item?.Direct_Instruction_State?.S == "separated"{
                // MARK: DI-(3)
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of Direct Instruction:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_Direct_Instruction?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of Direct Instruction:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_Direct_Instruction?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Classroom Discussion
            if jsonModel?.Item?.Classroom_Discussion_State?.S != "empty"{
                // MARK: CD-1
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Instructional Sequence - Classroom Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: 55))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: 55 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: learningObjective,
                            maxHeight: pageRect.height*0.15)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                "Focus Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Focus_Discussion?.S ?? "",
                            maxHeight: pageRect.height*0.68)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: CD-2
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Hold Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Hold_Discussion?.S ?? "",
                            maxHeight: pageRect.height*0.88)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                // MARK: CD-3
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "End Discussion::".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.End_Discussion?.S ?? "",
                            maxHeight: pageRect.height/2*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Debrief Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Debrief_Discussion?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            if jsonModel?.Item?.Classroom_Discussion_State?.S == "separated"{
                // MARK: CD-(4)
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of Classroom Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_Classroom_Discussion?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of Classroom Discussion:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_Classroom_Discussion?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Cooperative Learning
            if jsonModel?.Item?.Cooperative_Learning_State?.S != "empty"{
                // MARK: CL-1
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Instructional Sequence - Cooperative Learning:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: 55))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: 55 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: learningObjective,
                            maxHeight: pageRect.height*0.15)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                "Present Information:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Present_Information?.S ?? "",
                            maxHeight: pageRect.height*0.375*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y:  pageRect.height*0.625))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y:  pageRect.height*0.625))
                "Organize Teams:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.625+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.625 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Organize_Teams?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: CL-2
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Assist Teams:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Assist_Teams?.S ?? "",
                            maxHeight: pageRect.height*0.25)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.3))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.3))
                "Assess Teams:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.3+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height*0.3 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Assess_Teams?.S ?? "",
                            maxHeight: pageRect.height*0.3*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.6))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.6))
                "Provide Recognition:".draw(at: CGPoint(x: sdGap+sdGapInBox, y:  pageRect.height*0.6+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y:  pageRect.height*0.6 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Provide_Recognition?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            if jsonModel?.Item?.Cooperative_Learning_State?.S == "separated"{
                // MARK: CL-(3)
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of Cooperative Learning:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_Cooperative_Learning?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of Cooperative Learning:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_Cooperative_Learning?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: 5 Es (Science)
            if jsonModel?.Item?.FiveEs_State?.S != "empty"{
                // MARK: 5E-1
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Instructional Sequence - 5 Es (Science):".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: 55))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: 55 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: learningObjective,
                            maxHeight: pageRect.height*0.15)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                "Engage:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Engage?.S ?? "",
                            maxHeight: pageRect.height*0.375*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y:  pageRect.height*0.625))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y:  pageRect.height*0.625))
                "Explore:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.625+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap+sdGapInBox*2,
                            text_y: pageRect.height*0.625 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Explore?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
                
                // MARK: 5E-2
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                "Explain:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Explain?.S ?? "",
                            maxHeight: pageRect.height*0.25)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.3))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.3))
                "Elaborate:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.3+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height*0.3 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Elaborate?.S ?? "",
                            maxHeight: pageRect.height*0.3*0.9)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.6))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.6))
                "Evaluate:".draw(at: CGPoint(x: sdGap+sdGapInBox, y:  pageRect.height*0.6+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y:  pageRect.height*0.6 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Evaluate?.S ?? "",
                            maxHeight: pageRect.height*0.3)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            if jsonModel?.Item?.FiveEs_State?.S == "separated"{
                // MARK: 5E-(3)
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of 5 Es (Science):".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_5Es?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of 5 Es (Science):".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_5Es?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Language Support-1
            if jsonModel?.Item?.ELLP_State?.S != "empty"{
                if jsonModel?.Item?.Presentation_Lecture_State?.S != "combined" &&
                    jsonModel?.Item?.ELLP_State?.S != "combined"{
                    // MARK: LS-1
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    "Instructional Sequence - Language Support:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: 55))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: 55))
                    "Review the Objectives:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: 55+sdGapInBox), withAttributes: titleAttributes)
                    let learningObjective = "1) \(jsonModel!.Item!.LearningObjectiveOne!.S)\n2) \(jsonModel!.Item!.LearningObjectiveTwo!.S)"
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap + sdGapInBox*2,
                                text_y: 55 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: learningObjective,
                                maxHeight: pageRect.height*0.15)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.25))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.25))
                    "My Language Objective:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.25+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*0.25 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.My_Language_Objective?.S ?? "",
                                maxHeight: pageRect.height*0.375*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y:  pageRect.height*0.625))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y:  pageRect.height*0.625))
                    "Key Vocabulary:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.625+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*0.625 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Key_Vocabulary?.S ?? "",
                                maxHeight: pageRect.height*0.3)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: LS-2
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Language Support Content Topic One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Content_Topic_One?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    "Language Support Meaningful Activity One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Meaningful_Activity_One?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Language Support Check Understanding One:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Check_Understanding_One?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: LS-2
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Language Support Content Topic Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Content_Topic_Two?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    "Language Support Meaningful Activity Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Meaningful_Activity_Two?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Language Support Check Understanding Two:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Check_Understanding_Two?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                    
                    // MARK: LS-2
                    cgContext = context.cgContext
                    cgContext.saveGState()
                    context.beginPage()
                    // Table OutLine
                    cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                    cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                    cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                    cgContext.strokePath()
                    "Language Support Content Topic Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: sdGap + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Content_Topic_Three?.S ?? "",
                                maxHeight: pageRect.height*0.5*0.88)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                    "Language Support Meaningful Activity Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Meaningful_Activity_Three?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.9)
                    // Horizontal Line
                    cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
                    cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
                    "Language Support Check Understanding Three:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
                    addBodyText(pageRect: pageRect,
                                text_x: sdGap+sdGapInBox*2,
                                text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                                width: nil,
                                body: jsonModel!.Item!.Language_Support_Check_Understanding_Three?.S ?? "",
                                maxHeight: pageRect.height*0.25*0.7)
                    // Page num
                    addPageFoot(pageRect: pageRect, num:pageNum)
                    pageNum += 1
                    // end
                    cgContext.strokePath()
                    cgContext.restoreGState()
                }
            }
            if jsonModel?.Item?.ELLP_State?.S == "separated"{
                // MARK: LS
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Differentiation of Language Support:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Differentiation_of_ELLP?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Formative Assessment of Language Support:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Formative_Assessment_of_ELLP?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Combined Differentiation and Formative
            if (jsonModel?.Item?.isCombined ?? false){
                cgContext = context.cgContext
                cgContext.saveGState()
                context.beginPage()
                // Table OutLine
                cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
                cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
                cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
                cgContext.strokePath()
                "Combined Differentiation:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: sdGap + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Differentiation?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Horizontal Line
                cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
                cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
                "Combined Formative Assessment:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
                addBodyText(pageRect: pageRect,
                            text_x: sdGap + sdGapInBox*2,
                            text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                            width: nil,
                            body: jsonModel!.Item!.Combined_Formative?.S ?? "",
                            maxHeight: pageRect.height/2*0.85)
                // Page num
                addPageFoot(pageRect: pageRect, num:pageNum)
                pageNum += 1
                // end
                cgContext.strokePath()
                cgContext.restoreGState()
            }
            
            // MARK: Page 4 - Closure
            cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Table OutLine
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
            cgContext.strokePath()
            "Closure:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: sdGap + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Closure?.S ?? "",
                        maxHeight: pageRect.height*0.5*0.88)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
            // Anticipatory Set Differentiation
            "Differentiation of Closure (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Differentiation_of_Closure?.S ?? "",
                        maxHeight: pageRect.height*0.25*0.9)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*3/4))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*3/4))
            "Formative Assessment of Closure (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*3/4+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap+sdGapInBox*2,
                        text_y: pageRect.height*3/4 + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Formative_Assessment_of_Closure?.S ?? "",
                        maxHeight: pageRect.height*0.25*0.7)
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
            
            // MARK: Page 5 - Summative Assessment
            cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Table OutLine
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
            cgContext.strokePath()
            "Summative Assessment:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y: sdGap + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Summative_Assessment?.S ?? "",
                        maxHeight: pageRect.height*0.9)
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
            
            // MARK: Page 6 - Background (Learners, Content, Rationale)
            cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Table OutLine
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
            "Learners (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y: sdGap + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Learners?.S ?? "",
                        maxHeight: pageRect.height*0.24)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.3))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.3))
            "Content (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height*0.3+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y: pageRect.height*0.3 + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Content?.S ?? "",
                        maxHeight: pageRect.height*0.3*0.9)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height*0.6))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height*0.6))
            "Rationale for Instructional Model (Optional) :".draw(at: CGPoint(x: sdGap+sdGapInBox, y:  pageRect.height*0.6+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y:  pageRect.height*0.6 + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Rationale_for_Instructional_Model?.S ?? "",
                        maxHeight: pageRect.height*0.3)
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
            
            // MARK: Last Page - Reflective Questions + Lesson Adaptation
            cgContext = context.cgContext
            cgContext.saveGState()
            context.beginPage()
            // Table OutLine
            cgContext.move(to:CGPoint(x: sdGap, y: sdGap) )
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: sdGap))
            cgContext.addLine(to: CGPoint(x: pageWidth-sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: pageRect.height-40.0))
            cgContext.addLine(to: CGPoint(x: sdGap, y: sdGap))
            cgContext.strokePath()
            "Reflective Questions:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: sdGap+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y: sdGap + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Reflective_Questions?.S ?? "",
                        maxHeight: pageRect.height/2*0.9)
            // Horizontal Line
            cgContext.move(to:CGPoint(x: sdGap, y: pageRect.height/2))
            cgContext.addLine(to: CGPoint(x: pageRect.width-sdGap, y: pageRect.height/2))
            "Lesson Adaptation:".draw(at: CGPoint(x: sdGap+sdGapInBox, y: pageRect.height/2+sdGapInBox), withAttributes: titleAttributes)
            addBodyText(pageRect: pageRect,
                        text_x: sdGap + sdGapInBox*2,
                        text_y: pageRect.height/2 + sdGapInBoxForMainCotent,
                        width: nil,
                        body: jsonModel!.Item!.Lesson_Adaption?.S ?? "",
                        maxHeight: pageRect.height/2*0.85)
            // Page num
            addPageFoot(pageRect: pageRect, num:pageNum)
            pageNum += 1
            // end
            cgContext.strokePath()
            cgContext.restoreGState()
        }
        return data
    }
    func addPageFoot(pageRect: CGRect, num :Int){
        let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: String(num),
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: (pageRect.width - titleStringSize.width) / 2.0,
            y: pageRect.height-40,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
    }
    func addBodyText(pageRect: CGRect, text_x:CGFloat, text_y: CGFloat, width:CGFloat?, body: String, maxHeight:CGFloat){
        var autoTextSize = CGFloat(12.0)
        var textFont = UIFont.systemFont(ofSize: autoTextSize, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        var textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        var attributedText = NSAttributedString(
            string: body,
            attributes: textAttributes
        )
        // get paragraph height
        var paragraphSize = CGSize(width: width ?? (pageRect.width - 70), height: pageRect.height)
        var paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        while paragraphRect.height > maxHeight{
            autoTextSize -= 0.1
            textFont = UIFont.systemFont(ofSize: autoTextSize, weight: .regular)
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            textAttributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: textFont
            ]
            attributedText = NSAttributedString(
                string: body,
                attributes: textAttributes
            )
            // get paragraph height
            paragraphSize = CGSize(width: width ?? (pageRect.width - 70), height: pageRect.height)
            paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        }
        
        // max check
        //        let height = (paragraphRect.height > maxHeight) ? maxHeight : paragraphRect.height
        
        let textRect = CGRect(
            x: text_x,
            y: text_y,
            width: width ?? (pageRect.width - 70),
            height: paragraphRect.height
        )
        attributedText.draw(in: textRect)
    }
}

