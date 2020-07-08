//
//  ObjectiveModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/8/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

class ObjectiveModel{
    let verbs = ["Knowledge": ["Count", "Define", "Describe","Enumerate","Find","Identify","Label","List","Match","Name","Read","Recall","Recite","Record","Reproduce","Select","Sequence","State","View","Write"],
    "Comprehension": ["Classify","Cite", "Conclude","Describe","Discuss","Estimate","Explain","Generalize","Give examples","Illustate","Interpret","Locate","Make sense of","Paraphrase","Predict","Report","Restate","Review","Summarize","Trace"],
    "Application":["Assess", "Change", "Chart","Choose","Compute","Construct", "Demonstrate", "Determine","Develop","Establish","Instruct","Predict","Prepare","Produce","Relate","Report","Select","Show","Solve","Use"],
    "Analysis": ["Analyze","Break Down", "Characterize", "Classify","Compare","Contrast","Correlate","Diagram","Differentiate","Discriminate","Distinguish","Examine","Illustrate","Infer","Limit","Outline","Point out","Prioritize","Relate","Separate","Subdivide"],
    "Synthesis": ["Adapt", "Categorize", "Compose","Construct","Create","Design","Formulate","Generate","Incorporate","Integrate","Invent","Modify","Organize","Perform","Produce","Propose","Reinforce","Reorganize","Rewrite","Structure"],
    "Evaluation": ["Appraise", "Argue", "Asses","Choose","Compare & Contrast","Conclude","Critique","Decide","Defend","Evaluate","Interpret","Judge","Justify","Predict","Prioritize","Prove","Rank","Rate","Reframe","Support"]]
    var popupTitleOnRoadMap = "Welcome to the Help Popup!"
    var popupContentOnRoadMap = "Use this road map to navigate directly to sections of your lesson plan."
    
    var popupTitleOnWhat = ["What is the Learning Objective?","Explanation / Example:"]
    var popupContentOnWhat = [
        "Also known as the Learning Outcome. The Learning Objective is a specific statement to describe the significant learning in today’s lesson. Two main parts should be included in every Learning Objective 1) a specific learning verb, and 2) a statement of how well students will learn it. Most lessons only have one or two good Learning Objectives.",
        "Your Learning Objective is specific statement to describe what your students will learn by the end of your lesson and how well they will learn it. This means you need to use specific verbs (see Bloom’s taxonomy of learning verbs) to describe the learning. Your Learning Objective should be MEASUREABLE – you have some way to measure the proficiency of your students in meeting the objective. Your Learning Objective must be MANAGEABLE – you are able to teach the objectives in one lesson (Unit objectives are different than Learning Objective). Your Learning Objective must be OBSERVABLE – you have evidence at the end of your lesson showing how well the students achieved the Learning Objective. BAD EXAMPLE – “Students can know how to write a good paragraph.” Problem is ‘know’ cannot be measured. How well will the students ‘know?’ How will the students show the teacher they ‘know?’ Plus, what does ‘good’ mean? Kind of good? Really good? Good for me? Good for you? BETTER EXAMPLE – “Students can write an argument paragraph using a topic sentence, four supporting details, and a conclusion with 100% accuracy.” This Learning Objective tells us that the students can write a correct topic sentence, four specific supporting details, and include a conclusion. This Learning Objective is measurable and observable because the teacher will have a piece of paper in hand with the paragraph written on it. The teacher can see if the student included the topic sentence, four supporting details, and a conclusion. This Learning Objective also tells HOW WELL the students are expected to write – 100%. Remember, the Learning Objective must say WHAT the student can do (precise verb –see Bloom’s verbs) and HOW WELL the student can do it (the level of accuracy – 100%, 30%)."
    ]
    
    var popupTitleNextToPercentage = "My Lesson Plan Required Information"
    var popupContentNextToPercentage = "This is an explanation of this percentage"
}
