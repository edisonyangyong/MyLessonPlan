//
//  Model.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation
import UIKit

class Model{
    // MARK: JSON DATA
    var jsonModel = JsonModel()
    
    // MARK: Real Data Model
    var lessonPlanCompletion:Int = 0
    var wholeState = ""
    var state = ["teacherInfoState":"◎",
                 "contentSDState":"◎",
                 "learningObState":"◎",
                 "summativeState":"◎",
                 "anticipatoryState":"◎",
                 "instructionState":"◎",
                 "closureState":"◎",
                 "backgroundState":"◎",
                 "lessonAdState":"◎",]{
        didSet{ updateTitle() }
    }
    var instructionSequenceState: [String:InstructionSequenceStepState] = [
        "Presentation / Lecture":.empty,
        "Direct Instruction":.empty,
        "Cooperative Learning":.empty,
        "Classroom Discussion":.empty,
        "5 Es (Science)":.empty,
        "Language Support":.empty,
    ]
    var reminderTitle:[String] = []
    var name:String = ""{ didSet{ updateModel() } }
    var grade:String = ""{ didSet{ updateModel() } }
    var subject:String = ""{ didSet{ updateModel() } }
    var lessonTitle:String = ""{ didSet{ updateModel() } }
    var email:String = ""{ didSet{ updateModel() } }
    var contentStandard:String = ""{ didSet{ updateModel() } }
    var learningObjectiveOne:String = ""{ didSet{ updateModel() } }
    var learningObjectiveTwo:String = ""{ didSet{ updateModel() } }
    var summativeAssessment:String = ""{ didSet{ updateModel() } }
    var anticipatorySet:String = ""{ didSet{ updateModel() } }
    var anticipatoryDifferentiation:String = ""{ didSet{ updateModel() } }
    var anticipatoryFormative:String = ""{ didSet{ updateModel() } }
    var closure:String = ""{ didSet{ updateModel() } }
    var closureDifferentiation:String = ""{ didSet{ updateModel() } }
    var closureFormative:String = ""{ didSet{ updateModel() } }
    var lessonAdaption:String = ""{ didSet{ updateModel() } }
    var reflectiveQuestions:String = ""{ didSet{ updateModel() } }
    var defaultInstructionSequence:[(title:String,color:UIColor, steps:[(step:String, content:String)])] = []
    var instructionSequence:[(title:String,color:UIColor, steps:[(step:String, content:String)])] =
        [
            (title:"Presentation / Lecture", color: #colorLiteral(red: 0.2354720533, green: 0.8087568283, blue: 0.4411867857, alpha: 1), steps:[
                (step:"Advance Organizer",content:""),
                //                (step:"Topics",content:""),
                //                (step:"Check Understanding",content:""),
                (step:"Presentation Lecture Content Topic One",content:""),
                (step:"Presentation Lecture Meaningful Activity One",content:""),
                (step:"Presentation Lecture Check Understanding One",content:""),
                (step:"Presentation Lecture Content Topic Two",content:""),
                (step:"Presentation Lecture Meaningful Activity Two",content:""),
                (step:"Presentation Lecture Check Understanding Two",content:""),
                (step:"Presentation Lecture Content Topic Three",content:""),
                (step:"Presentation Lecture Meaningful Activity Three",content:""),
                (step:"Presentation Lecture Check Understanding Three",content:""),
                (step:"Differentiation of Presentation / Lecture",content:""),
                (step:"Formative Assessment of Presentation / Lecture",content:""),]),
            (title:"Direct Instruction",color:#colorLiteral(red: 0.9993317723, green: 0.7410030961, blue: 0.2552615404, alpha: 1), steps:[
                (step:"Direct Instruction",content:""),
                (step:"I Do",content:""),
                (step:"We Do",content:""),
                (step:"You Do Together",content:""),
                (step:"You Do Independent",content:""),
                (step:"Differentiation of Direct Instruction",content:""),
                (step:"Formative Assessment of Direct Instruction",content:""),]),
            (title:"Cooperative Learning",color: #colorLiteral(red: 0.504534483, green: 0.4254741073, blue: 1, alpha: 1), steps:[
                (step:"Present Information",content:""),
                (step:"Organize Teams",content:""),
                (step:"Assist Teams",content:""),
                (step:"Assess Teams",content:""),
                (step:"Provide Recognition",content:""),
                (step:"Differentiation of Cooperative Learning",content:""),
                (step:"Formative Assessment of Cooperative Learning",content:""),]),
            (title:"Classroom Discussion", color:#colorLiteral(red: 1, green: 0.2824433744, blue: 0.2856436968, alpha: 1), steps:[
                (step:"Focus Discussion",content:""),
                (step:"Hold Discussion",content:""),
                (step:"End Discussion",content:""),
                (step:"Debrief Discussion",content:""),
                (step:"Differentiation of Classroom Discussion",content:""),
                (step:"Formative Assessment of Classroom Discussion",content:""),]),
            (title:"5 Es (Science)", color:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), steps:[
                (step:"Engage",content:""),
                (step:"Explore",content:""),
                (step:"Explain",content:""),
                (step:"Elaborate",content:""),
                (step:"Evaluate",content:""),
                (step:"Differentiation of 5 Es",content:""),
                (step:"Formative Assessment of 5 Es",content:""),]),
            (title:"Language Support", color:#colorLiteral(red: 1, green: 0.417430222, blue: 0.6385533214, alpha: 1), steps:[
                (step:"My Language Objective",content:""),
                (step:"Key Vocabulary",content:""),
                (step:"Language Support Content Topic One",content:""),
                (step:"Language Support Meaningful Activity One",content:""),
                (step:"Language Support Check Understanding One",content:""),
                (step:"Language Support Content Topic Two",content:""),
                (step:"Language Support Meaningful Activity Two",content:""),
                (step:"Language Support Check Understanding Two",content:""),
                (step:"Language Support Content Topic Three",content:""),
                (step:"Language Support Meaningful Activity Three",content:""),
                (step:"Language Support Check Understanding Three",content:""),
                (step:"Differentiation of Language Support",content:""),
                (step:"Formative Assessment of Language Support",content:""),])]{
        didSet{
            updateModel()
        }
    }
    var backgroundMaterials:[(title:String,content:String)] = [
        (title:"Learners", content:""),
        (title:"Content", content:""),
        (title:"Rationale for Instructional Model", content:""),
        (title:"Materials", content:"")
        ]{
        didSet{
            updateModel()
        }
    }
    var reminderCardsTextViewContent:[String] = []
    
    init() {
        reminderTitle = ["Teacher's Information \(state["teacherInfoState"]!)",
            "Content Standard \(state["contentSDState"]!)",
            "Learning Objectives \(state["learningObState"]!)",
            "Summative Assessment \(state["summativeState"]!)",
            "Anticipatory Set \(state["anticipatoryState"]!)",
            "Instruction Sequence \(state["instructionState"]!)",
            "Closure \(state["closureState"]!)",
            "Background & Materials \(state["backgroundState"]!)",
            "Lesson Adaptation & Reflective Questions \(state["lessonAdState"]!)"]
        
        reminderCardsTextViewContent = [
            "◎ Teacher's Name: " + "\n" + "◎ Grade: " + "\n" + "◎ Subject: " + "\n" + "◎ Lessont Title: " + "\n" + "◎ Email: ",
            contentStandard,
            "1) " + learningObjectiveOne + "\n" + "2) " + learningObjectiveTwo,
            summativeAssessment,
            "◎ Idea: " + "\n◎ Differentiation: " + "\n◎ Formative: ",
            "",
            "◎ Idea: " + "\n◎ Differentiation: " + "\n◎ Formative: ",
            "◎ Learners: " + "\n◎ Content: " + "\n◎ Rationale for Instructional Model: " + "\n◎ Materials",
            lessonAdaption]
        defaultInstructionSequence = instructionSequence
        
        // whole state
        let wholeStateTitle = [
            "◎ Teacher's Information \n",
            "◎ Content Standard \n",
            "◎ Learning Objectives \n",
            "◎ Summative Assessment \n",
            "◎ Anticipatory Set \n",
            "◎ Instruction Sequence \n",
            "◎ Closure \n",
            "◎ Background & Materials \n",
            "◎ Lesson Adaptation & Reflective Questions \n"]
        let wholeStateTitleContent = [
            "          ◎ Teacher's Name" + "\n" + "          ◎ Grade" + "\n" + "          ◎ Subject" + "\n" + "          ◎ Lessont Title" + "\n",
            "",
            "",
            "",
            "          ◎ Idea" + "\n",
            "          ◎ Model" + "\n",
            "          ◎ Idea" + "\n",
            "          ◎ Materials" + "\n",
            "          ◎ Lesson Adaptation" + "\n" + "          ◎ Reflective Questions"
        ]
        for i in 0..<reminderCardsTextViewContent.count{
            wholeState += wholeStateTitle[i]
            wholeState += wholeStateTitleContent[i]
        }
    }
}

extension Model{
    private func updateTitle(){
        reminderTitle = ["Teacher's Information \(state["teacherInfoState"]!)",
            "Content Standard \(state["contentSDState"]!)",
            "Learning Objectives \(state["learningObState"]!)",
            "Summative Assessment \(state["summativeState"]!)",
            "Anticipatory Set \(state["anticipatoryState"]!)",
            "Instruction Sequence \(state["instructionState"]!)",
            "Closure \(state["closureState"]!)",
            "Background & Materials \(state["backgroundState"]!)",
            "Lesson Adaptation & Reflective Questions \(state["lessonAdState"]!)"]
        
        var counter = 0
        for val in state.values{
            if val == "✅"{
                counter += 1
            }
        }
        lessonPlanCompletion = Int(Double(counter)/Double(state.count)*100)
    }
    private func updateModel(){
        state["teacherInfoState"]! = (name == "" || lessonTitle == "" || subject == "" || grade == "") ? "◎":"✅"
        state["contentSDState"]! = (contentStandard == "") ?  "◎":"✅"
        state["learningObState"]! = (learningObjectiveOne == "" && learningObjectiveTwo == "") ? "◎":"✅"
        state["summativeState"]! = (summativeAssessment == "") ? "◎":"✅"
        state["anticipatoryState"]! = (anticipatorySet == "") ? "◎":"✅"
        state["closureState"]! = (closure == "") ? "◎":"✅"
        state["backgroundState"]! = (backgroundMaterials[3].content == "") ? "◎":"✅"
        state["lessonAdState"]! = (lessonAdaption == "" && reflectiveQuestions == "") ? "◎":"✅"
        
        // update reminder card
        var instructionSequenceContent = ""
        for i in 0..<instructionSequence.count{
            var title = instructionSequence[i].title
            for j in 0..<instructionSequence[i].steps.count{
                if instructionSequence[i].steps[j].content != ""{
                    if title != ""{
                        instructionSequenceContent += title
                        instructionSequenceContent += "\n"
                    }
                    title = ""
                    state["instructionState"]! = "✅"
                    var title = instructionSequence[i].steps[j].step
                    title = (title == "Presentation Lecture Content Topic One") ? "Content Topic" : title
                    title = (title == "Presentation Lecture Content Topic Two") ? "Content Topic" : title
                    title = (title == "Presentation Lecture Content Topic Three") ? "Content Topic" : title
                    title = (title == "Presentation Lecture Meaningful Activity One") ? "Meaningful Activity" : title
                    title = (title == "Presentation Lecture Meaningful Activity Two") ? "Meaningful Activity" : title
                    title = (title == "Presentation Lecture Meaningful Activity Three") ? "Meaningful Activity" : title
                    title = (title == "Presentation Lecture Check Understanding One") ? "Check Understanding" : title
                    title = (title == "Presentation Lecture Check Understanding Two") ? "Check Understanding" : title
                    title = (title == "Presentation Lecture Check Understanding Three") ? "Check Understanding" : title
                    
                    title = (title == "Language Support Content Topic One") ? "Content Topic" : title
                    title = (title == "Language Support Content Topic Two") ? "Content Topic" : title
                    title = (title == "Language Support Content Topic Three") ? "Content Topic" : title
                    title = (title == "Language Support Meaningful Activity One") ? "Meaningful Activity" : title
                    title = (title == "Language Support Meaningful Activity Two") ? "Meaningful Activity" : title
                    title = (title == "Language Support Meaningful Activity Three") ? "Meaningful Activity" : title
                    title = (title == "Language Support Check Understanding One") ? "Check Understanding" : title
                    title = (title == "Language Support Check Understanding Two") ? "Check Understanding" : title
                    title = (title == "Language Support Check Understanding Three") ? "Check Understanding" : title
                    
                    title = (title == "Differentiation of Presentation / Lecture") ? "Differentiation" : title
                    title = (title == "Formative Assessment of Presentation / Lecture") ? "Formative Assessment" : title
                    title = (title == "Differentiation of Direct Instruction") ? "Differentiation" : title
                    title = (title == "Formative Assessment of Direct Instruction") ? "Formative Assessment" : title
                    title = (title == "Differentiation of Cooperative Learning") ? "Differentiation" : title
                    title = (title == "Formative Assessment of Cooperative Learning") ? "Formative Assessment" : title
                    title = (title == "Differentiation of Classroom Discussion") ? "Differentiation" : title
                    title = (title == "Formative Assessment of Classroom Discussion") ? "Formative Assessment" : title
                    title = (title == "Differentiation of 5 Es") ? "Differentiation" : title
                    title = (title == "Formative Assessment of 5 Es") ? "Formative Assessment" : title
                    title = (title == "Differentiation of Language Support") ? "Differentiation" : title
                    title = (title == "Formative Assessment of Language Support") ? "Formative Assessment" : title
                    
                    instructionSequenceContent += ("     ✅" + title + "\n")
                }
            }
        }
        
        // update separate state
        for i in 0..<instructionSequence.count{
            for j in 0..<instructionSequence[i].steps.count{
                if instructionSequence[i].steps[j].content != ""{
                    if (instructionSequenceState[instructionSequence[i].title] != nil){
                        instructionSequenceState[instructionSequence[i].title] = .separated
                    }
                }
            }
        }
        
        // update combined state
        for i in 0..<instructionSequence.count{
            let titles = instructionSequence[i].title.split(separator: "\n")
            if titles.count > 1{
                for title in titles{
                    instructionSequenceState[String(title)] = .combined
                }
            }
        }
        
        // recheck empty from combined
        var titlesNeedToResetToEmpty:[String] = []
        for (key, val) in  instructionSequenceState{
            if val == .combined{
                for i in 0..<instructionSequence.count{
                    // find separated
                    if key == instructionSequence[i].title{
                        var checkEmpty = true
                        for j in 0..<instructionSequence[i].steps.count{
                            if instructionSequence[i].steps[j].content != ""{
                                checkEmpty = false
                            }
                        }
                        if checkEmpty{
                            titlesNeedToResetToEmpty.append(key)
                        }
                    }
                }
            }
        }
        // recheck empty from separate
        for (key, val) in  instructionSequenceState{
            if val == .separated{
                for i in 0..<instructionSequence.count{
                    if key == instructionSequence[i].title{
                        var checkEmpty = true
                        for j in 0..<instructionSequence[i].steps.count{
                            if instructionSequence[i].steps[j].content != ""{
                                checkEmpty = false
                            }
                        }
                        if checkEmpty{
                            titlesNeedToResetToEmpty.append(key)
                        }
                    }
                }
            }
        }
        for title in titlesNeedToResetToEmpty{
            instructionSequenceState[title] = .empty
        }
        
        let _name = (name == "") ? "◎ Teacher's Name:":"✅ Teacher's Name: \(name)"
        let _nameWithoutContent = (name == "") ? "◎ Teacher's Name":"✅ Teacher's Name"
        let _grade = (grade == "") ? "◎ Grade:":"✅ Grade: \(grade)"
        let _gradeWithoutContent = (grade == "") ? "◎ Grade":"✅ Grade"
        let _subject = (subject == "") ? "◎ Subject:":"✅ Subject: \(subject)"
        let _subjectWithoutContent = (subject == "") ? "◎ Subject":"✅ Subject"
        let _lessonTitle = (lessonTitle == "") ? "◎ Lesson Title:":"✅ Lesson Title: \(lessonTitle)"
        let _lessonTitleWithoutContent = (lessonTitle == "") ? "◎ Lesson Title":"✅ Lesson Title"
        let _email = (email == "") ? "◎ Email:":"✅ Email: \(email)"
        let _anticipatorySet = (anticipatorySet == "") ? "◎ Idea:":"✅ Idea: \(anticipatorySet)"
        let _anticipatorySetWithoutContent = (anticipatorySet == "") ? "◎ Idea":"✅ Idea"
        let _anticipatoryDifferentiation = (anticipatoryDifferentiation == "") ? "◎ Differentiation:":"✅ Differentiation: \(anticipatoryDifferentiation)"
        let _anticipatoryFormative = (anticipatoryFormative == "") ? "◎ Formative:":"✅ Formative: \(anticipatoryFormative)"
        let _closure = (closure == "") ? "◎ Idea:":"✅ Idea: \(closure)"
        let _closureWithoutContent = (closure == "") ? "◎ Idea":"✅ Idea"
        let _closureDifferentiation = (closureDifferentiation == "") ? "◎ Differentiation:":"✅ Differentiation: \(closureDifferentiation)"
        let _closureFormative = (closureFormative == "") ? "◎ Formative:":"✅ Formative: \(closureFormative)"
        let _learners = (backgroundMaterials[0].content == "") ? "◎ Learners:":"✅ Learners: \(backgroundMaterials[0].content)"
        let _content = (backgroundMaterials[1].content == "") ? "◎ Content:":"✅ Content: \(backgroundMaterials[1].content)"
        let _rationale = (backgroundMaterials[2].content == "") ? "◎ Rationale:":"✅ Rationale: \(backgroundMaterials[2].content)"
        let _materials = (backgroundMaterials[3].content == "") ? "◎ Materials:":"✅ Materials: \(backgroundMaterials[3].content)"
        let _materialsWithoutContent = (backgroundMaterials[3].content == "") ? "◎ Materials":"✅ Materials"
        let _lessonAdaptation = (lessonAdaption == "") ? "◎ Lesson Adaptation":"✅ Lesson Adaptation: \(lessonAdaption)"
        let _lessonAdaptationWithoutContent = (lessonAdaption == "") ? "◎ Lesson Adaptation":"✅ Lesson Adaptation"
        let _reflectiveQuestions = (reflectiveQuestions == "") ? "◎ Reflective Questions":"✅ Reflective Questions: \(reflectiveQuestions)"
        let _reflectiveQuestionsWithoutContent = (reflectiveQuestions == "") ? "◎ Reflective Questions":"✅ Reflective Questions"
        
        reminderCardsTextViewContent = [_name + "\n" + _grade + "\n" + _subject + "\n" + _lessonTitle + "\n" + _email,
                                        contentStandard,
                                        "1) " + learningObjectiveOne + "\n" + "2) " + learningObjectiveTwo,
                                        summativeAssessment,
                                        _anticipatorySet + "\n" + _anticipatoryDifferentiation + "\n" + _anticipatoryFormative,
                                        instructionSequenceContent,
                                        _closure + "\n" + _closureDifferentiation + "\n" + _closureFormative,
                                        _learners + "\n" + _content + "\n" + _rationale + "\n" + _materials,
                                        _lessonAdaptation + "\n" + _reflectiveQuestions]
        if instructionSequenceContent == "Model: Presentation / Lecture\nModel: Direct Instruction\nModel: Cooperative Learning\nModel: Classroom Discussion\nModel: 5 Es (Science)\nModel: Language Support\n"{
            state["instructionState"]! = "◎"
        }
        
        // update whole state for the whole completion questionmark
        wholeState = ""
        let wholeStateTitle = [
            "\(state["teacherInfoState"]!) Teacher's Information \n",
            "\(state["contentSDState"]!) Content Standard \n",
            "\(state["learningObState"]!) Learning Objectives \n",
            "\(state["summativeState"]!) Summative Assessment \n",
            "\(state["anticipatoryState"]!) Anticipatory Set \n",
            "\(state["instructionState"]!) Instruction Sequence \n",
            "\(state["closureState"]!) Closure \n",
            "\(state["backgroundState"]!) Background & Materials \n",
            "\(state["lessonAdState"]!) Lesson Adaptation & Reflective Questions \n"]
        let wholeStateTitleContent = [
            "          \(_nameWithoutContent)" + "\n" + "          \(_gradeWithoutContent)" + "\n" + "          \(_subjectWithoutContent)" + "\n" + "          \(_lessonTitleWithoutContent)" + "\n",
            "",
            "",
            "",
            "          \(_anticipatorySetWithoutContent)" + "\n",
            "          \(state["instructionState"]!) Model" + "\n",
            "          \(_closureWithoutContent)" + "\n",
            "          \(_materialsWithoutContent)" + "\n",
            "          \(_lessonAdaptationWithoutContent)" + "\n" + "          \(_reflectiveQuestionsWithoutContent)"]
        for i in 0..<reminderCardsTextViewContent.count{
            wholeState += wholeStateTitle[i]
            wholeState += wholeStateTitleContent[i]
        }
    }
    
    // MARK: JSON
    func convertRegularModelToJsonModel(){
        var combinedCounter = 0
        for val in instructionSequenceState.values{
            if val == .combined{
                combinedCounter += 1
            }
        }
        jsonModel.Item?.isCombined = (combinedCounter > 0) ? true:false
        jsonModel.Item?.Presentation_Lecture_State?.S = self.instructionSequenceState["Presentation / Lecture"]!.rawValue
        jsonModel.Item?.Cooperative_Learning_State?.S = self.instructionSequenceState["Cooperative Learning"]!.rawValue
        jsonModel.Item?.Classroom_Discussion_State?.S = self.instructionSequenceState["Classroom Discussion"]!.rawValue
        jsonModel.Item?.Direct_Instruction_State?.S = self.instructionSequenceState[ "Direct Instruction"]!.rawValue
        jsonModel.Item?.FiveEs_State?.S = self.instructionSequenceState["5 Es (Science)"]!.rawValue
        jsonModel.Item?.ELLP_State?.S = self.instructionSequenceState["Language Support"]!.rawValue
        jsonModel.Item?.Name?.S = self.name
        jsonModel.Item?.Grade?.S = self.grade
        jsonModel.Item?.Subject?.S = self.subject
        jsonModel.Item?.LessonTitle?.S = self.lessonTitle
        jsonModel.Item?.Email?.S = self.email
        jsonModel.Item?.ContentStandard?.S = self.contentStandard
        jsonModel.Item?.LearningObjectiveOne?.S = self.learningObjectiveOne
        jsonModel.Item?.LearningObjectiveTwo?.S = self.learningObjectiveTwo
        jsonModel.Item?.Summative_Assessment?.S = self.summativeAssessment
        jsonModel.Item?.Anticipatory_Set?.S = self.anticipatorySet
        jsonModel.Item?.Closure?.S = self.closure
        jsonModel.Item?.Lesson_Adaption?.S = self.lessonAdaption
        jsonModel.Item?.Reflective_Questions?.S = self.reflectiveQuestions
        jsonModel.Item?.Differentiation_of_Anticipatory_Set?.S = self.anticipatoryDifferentiation
        jsonModel.Item?.Formative_Assessment_of_Anticipatory_Set?.S = self.anticipatoryFormative
        jsonModel.Item?.Differentiation_of_Closure?.S = self.closureDifferentiation
        jsonModel.Item?.Formative_Assessment_of_Closure?.S = self.closureFormative
        for i in 0..<instructionSequence.count{
            for j in 0..<instructionSequence[i].steps.count{
                if instructionSequence[i].steps[j].step == "Combined Differentiation"{
                    // 先存到 jsonModel.Item?.Combined_Differentiation?.S
                    jsonModel.Item?.Combined_Differentiation?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到各个 combined title
                    let titles = instructionSequence[i].title.split(separator: "\n")
                    for title in titles{
                        switch title {
                        case "Presentation / Lecture":
                            if jsonModel.Item?.Differentiation_of_Presentation_Lecture?.S == ""{
                                jsonModel.Item?.Differentiation_of_Presentation_Lecture?.S = instructionSequence[i].steps[j].content
                            }
                        case "Direct Instruction":
                            if jsonModel.Item?.Differentiation_of_Direct_Instruction?.S == ""{
                                jsonModel.Item?.Differentiation_of_Direct_Instruction?.S = instructionSequence[i].steps[j].content
                            }
                        case "5 Es (Science)":
                            if jsonModel.Item?.Differentiation_of_5Es?.S == ""{
                                jsonModel.Item?.Differentiation_of_5Es?.S = instructionSequence[i].steps[j].content
                            }
                        case "Cooperative Learning":
                            if jsonModel.Item?.Differentiation_of_Cooperative_Learning?.S == ""{
                                jsonModel.Item?.Differentiation_of_Cooperative_Learning?.S = instructionSequence[i].steps[j].content
                            }
                        case "Classroom Discussion":
                            if jsonModel.Item?.Differentiation_of_Classroom_Discussion?.S == ""{
                                jsonModel.Item?.Differentiation_of_Classroom_Discussion?.S = instructionSequence[i].steps[j].content
                            }
                             
                        case "Language Support":
                            if jsonModel.Item?.Differentiation_of_ELLP?.S == ""{
                                jsonModel.Item?.Differentiation_of_ELLP?.S = instructionSequence[i].steps[j].content
                            }
                        default:
                            print()
                        }
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Formative Assessment"{
                    // 先存到 jsonModel.Item?.Combined_Formative?.S
                    jsonModel.Item?.Combined_Formative?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到各个 combined title
                    let titles = instructionSequence[i].title.split(separator: "\n")
                    for title in titles{
                        switch title {
                        case "Presentation / Lecture":
                            if jsonModel.Item?.Formative_Assessment_of_Presentation_Lecture?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_Presentation_Lecture?.S = instructionSequence[i].steps[j].content
                            }
                        case "Direct Instruction":
                            if jsonModel.Item?.Formative_Assessment_of_Direct_Instruction?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_Direct_Instruction?.S = instructionSequence[i].steps[j].content
                            }
                        case "5 Es (Science)":
                            if jsonModel.Item?.Formative_Assessment_of_5Es?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_5Es?.S = instructionSequence[i].steps[j].content
                            }
                        case "Cooperative Learning":
                            if jsonModel.Item?.Formative_Assessment_of_Cooperative_Learning?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_Cooperative_Learning?.S = instructionSequence[i].steps[j].content
                            }
                        case "Classroom Discussion":
                            if jsonModel.Item?.Formative_Assessment_of_Classroom_Discussion?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_Classroom_Discussion?.S = instructionSequence[i].steps[j].content
                            }
                        case "Language Support":
                            if jsonModel.Item?.Formative_Assessment_of_ELLP?.S == ""{
                                jsonModel.Item?.Formative_Assessment_of_ELLP?.S = instructionSequence[i].steps[j].content
                            }
                        default:
                            print()
                        }
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Content Topic One"{
                    // 先存到 jsonModel.Item?.Combined_Content_Topic_One
                    jsonModel.Item?.Combined_Content_Topic_One?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Content_Topic_One?.S == ""{
                         jsonModel.Item?.Language_Support_Content_Topic_One?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Content Topic Two"{
                    // 先存到 jsonModel.Item?.Combined_Content_Topic_Two
                    jsonModel.Item?.Combined_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Content_Topic_Two?.S == ""{
                        jsonModel.Item?.Language_Support_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Content Topic Three"{
                    // 先存到 jsonModel.Item?.Combined_Content_Topic_Three
                    jsonModel.Item?.Combined_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Content_Topic_Three?.S == ""{
                        jsonModel.Item?.Language_Support_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Meaningful Activity One"{
                    // 先存到 jsonModel.Item?.Combined_Meaningful_Activity_One
                    jsonModel.Item?.Combined_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S == ""{
                         jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S == ""{
                        jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Meaningful Activity Two"{
                    // 先存到 jsonModel.Item?.Combined_Meaningful_Activity_Two
                    jsonModel.Item?.Combined_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S == ""{
                         jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S == ""{
                         jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Meaningful Activity Three"{
                    // 先存到 jsonModel.Item?.Combined_Meaningful_Activity_Three
                    jsonModel.Item?.Combined_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S == ""{
                         jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Check Understanding One"{
                    // 先存到 jsonModel.Item?.Combined_Check_Understanding_One
                    jsonModel.Item?.Combined_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Check_Understanding_One?.S == ""{
                        jsonModel.Item?.Language_Support_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Check Understanding Two"{
                    // 先存到 jsonModel.Item?.Combined_Check_Understanding_Two
                    jsonModel.Item?.Combined_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Check_Understanding_Two?.S == ""{
                        jsonModel.Item?.Language_Support_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
                    }
                }else if instructionSequence[i].steps[j].step == "Combined Check Understanding Three"{
                    // 先存到 jsonModel.Item?.Combined_Check_Understanding_One
                    jsonModel.Item?.Combined_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    // 然后再复制到 Presentation and Language
                    if jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S == ""{
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    }
                    if jsonModel.Item?.Language_Support_Check_Understanding_Three?.S == ""{
                        jsonModel.Item?.Language_Support_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    }
                }else{
                    //                    print(instructionSequence[i].steps[j].step)
                    switch instructionSequence[i].steps[j].step {
                    case "Advance Organizer":
                        jsonModel.Item?.Advance_Organizer?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Content Topic One":
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Content Topic Two":
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Content Topic Three":
                        jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Meaningful Activity One":
                        jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Meaningful Activity Two":
                        jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Meaningful Activity Three":
                        jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Check Understanding One":
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Check Understanding Two":
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
                    case "Presentation Lecture Check Understanding Three":
                        jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    case "Direct Instruction":
                        jsonModel.Item?.Direct_Instruction?.S = instructionSequence[i].steps[j].content
                    case "I Do":
                        jsonModel.Item?.I_Do?.S = instructionSequence[i].steps[j].content
                    case "We Do":
                        jsonModel.Item?.We_Do?.S = instructionSequence[i].steps[j].content
                    case "You Do Together":
                        jsonModel.Item?.You_Do_Together?.S = instructionSequence[i].steps[j].content
                    case "You Do Independent":
                        jsonModel.Item?.You_Do_Independent?.S = instructionSequence[i].steps[j].content
                    case "Present Information":
                        jsonModel.Item?.Present_Information?.S = instructionSequence[i].steps[j].content
                    case "Organize Teams":
                        jsonModel.Item?.Organize_Teams?.S = instructionSequence[i].steps[j].content
                    case "Assist Teams":
                        jsonModel.Item?.Assist_Teams?.S = instructionSequence[i].steps[j].content
                    case "Assess Teams":
                        jsonModel.Item?.Assess_Teams?.S = instructionSequence[i].steps[j].content
                    case "Provide Recognition":
                        jsonModel.Item?.Provide_Recognition?.S = instructionSequence[i].steps[j].content
                    case "Focus Discussion":
                        jsonModel.Item?.Focus_Discussion?.S = instructionSequence[i].steps[j].content
                    case "Hold Discussion":
                        jsonModel.Item?.Hold_Discussion?.S = instructionSequence[i].steps[j].content
                    case "End Discussion":
                        jsonModel.Item?.End_Discussion?.S = instructionSequence[i].steps[j].content
                    case "Debrief Discussion":
                        jsonModel.Item?.Debrief_Discussion?.S = instructionSequence[i].steps[j].content
                    case" Engage":
                        jsonModel.Item?.Engage?.S = instructionSequence[i].steps[j].content
                    case "Explore":
                        jsonModel.Item?.Explore?.S = instructionSequence[i].steps[j].content
                    case "Explain":
                        jsonModel.Item?.Explain?.S = instructionSequence[i].steps[j].content
                    case "Elaborate":
                        jsonModel.Item?.Elaborate?.S = instructionSequence[i].steps[j].content
                    case "Evaluate":
                        jsonModel.Item?.Evaluate?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of Presentation / Lecture":
                        jsonModel.Item?.Differentiation_of_Presentation_Lecture?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of Presentation / Lecture":
                        jsonModel.Item?.Formative_Assessment_of_Presentation_Lecture?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of Direct Instruction":
                        jsonModel.Item?.Differentiation_of_Direct_Instruction?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of Direct Instruction":
                        jsonModel.Item?.Formative_Assessment_of_Direct_Instruction?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of Cooperative Learning":
                        jsonModel.Item?.Differentiation_of_Cooperative_Learning?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of Cooperative Learning":
                        jsonModel.Item?.Formative_Assessment_of_Cooperative_Learning?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of Classroom Discussion":
                        jsonModel.Item?.Differentiation_of_Classroom_Discussion?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of Classroom Discussion":
                        jsonModel.Item?.Formative_Assessment_of_Classroom_Discussion?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of 5 Es":
                        jsonModel.Item?.Differentiation_of_5Es?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of 5 Es":
                        jsonModel.Item?.Formative_Assessment_of_5Es?.S = instructionSequence[i].steps[j].content
                    case "My Language Objective":
                        jsonModel.Item?.My_Language_Objective?.S = instructionSequence[i].steps[j].content
                    case "Key Vocabulary":
                        jsonModel.Item?.Key_Vocabulary?.S = instructionSequence[i].steps[j].content
                    case "Language Support Content Topic One":
                        jsonModel.Item?.Language_Support_Content_Topic_One?.S = instructionSequence[i].steps[j].content
                    case "Language Support Meaningful Activity One":
                        jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
                    case "Language Support Check Understanding One":
                        jsonModel.Item?.Language_Support_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
                    case "Language Support Content Topic Two":
                        jsonModel.Item?.Language_Support_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
                    case "Language Support Meaningful Activity Two":
                        jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
                    case "Language Support Check Understanding Two":
                        jsonModel.Item?.Language_Support_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
                    case "Language Support Content Topic Three":
                        jsonModel.Item?.Language_Support_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
                    case "Language Support Meaningful Activity Three":
                        jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
                    case "Language Support Check Understanding Three":
                        jsonModel.Item?.Language_Support_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    case "Differentiation of Language Support":
                        jsonModel.Item?.Differentiation_of_ELLP?.S = instructionSequence[i].steps[j].content
                    case "Formative Assessment of Language Support":
                        jsonModel.Item?.Formative_Assessment_of_ELLP?.S = instructionSequence[i].steps[j].content
//                    case "Combined Content Topic One":
//                        jsonModel.Item?.Combined_Content_Topic_One?.S = instructionSequence[i].steps[j].content
//                    case "Combined Content Topic Two":
//                        jsonModel.Item?.Combined_Content_Topic_Two?.S = instructionSequence[i].steps[j].content
//                    case "Combined Content Topic Three":
//                        jsonModel.Item?.Combined_Content_Topic_Three?.S = instructionSequence[i].steps[j].content
//                    case "Combined Meaningful Activity One":
//                        jsonModel.Item?.Combined_Meaningful_Activity_One?.S = instructionSequence[i].steps[j].content
//                    case "Combined Meaningful Activity Two":
//                        jsonModel.Item?.Combined_Meaningful_Activity_Two?.S = instructionSequence[i].steps[j].content
//                    case "Combined Meaningful Activity Three":
//                        jsonModel.Item?.Combined_Meaningful_Activity_Three?.S = instructionSequence[i].steps[j].content
//                    case "Combined Check Understanding One":
//                        jsonModel.Item?.Combined_Check_Understanding_One?.S = instructionSequence[i].steps[j].content
//                    case "Combined Check Understanding Two":
//                        jsonModel.Item?.Combined_Check_Understanding_Two?.S = instructionSequence[i].steps[j].content
//                    case "Combined Check Understanding Three":
//                        jsonModel.Item?.Combined_Check_Understanding_Three?.S = instructionSequence[i].steps[j].content
                    default:
                        print()
                    }
                }
            }
        }
        for i in 0..<backgroundMaterials.count{
            switch backgroundMaterials[i].title {
            case "Learners":
                jsonModel.Item?.Learners?.S = backgroundMaterials[i].content
            case "Content":
                jsonModel.Item?.Content?.S = backgroundMaterials[i].content
            case "Materials":
                jsonModel.Item?.Materials?.S = backgroundMaterials[i].content
            case "Rationale for Instructional Model":
                jsonModel.Item?.Rationale_for_Instructional_Model?.S = backgroundMaterials[i].content
            default:
                print()
            }
        }
    }
    
    func convertJsonModelToRegularModel(){
        self.name = jsonModel.Item?.Name?.S ?? ""
        self.grade = jsonModel.Item?.Grade?.S ?? ""
        self.subject = jsonModel.Item?.Subject?.S ?? ""
        self.lessonTitle = jsonModel.Item?.LessonTitle?.S ?? ""
        self.email = jsonModel.Item?.Email?.S ?? ""
        self.contentStandard = jsonModel.Item?.ContentStandard?.S ?? ""
        self.learningObjectiveOne = jsonModel.Item?.LearningObjectiveOne?.S ?? ""
        self.learningObjectiveTwo = jsonModel.Item?.LearningObjectiveTwo?.S ?? ""
        self.summativeAssessment = jsonModel.Item?.Summative_Assessment?.S ?? ""
        self.anticipatorySet = jsonModel.Item?.Anticipatory_Set?.S ?? ""
        self.anticipatoryDifferentiation = jsonModel.Item?.Differentiation_of_Anticipatory_Set?.S ?? ""
        self.anticipatoryFormative = jsonModel.Item?.Formative_Assessment_of_Anticipatory_Set?.S ?? ""
        self.closureDifferentiation = jsonModel.Item?.Differentiation_of_Closure?.S ?? ""
        self.closureFormative = jsonModel.Item?.Formative_Assessment_of_Closure?.S ?? ""
        self.backgroundMaterials[0].content = jsonModel.Item?.Learners?.S ?? ""
        self.backgroundMaterials[1].content = jsonModel.Item?.Content?.S ?? ""
        self.backgroundMaterials[2].content = jsonModel.Item?.Rationale_for_Instructional_Model?.S ?? ""
        self.backgroundMaterials[3].content = jsonModel.Item?.Materials?.S ?? ""
        self.closure = jsonModel.Item?.Closure?.S ?? ""
        self.lessonAdaption = jsonModel.Item?.Lesson_Adaption?.S ?? ""
        self.reflectiveQuestions = jsonModel.Item?.Reflective_Questions?.S ?? ""
        
        if jsonModel.Item?.Presentation_Lecture_State?.S == "combined" ||
            jsonModel.Item?.Direct_Instruction_State?.S == "combined" ||
            jsonModel.Item?.Cooperative_Learning_State?.S == "combined" ||
            jsonModel.Item?.Classroom_Discussion_State?.S == "combined" ||
            jsonModel.Item?.FiveEs_State?.S == "combined" ||
            jsonModel.Item?.ELLP_State?.S == "combined"{
            jsonModel.Item?.isCombined = true
        }else{
            jsonModel.Item?.isCombined = false
        }
        
        if jsonModel.Item!.isCombined!{
            instructionSequence = [(
                title:"",
                color: UIColor.byuhGold,
                steps:[]
                )]
            var stepCounter = 0
            stepCounter += (jsonModel.Item?.Presentation_Lecture_State?.S == "combined") ? 3 : 0
            stepCounter += (jsonModel.Item?.Direct_Instruction_State?.S == "combined") ? 5 : 0
            stepCounter += (jsonModel.Item?.Cooperative_Learning_State?.S == "combined") ? 5 : 0
            stepCounter += (jsonModel.Item?.Classroom_Discussion_State?.S == "combined") ? 4 : 0
            stepCounter += (jsonModel.Item?.FiveEs_State?.S == "combined") ? 5 : 0
            stepCounter += (jsonModel.Item?.Cooperative_Learning_State?.S == "combined") ? 0 : 0
            
            if jsonModel.Item?.Presentation_Lecture_State?.S == "combined" && jsonModel.Item?.ELLP_State?.S == "combined"{
                instructionSequence[0].title += "Presentation / Lecture\n"
                instructionSequence[0].title += "Language Support\n"
                instructionSequence[0].steps.append( (step:"My Language Objective",content:jsonModel.Item?.My_Language_Objective?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Advance Organizer",content:jsonModel.Item?.Advance_Organizer?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Key Vocabulary",content:jsonModel.Item?.Key_Vocabulary?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Content Topic One",content:jsonModel.Item?.Combined_Content_Topic_One?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Meaningful Activity One",content:jsonModel.Item?.Combined_Meaningful_Activity_One?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Check Understanding One",content:jsonModel.Item?.Combined_Check_Understanding_One?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Content Topic Two",content:jsonModel.Item?.Combined_Content_Topic_Two?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Meaningful Activity Two",content:jsonModel.Item?.Combined_Meaningful_Activity_Two?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Check Understanding Two",content:jsonModel.Item?.Combined_Check_Understanding_Two?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combinede Content Topic Three",content:jsonModel.Item?.Combined_Content_Topic_Three?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Meaningful Activity Three",content:jsonModel.Item?.Combined_Meaningful_Activity_Three?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Combined Check Understanding Three",content:jsonModel.Item?.Combined_Check_Understanding_Three?.S ?? ""))
            }else{
                if jsonModel.Item?.Presentation_Lecture_State?.S == "combined"{
                    instructionSequence[0].title += "Presentation / Lecture\n"
                    instructionSequence[0].steps.append( (step:"Advance Organizer",content:jsonModel.Item?.Advance_Organizer?.S ?? ""))
                    //                instructionSequence[0].steps.append( (step:"Topics",content:jsonModel.Item?.Topics?.S ?? ""))
                    //                instructionSequence[0].steps.append( (step:"Check Understanding",content:jsonModel.Item?.Check_Understanding?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Content Topic One",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Meaningful Activity One",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Check Understanding One",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Content Topic Two",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Meaningful Activity Two",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Check Understanding Two",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Content Topic Three",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Meaningful Activity Three",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Presentation Lecture Check Understanding Three",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S ?? ""))
                }
                if jsonModel.Item?.ELLP_State?.S == "combined"{
                    instructionSequence[0].title += "Language Support\n"
                    instructionSequence[0].steps.append( (step:"My Language Objective",content:jsonModel.Item?.My_Language_Objective?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Key Vocabulary",content:jsonModel.Item?.Key_Vocabulary?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Content Topic One",content:jsonModel.Item?.Language_Support_Content_Topic_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Meaningful Activity One",content:jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Check Understanding One",content:jsonModel.Item?.Language_Support_Check_Understanding_One?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Content Topic Two",content:jsonModel.Item?.Language_Support_Content_Topic_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Meaningful Activity Two",content:jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Check Understanding Two",content:jsonModel.Item?.Language_Support_Check_Understanding_Two?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Content Topic Three",content:jsonModel.Item?.Language_Support_Content_Topic_Three?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Meaningful Activity Three",content:jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S ?? ""))
                    instructionSequence[0].steps.append( (step:"Language Support Check Understanding Three",content:jsonModel.Item?.Language_Support_Check_Understanding_Three?.S ?? ""))
                }
            }
            
            if jsonModel.Item?.Direct_Instruction_State?.S == "combined"{
                instructionSequence[0].title += "Direct Instruction\n"
                instructionSequence[0].steps.append( (step:"Direct Instruction",content:jsonModel.Item?.Direct_Instruction?.S ?? ""))
                instructionSequence[0].steps.append( (step:"I Do",content:jsonModel.Item?.I_Do?.S ?? ""))
                instructionSequence[0].steps.append( (step:"We Do",content:jsonModel.Item?.We_Do?.S ?? ""))
                instructionSequence[0].steps.append( (step:"You Do Together",content:jsonModel.Item?.You_Do_Together?.S ?? ""))
                instructionSequence[0].steps.append( (step:"You Do Independent",content:jsonModel.Item?.You_Do_Independent?.S ?? ""))
            }
            if jsonModel.Item?.Cooperative_Learning_State?.S == "combined"{
                instructionSequence[0].title += "Cooperative Learning\n"
                instructionSequence[0].steps.append( (step:"Present Information",content:jsonModel.Item?.Present_Information?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Organize Teams",content:jsonModel.Item?.Organize_Teams?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Assist Teams",content:jsonModel.Item?.Assist_Teams?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Assess Teams",content:jsonModel.Item?.Assess_Teams?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Provide Recognition",content:jsonModel.Item?.Provide_Recognition?.S ?? ""))
            }
            if jsonModel.Item?.Classroom_Discussion_State?.S == "combined"{
                instructionSequence[0].title += "Classroom Discussion\n"
                instructionSequence[0].steps.append( (step:"Focus Discussion",content:jsonModel.Item?.Focus_Discussion?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Hold Discussion",content:jsonModel.Item?.Hold_Discussion?.S ?? ""))
                instructionSequence[0].steps.append( (step:"End Discussion",content:jsonModel.Item?.End_Discussion?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Debrief Discussion",content:jsonModel.Item?.Debrief_Discussion?.S ?? ""))
            }
            if jsonModel.Item?.FiveEs_State?.S == "combined"{
                instructionSequence[0].title += "5 Es (Science)\n"
                instructionSequence[0].steps.append( (step:"Engage",content:jsonModel.Item?.Engage?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Explore",content:jsonModel.Item?.Explore?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Explain",content:jsonModel.Item?.Explain?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Elaborate",content:jsonModel.Item?.Elaborate?.S ?? ""))
                instructionSequence[0].steps.append( (step:"Evaluate",content:jsonModel.Item?.Evaluate?.S ?? ""))
            }
            
            // 去除最后一位 /n
            if instructionSequence[0].title != ""{
                instructionSequence[0].title.remove(at: instructionSequence[0].title.index(before: instructionSequence[0].title.endIndex))
            }
            instructionSequence[0].steps.append( (step:"Combined Differentiation",content:jsonModel.Item?.Combined_Differentiation?.S ?? ""))
            instructionSequence[0].steps.append( (step:"Combined Formative Assessment",content:jsonModel.Item?.Combined_Formative?.S ?? ""))
            
            if jsonModel.Item?.Presentation_Lecture_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "Presentation / Lecture",
                        color: #colorLiteral(red: 0.2354720533, green: 0.8087568283, blue: 0.4411867857, alpha: 1),
                        steps:[
                            (step:"Advance Organizer",content:jsonModel.Item?.Advance_Organizer?.S ?? ""),
                            //                        (step:"Topics",content:jsonModel.Item?.Topics?.S ?? ""),
                            //                        (step:"Check Understanding",content:jsonModel.Item?.Check_Understanding?.S ?? ""),
                            (step:"Presentation Lecture Content Topic One",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S ?? ""),
                            (step:"Presentation Lecture Meaningful Activity One",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S ?? ""),
                            (step:"Presentation Lecture Check Understanding One",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S ?? ""),
                            (step:"Presentation Lecture Content Topic Two",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S ?? ""),
                            (step:"Presentation Lecture Meaningful Activity Two",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S ?? ""),
                            (step:"Presentation Lecture Check Understanding Two",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S ?? ""),
                            (step:"Presentation Lecture Content Topic Three",content:jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S ?? ""),
                            (step:"Presentation Lecture Meaningful Activity Three",content:jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S ?? ""),
                            (step:"Presentation Lecture Check Understanding Three",content:jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S ?? ""),
                            (step:"Differentiation of Presentation / Lecture",content:jsonModel.Item?.Differentiation_of_Presentation_Lecture?.S ?? ""),
                            (step:"Formative Assessment of Presentation / Lecture",content:jsonModel.Item?.Formative_Assessment_of_Presentation_Lecture?.S ?? "")]
                    )
                )
            }
            if jsonModel.Item?.Direct_Instruction_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "Direct Instruction",
                        color: #colorLiteral(red: 0.9993317723, green: 0.7410030961, blue: 0.2552615404, alpha: 1),
                        steps:[
                            (step:"Direct Instruction",content:jsonModel.Item?.Direct_Instruction?.S ?? ""),
                            (step:"I Do",content:jsonModel.Item?.I_Do?.S ?? ""),
                            (step:"We Do",content:jsonModel.Item?.We_Do?.S ?? ""),
                            (step:"You Do Together",content:jsonModel.Item?.You_Do_Together?.S ?? ""),
                            (step:"You Do Independent",content:jsonModel.Item?.You_Do_Independent?.S ?? ""),
                            (step:"Differentiation of Direct Instruction",content:jsonModel.Item?.Differentiation_of_Direct_Instruction?.S ?? ""),
                            (step:"Formative Assessment of Direct Instruction",content:jsonModel.Item?.Formative_Assessment_of_Direct_Instruction?.S ?? "")]
                    )
                )
            }
            if jsonModel.Item?.Cooperative_Learning_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "Cooperative Learning",
                        color: #colorLiteral(red: 0.504534483, green: 0.4254741073, blue: 1, alpha: 1),
                        steps:[
                            (step:"Present Information",content:jsonModel.Item?.Present_Information?.S ?? ""),
                            (step:"Organize Teams",content:jsonModel.Item?.Organize_Teams?.S ?? ""),
                            (step:"Assist Teams",content:jsonModel.Item?.Assist_Teams?.S ?? ""),
                            (step:"Assess Teams",content:jsonModel.Item?.Assess_Teams?.S ?? ""),
                            (step:"Provide Recognition",content:jsonModel.Item?.Provide_Recognition?.S ?? ""),
                            (step:"Differentiation of Cooperative Learning",content:jsonModel.Item?.Differentiation_of_Cooperative_Learning?.S ?? ""),
                            (step:"Formative Assessment of Cooperative Learning",content:jsonModel.Item?.Formative_Assessment_of_Cooperative_Learning?.S ?? "")]
                    )
                )
            }
            if jsonModel.Item?.Classroom_Discussion_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "Classroom Discussion",
                        color: #colorLiteral(red: 1, green: 0.2824433744, blue: 0.2856436968, alpha: 1),
                        steps:[
                            (step:"Focus Discussion",content:jsonModel.Item?.Focus_Discussion?.S ?? ""),
                            (step:"Hold Discussion",content:jsonModel.Item?.Hold_Discussion?.S ?? ""),
                            (step:"End Discussion",content:jsonModel.Item?.End_Discussion?.S ?? ""),
                            (step:"Debrief Discussion",content:jsonModel.Item?.Debrief_Discussion?.S ?? ""),
                            (step:"Differentiation of Classroom Discussion",content:jsonModel.Item?.Differentiation_of_Classroom_Discussion?.S ?? ""),
                            (step:"Formative Assessment of Classroom Discussion",content:jsonModel.Item?.Formative_Assessment_of_Classroom_Discussion?.S ?? "")]
                    )
                )
            }
            if jsonModel.Item?.FiveEs_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "5 Es (Science)",
                        color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                        steps:[
                            (step:"Engage",content:jsonModel.Item?.Engage?.S ?? ""),
                            (step:"Explore",content:jsonModel.Item?.Explore?.S ?? ""),
                            (step:"Explain",content:jsonModel.Item?.Explain?.S ?? ""),
                            (step:"Elaborate",content:jsonModel.Item?.Elaborate?.S ?? ""),
                            (step:"Evaluate",content:jsonModel.Item?.Evaluate?.S ?? ""),
                            (step:"Differentiation of 5 Es",content:jsonModel.Item?.Differentiation_of_5Es?.S ?? ""),
                            (step:"Formative Assessment of 5 Es",content:jsonModel.Item?.Formative_Assessment_of_5Es?.S ?? "")]
                    )
                )
            }
            if jsonModel.Item?.ELLP_State?.S != "combined"{
                instructionSequence.append(
                    (
                        title: "Language Support",
                        color: #colorLiteral(red: 1, green: 0.417430222, blue: 0.6385533214, alpha: 1),
                        steps:[
                            (step:"My Language Objective",content:jsonModel.Item?.My_Language_Objective?.S ?? ""),
                            (step:"Key Vocabulary",content:jsonModel.Item?.Key_Vocabulary?.S ?? ""),
                            (step:"Language Support Content Topic One",content:jsonModel.Item?.Language_Support_Content_Topic_One?.S ?? ""),
                            (step:"Language Support Meaningful Activity One",content:jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S ?? ""),
                            (step:"Language Support Check Understanding One",content:jsonModel.Item?.Language_Support_Check_Understanding_One?.S ?? ""),
                            (step:"Language Support Content Topic Two",content:jsonModel.Item?.Language_Support_Content_Topic_Two?.S ?? ""),
                            (step:"Language Support Meaningful Activity Two",content:jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S ?? ""),
                            (step:"Language Support Check Understanding Two",content:jsonModel.Item?.Language_Support_Check_Understanding_Two?.S ?? ""),
                            (step:"Language Support Content Topic Three",content:jsonModel.Item?.Language_Support_Content_Topic_Three?.S ?? ""),
                            (step:"Language Support Meaningful Activity Three",content:jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S ?? ""),
                            (step:"Language Support Check Understanding Three",content:jsonModel.Item?.Language_Support_Check_Understanding_Three?.S ?? ""),
                            (step:"Differentiation of Language Support",content:jsonModel.Item?.Differentiation_of_ELLP?.S ?? ""),
                            (step:"Formative Assessment of Language Support",content:jsonModel.Item?.Formative_Assessment_of_ELLP?.S ?? "")]
                    )
                )
            }
        }else{
            instructionSequence[0].steps[0].content = jsonModel.Item?.Advance_Organizer?.S ?? ""
            //            instructionSequence[0].steps[1].content = jsonModel.Item?.Topics?.S ?? ""
            //            instructionSequence[0].steps[2].content = jsonModel.Item?.Check_Understanding?.S ?? ""
            instructionSequence[0].steps[1].content = jsonModel.Item?.Presentation_Lecture_Content_Topic_One?.S ?? ""
            instructionSequence[0].steps[2].content = jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_One?.S ?? ""
            instructionSequence[0].steps[3].content = jsonModel.Item?.Presentation_Lecture_Check_Understanding_One?.S ?? ""
            instructionSequence[0].steps[4].content = jsonModel.Item?.Presentation_Lecture_Content_Topic_Two?.S ?? ""
            instructionSequence[0].steps[5].content = jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Two?.S ?? ""
            instructionSequence[0].steps[6].content = jsonModel.Item?.Presentation_Lecture_Check_Understanding_Two?.S ?? ""
            instructionSequence[0].steps[7].content = jsonModel.Item?.Presentation_Lecture_Content_Topic_Three?.S ?? ""
            instructionSequence[0].steps[8].content = jsonModel.Item?.Presentation_Lecture_Meaningful_Activity_Three?.S ?? ""
            instructionSequence[0].steps[9].content = jsonModel.Item?.Presentation_Lecture_Check_Understanding_Three?.S ?? ""
            instructionSequence[0].steps[10].content = jsonModel.Item?.Differentiation_of_Presentation_Lecture?.S ?? ""
            instructionSequence[0].steps[11].content = jsonModel.Item?.Formative_Assessment_of_Presentation_Lecture?.S ?? ""
            
            instructionSequence[1].steps[0].content = jsonModel.Item?.Direct_Instruction?.S ?? ""
            instructionSequence[1].steps[1].content = jsonModel.Item?.I_Do?.S ?? ""
            instructionSequence[1].steps[2].content = jsonModel.Item?.We_Do?.S ?? ""
            instructionSequence[1].steps[3].content = jsonModel.Item?.You_Do_Together?.S ?? ""
            instructionSequence[1].steps[4].content = jsonModel.Item?.You_Do_Independent?.S ?? ""
            instructionSequence[1].steps[5].content = jsonModel.Item?.Differentiation_of_Direct_Instruction?.S ?? ""
            instructionSequence[1].steps[6].content = jsonModel.Item?.Formative_Assessment_of_Direct_Instruction?.S ?? ""
            
            instructionSequence[2].steps[0].content = jsonModel.Item?.Present_Information?.S ?? ""
            instructionSequence[2].steps[1].content = jsonModel.Item?.Organize_Teams?.S ?? ""
            instructionSequence[2].steps[2].content = jsonModel.Item?.Assist_Teams?.S ?? ""
            instructionSequence[2].steps[3].content = jsonModel.Item?.Assess_Teams?.S ?? ""
            instructionSequence[2].steps[4].content = jsonModel.Item?.Provide_Recognition?.S ?? ""
            instructionSequence[2].steps[5].content = jsonModel.Item?.Differentiation_of_Cooperative_Learning?.S ?? ""
            instructionSequence[2].steps[6].content = jsonModel.Item?.Formative_Assessment_of_Cooperative_Learning?.S ?? ""
            
            instructionSequence[3].steps[0].content = jsonModel.Item?.Focus_Discussion?.S ?? ""
            instructionSequence[3].steps[1].content = jsonModel.Item?.Hold_Discussion?.S ?? ""
            instructionSequence[3].steps[2].content = jsonModel.Item?.End_Discussion?.S ?? ""
            instructionSequence[3].steps[3].content = jsonModel.Item?.Debrief_Discussion?.S ?? ""
            instructionSequence[3].steps[4].content = jsonModel.Item?.Differentiation_of_Classroom_Discussion?.S ?? ""
            instructionSequence[3].steps[5].content = jsonModel.Item?.Formative_Assessment_of_Classroom_Discussion?.S ?? ""
            
            instructionSequence[4].steps[0].content = jsonModel.Item?.Engage?.S ?? ""
            instructionSequence[4].steps[1].content = jsonModel.Item?.Explore?.S ?? ""
            instructionSequence[4].steps[2].content = jsonModel.Item?.Explain?.S ?? ""
            instructionSequence[4].steps[3].content = jsonModel.Item?.Elaborate?.S ?? ""
            instructionSequence[4].steps[4].content = jsonModel.Item?.Evaluate?.S ?? ""
            instructionSequence[4].steps[5].content = jsonModel.Item?.Differentiation_of_5Es?.S ?? ""
            instructionSequence[4].steps[6].content = jsonModel.Item?.Formative_Assessment_of_5Es?.S ?? ""
            
            instructionSequence[5].steps[0].content = jsonModel.Item?.My_Language_Objective?.S ?? ""
            instructionSequence[5].steps[1].content = jsonModel.Item?.Key_Vocabulary?.S ?? ""
            instructionSequence[5].steps[2].content = jsonModel.Item?.Language_Support_Content_Topic_One?.S ?? ""
            instructionSequence[5].steps[3].content = jsonModel.Item?.Language_Support_Meaningful_Activity_One?.S ?? ""
            instructionSequence[5].steps[4].content = jsonModel.Item?.Language_Support_Check_Understanding_One?.S ?? ""
            instructionSequence[5].steps[5].content = jsonModel.Item?.Language_Support_Content_Topic_Two?.S ?? ""
            instructionSequence[5].steps[6].content = jsonModel.Item?.Language_Support_Meaningful_Activity_Two?.S ?? ""
            instructionSequence[5].steps[7].content = jsonModel.Item?.Language_Support_Check_Understanding_Two?.S ?? ""
            instructionSequence[5].steps[8].content = jsonModel.Item?.Language_Support_Content_Topic_Three?.S ?? ""
            instructionSequence[5].steps[9].content = jsonModel.Item?.Language_Support_Meaningful_Activity_Three?.S ?? ""
            instructionSequence[5].steps[10].content = jsonModel.Item?.Language_Support_Check_Understanding_Three?.S ?? ""
            instructionSequence[5].steps[11].content = jsonModel.Item?.Differentiation_of_ELLP?.S ?? ""
            instructionSequence[5].steps[12].content = jsonModel.Item?.Formative_Assessment_of_ELLP?.S ?? ""
        }
    }
}




