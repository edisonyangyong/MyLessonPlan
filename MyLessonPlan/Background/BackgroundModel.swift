//
//  BackgroundModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/28/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

class BackgroundModel{
    var questionList:[(title:[String], content:[String])] = [
        (title:[
            "What is the Learner’s Background?",
            "Explanation / Example:"],
         content:[
            "The Learner’s Background is a description of your learners, which will help you meet the needs of all your students.",
            "This paragraph should be 6 – 8 sentences describing the learners in your classroom, especially the diversity, age group, grade level, cultural backgrounds, etc. AND what they already may know about the content you are teaching, i.e., What lessons have they had prior to this lesson that might help the teacher know the academic level of the students regarding this content? As a teacher, you must be familiar with your students: who they are, what they know, their interests and backgrounds, family situations, etc. Do any students have IEPs, free or reduced lunch, 504? Your knowledge and awareness of all these details will contribute to the accuracy and detail of your lesson preparation so that you will teach an effective lesson and the students will achieve the desired outcomes. Effective teachers think about these sorts of things. Use this information to guide your lesson planning and teaching."]
        ),
        (title:[
            "What is the Content Background?",
            "Explanation / Example:"],
         content:["The Content Background is a description of the lesson content and how it fits with previous learning and future learning.",
                  "This paragraph should be 6 – 8 sentences describing the content you will be teaching AND why this content is important for your learners to learn. You want your learners to achieve and become proficient in this content. Why? Why do they need to know this stuff? How will this stuff help them in their future school and life? If you can’t thoughtfully answer these questions about the content, don’t teach it. In addition, what do your students already know about the content? Is this a review or brand new material? Your knowledge and awareness of all these details will contribute to the accuracy and detail of your lesson preparation so that you will teach an effective lesson and the students will achieve the desired outcomes. Effective teachers think about these sorts of things. Use this information to guide you in your lesson planning and teaching."]
        ),
        (title:[
            "What is the Instructional Model Background?",
            "Explanation / Example:"],
         content:[
            "The Instructional Model Background is a description of the rationale for using the specific instruction model or models to teach this lesson.",
            "This paragraph should be 6 – 8 paragraphs describing the instructional model you are using AND why you are using it. Each instructional model has a different purpose. You must know the purpose for each instructional model if you are to use it effectively. Why are you using this instructional model? Why not use a different instructional model? This paragraph is NOT to describe what you are going to teach and how you are going to teach it. This paragraph focuses only on a description and rationale for using this instructional model(s). If you are combining instructional models, i.e., a Presentation (Lecture) and Classroom Discussion, explain your rationale. Your knowledge and awareness of all these details will contribute to the accuracy and detail of your lesson preparation so that you will teach an effective lesson and the students will achieve the desired outcomes. Effective teachers think about these sorts of things. Use this information to guide you in your lesson planning and teaching."
            ]),
        (title:[
           "What is Materials?",
           ""],
        content:[
           "",
           ""
           ])
    ]
    
    var popupTitleOnRoadMap = "Welcome to the Help Popup!"
    var popupContentOnRoadMap = "Use this road map to navigate directly to sections of your lesson plan."
    
    var popupTitleOnWhat = "Welcome to the Help Popup!"
    var popupContentOnWhat = "what is Background & Materials"
    
    var popupTitleNextToPercentage = "My Lesson Plan Required Information"
}
