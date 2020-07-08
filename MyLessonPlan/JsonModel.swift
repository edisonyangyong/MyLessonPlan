//
//  JsonModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/8/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

struct JsonModel:Codable{
    var json:Data?{
        return try? JSONEncoder().encode(self)
    }
    
    init?(json:Data){
        if let newValue = try? JSONDecoder().decode(JsonModel.self, from: json){
            self = newValue
        }else{
            return nil
        }
    }
    
    init() {
         Item = lessonplanItem_info(
            isCombined: false,
            Date: Date_info(S: ""),
            Name: Name_info(S: ""),
            Grade: Grade_info(S:  ""),
            Subject: Subject_info(S:  ""),
            LessonTitle: LessonTitle_info(S:  ""),
            Email: Email_info(S:  ""),
            ContentStandard : ContentStandard_info(S:  ""),
            LearningObjectiveOne : LearningObjective_One_info(S:  ""),
            LearningObjectiveTwo : LearningObjectiveTwo_info(S:  ""),
            Summative_Assessment : Summative_Assessment_info(S:  ""),
            Anticipatory_Set : Anticipatory_Set_info(S:  ""),
            Differentiation_of_Anticipatory_Set : Differentiation_of_Anticipatory_Set_info(S:  ""),
            Formative_Assessment_of_Anticipatory_Set : Formative_Assessment_of_Anticipatory_Set_info(S:  ""),
            Differentiation_of_Closure : Differentiation_of_Closure_info(S:  ""),
            Formative_Assessment_of_Closure : Formative_Assessment_of_Closure_info(S:  ""),
            Presentation_Lecture_State : Presentation_Lecture_State_info(S:  "empty"),
            Direct_Instruction_State : Direct_Instruction_State_info(S:  "empty"),
            Cooperative_Learning_State : Cooperative_Learning_State_info(S:  "empty"),
            Classroom_Discussion_State : Classroom_Discussion_State_info(S:  "empty"),
            FiveEs_State : FiveEs_State_info(S:  "empty"),
            ELLP_State : ELLP_State_info(S:  "empty"),
            Differentiation_of_Presentation_Lecture : Differentiation_of_Presentation_Lecture_info(S:  ""),
            Formative_Assessment_of_Presentation_Lecture : Formative_Assessment_of_Presentation_Lecture_info(S:  ""),
            Differentiation_of_Direct_Instruction : Differentiation_of_Direct_Instruction_info(S:  ""),
            Formative_Assessment_of_Direct_Instruction : Formative_Assessment_of_Direct_Instruction_info(S:  ""),
            Differentiation_of_Cooperative_Learning : Differentiation_of_Cooperative_Learning_info(S:  ""),
            Formative_Assessment_of_Cooperative_Learning : Formative_Assessment_of_Cooperative_Learning_info(S:  ""),
            Differentiation_of_Classroom_Discussion : Differentiation_of_Classroom_Discussion_info(S:  ""),
            Formative_Assessment_of_Classroom_Discussion : Formative_Assessment_of_Classroom_Discussion_info(S:  ""),
            Differentiation_of_5Es : Differentiation_of_5Es_info(S:  ""),
            Formative_Assessment_of_5Es : Formative_Assessment_of_5Es_info(S:  ""),
            Differentiation_of_ELLP : Differentiation_of_ELLP_info(S:  ""),
            Formative_Assessment_of_ELLP : Formative_Assessment_of_ELLP_info(S:  ""),
            Advance_Organizer : Advance_Organizer_info(S:  ""),
            Direct_Instruction : Direct_Instruction_info(S:  ""),
            I_Do : I_Do_info(S:  ""),
            We_Do : We_Do_info(S:  ""),
            You_Do_Together : You_Do_Together_info(S:  ""),
            You_Do_Independent : You_Do_Independent_info(S:  ""),
            Present_Information : Present_Information_info(S:  ""),
            Organize_Teams : Organize_Teams_info(S:  ""),
            Assist_Teams : Assist_Teams_info(S:  ""),
            Assess_Teams : Assess_Teams_info(S:  ""),
            Provide_Recognition : Provide_Recognition_info(S:  ""),
            Focus_Discussion : Focus_Discussion_info(S:  ""),
            Hold_Discussion : Hold_Discussion_info(S: ""),
            End_Discussion : End_Discussion_info(S:  ""),
            Debrief_Discussion : Debrief_Discussion_info(S:  ""),
            Engage : Engage_info(S:  ""),
            Explore : Explore_info(S:  ""),
            Explain : Explain_info(S: ""),
            Elaborate : Elaborate_info(S:  ""),
            Evaluate : Evaluate_info(S:  ""),
            My_Language_Objective : My_Language_Objective_info(S:  ""),
            Key_Vocabulary : Key_Vocabulary_info(S:  ""),
            Closure : Closure_info(S:  ""),
            Reflective_Questions : Reflective_Questions_info(S:  ""),
            Lesson_Adaption : Lesson_Adaption_info(S:  ""),
            Learners : Learners_info(S:  ""),
            Content : Content_info(S:  ""),
            Materials : Materials_info(S:  ""),
            Rationale_for_Instructional_Model : Rationale_for_Instructional_Model_info(S:  ""),
            Combined_Differentiation : Combined_Differentiation_info(S:  ""),
            Combined_Formative : Combined_Formative_info(S:  ""),
            Presentation_Lecture_Content_Topic_One: Presentation_Lecture_Content_Topic_One_info(S:  ""),
            Presentation_Lecture_Content_Topic_Two:Presentation_Lecture_Content_Topic_Two_info(S:  ""),
            Presentation_Lecture_Content_Topic_Three:Presentation_Lecture_Content_Topic_Three_info(S:  ""),
            Presentation_Lecture_Meaningful_Activity_One:Presentation_Lecture_Meaningful_Activity_One_info(S:  ""),
            Presentation_Lecture_Meaningful_Activity_Two: Presentation_Lecture_Meaningful_Activity_Two_info(S:  ""),
            Presentation_Lecture_Meaningful_Activity_Three:Presentation_Lecture_Meaningful_Activity_Three_info(S:  ""),
            Presentation_Lecture_Check_Understanding_One:Presentation_Lecture_Check_Understanding_One_info(S:  ""),
            Presentation_Lecture_Check_Understanding_Two: Presentation_Lecture_Check_Understanding_Two_info(S:  ""),
            Presentation_Lecture_Check_Understanding_Three:Presentation_Lecture_Check_Understanding_Three_info(S:  ""),
            Language_Support_Content_Topic_One: Language_Support_Content_Topic_One_info(S:  ""),
            Language_Support_Content_Topic_Two:Language_Support_Content_Topic_Two_info(S:  ""),
            Language_Support_Content_Topic_Three:Language_Support_Content_Topic_Three_info(S:  ""),
            Language_Support_Meaningful_Activity_One:Language_Support_Meaningful_Activity_One_info(S:  ""),
            Language_Support_Meaningful_Activity_Two: Language_Support_Meaningful_Activity_Two_info(S:  ""),
            Language_Support_Meaningful_Activity_Three:Language_Support_Meaningful_Activity_Three_info(S:  ""),
            Language_Support_Check_Understanding_One:Language_Support_Check_Understanding_One_info(S:  ""),
            Language_Support_Check_Understanding_Two: Language_Support_Check_Understanding_Two_info(S:  ""),
            Language_Support_Check_Understanding_Three:Language_Support_Check_Understanding_Three_info(S:  ""),
            
            Combined_Content_Topic_One: Combined_Content_Topic_One_info(S:  ""),
            Combined_Content_Topic_Two:Combined_Content_Topic_Two_info(S:  ""),
            Combined_Content_Topic_Three:Combined_Content_Topic_Three_info(S:  ""),
            Combined_Meaningful_Activity_One:Combined_Meaningful_Activity_One_info(S:  ""),
            Combined_Meaningful_Activity_Two: Combined_Meaningful_Activity_Two_info(S:  ""),
            Combined_Meaningful_Activity_Three:Combined_Meaningful_Activity_Three_info(S:  ""),
            Combined_Check_Understanding_One:Combined_Check_Understanding_One_info(S:  ""),
            Combined_Check_Understanding_Two: Combined_Check_Understanding_Two_info(S:  ""),
            Combined_Check_Understanding_Three:Combined_Check_Understanding_Three_info(S:  ""),
            
            // for save back
            Content_Delivery_One : Content_Delivery_One_info(S:  ""),
            Meaningful_Activity_One : Meaningful_Activity_One_info(S:  ""),
            Content_Delivery_Two : Content_Delivery_Two_info(S:  ""),
            Meaningful_Activity_Two : Meaningful_Activity_Two_info(S:  ""),
            Content_Delivery_Three : Content_Delivery_Three_info(S:  ""),
            Meaningful_Activity_Three : Meaningful_Activity_Three_info(S:  ""),
            Check_Understanding : Check_Understanding_info(S:  ""),
            Topics : Topics_info(S:  "")
        )
    }
    
    var Item:lessonplanItem_info?
    
    struct lessonplanItem_info:Codable {
        var isCombined:Bool?
        var Date:Date_info?
        var Name: Name_info?
        var Grade: Grade_info?
        var Subject: Subject_info?
        var LessonTitle: LessonTitle_info?
        var Email:Email_info?
        var ContentStandard:ContentStandard_info?
        var LearningObjectiveOne:LearningObjective_One_info?
        var LearningObjectiveTwo:LearningObjectiveTwo_info?
        var Summative_Assessment:Summative_Assessment_info?
        var Anticipatory_Set:Anticipatory_Set_info?
        var Differentiation_of_Anticipatory_Set:Differentiation_of_Anticipatory_Set_info?
        var Formative_Assessment_of_Anticipatory_Set:Formative_Assessment_of_Anticipatory_Set_info?
        var Differentiation_of_Closure:Differentiation_of_Closure_info?
        var Formative_Assessment_of_Closure:Formative_Assessment_of_Closure_info?
        var Presentation_Lecture_State:Presentation_Lecture_State_info?
        var Direct_Instruction_State:Direct_Instruction_State_info?
        var Cooperative_Learning_State:Cooperative_Learning_State_info?
        var Classroom_Discussion_State:Classroom_Discussion_State_info?
        var FiveEs_State:FiveEs_State_info?
        var ELLP_State:ELLP_State_info?
        var Differentiation_of_Presentation_Lecture:Differentiation_of_Presentation_Lecture_info?
        var Formative_Assessment_of_Presentation_Lecture:Formative_Assessment_of_Presentation_Lecture_info?
        var Differentiation_of_Direct_Instruction:Differentiation_of_Direct_Instruction_info?
        var Formative_Assessment_of_Direct_Instruction:Formative_Assessment_of_Direct_Instruction_info?
        var Differentiation_of_Cooperative_Learning:Differentiation_of_Cooperative_Learning_info?
        var Formative_Assessment_of_Cooperative_Learning:Formative_Assessment_of_Cooperative_Learning_info?
        var Differentiation_of_Classroom_Discussion:Differentiation_of_Classroom_Discussion_info?
        var Formative_Assessment_of_Classroom_Discussion:Formative_Assessment_of_Classroom_Discussion_info?
        var Differentiation_of_5Es:Differentiation_of_5Es_info?
        var Formative_Assessment_of_5Es:Formative_Assessment_of_5Es_info?
        var Differentiation_of_ELLP:Differentiation_of_ELLP_info?
        var Formative_Assessment_of_ELLP:Formative_Assessment_of_ELLP_info?
        var Advance_Organizer:Advance_Organizer_info?
        var Direct_Instruction:Direct_Instruction_info?
        var I_Do:I_Do_info?
        var We_Do:We_Do_info?
        var You_Do_Together:You_Do_Together_info?
        var You_Do_Independent:You_Do_Independent_info?
        var Present_Information:Present_Information_info?
        var Organize_Teams:Organize_Teams_info?
        var Assist_Teams:Assist_Teams_info?
        var Assess_Teams:Assess_Teams_info?
        var Provide_Recognition:Provide_Recognition_info?
        var Focus_Discussion:Focus_Discussion_info?
        var Hold_Discussion:Hold_Discussion_info?
        var End_Discussion:End_Discussion_info?
        var Debrief_Discussion:Debrief_Discussion_info?
        var Engage:Engage_info?
        var Explore:Explore_info?
        var Explain:Explain_info?
        var Elaborate:Elaborate_info?
        var Evaluate:Evaluate_info?
        var My_Language_Objective:My_Language_Objective_info?
        var Key_Vocabulary:Key_Vocabulary_info?
        var Closure:Closure_info?
        var Reflective_Questions:Reflective_Questions_info?
        var Lesson_Adaption:Lesson_Adaption_info?
        var Learners:Learners_info?
        var Content:Content_info?
        var Materials:Materials_info?
        var Rationale_for_Instructional_Model:Rationale_for_Instructional_Model_info?
        var Combined_Differentiation:Combined_Differentiation_info?
        var Combined_Formative:Combined_Formative_info?
        
        var Presentation_Lecture_Content_Topic_One:Presentation_Lecture_Content_Topic_One_info?
        var Presentation_Lecture_Content_Topic_Two:Presentation_Lecture_Content_Topic_Two_info?
        var Presentation_Lecture_Content_Topic_Three:Presentation_Lecture_Content_Topic_Three_info?
        var Presentation_Lecture_Meaningful_Activity_One:Presentation_Lecture_Meaningful_Activity_One_info?
        var Presentation_Lecture_Meaningful_Activity_Two:Presentation_Lecture_Meaningful_Activity_Two_info?
        var Presentation_Lecture_Meaningful_Activity_Three:Presentation_Lecture_Meaningful_Activity_Three_info?
        var Presentation_Lecture_Check_Understanding_One:Presentation_Lecture_Check_Understanding_One_info?
        var Presentation_Lecture_Check_Understanding_Two:Presentation_Lecture_Check_Understanding_Two_info?
        var Presentation_Lecture_Check_Understanding_Three:Presentation_Lecture_Check_Understanding_Three_info?
        
        var Language_Support_Content_Topic_One:Language_Support_Content_Topic_One_info?
        var Language_Support_Content_Topic_Two:Language_Support_Content_Topic_Two_info?
        var Language_Support_Content_Topic_Three:Language_Support_Content_Topic_Three_info?
        var Language_Support_Meaningful_Activity_One:Language_Support_Meaningful_Activity_One_info?
        var Language_Support_Meaningful_Activity_Two:Language_Support_Meaningful_Activity_Two_info?
        var Language_Support_Meaningful_Activity_Three:Language_Support_Meaningful_Activity_Three_info?
        var Language_Support_Check_Understanding_One:Language_Support_Check_Understanding_One_info?
        var Language_Support_Check_Understanding_Two:Language_Support_Check_Understanding_Two_info?
        var Language_Support_Check_Understanding_Three:Language_Support_Check_Understanding_Three_info?
        
        var Combined_Content_Topic_One:Combined_Content_Topic_One_info?
        var Combined_Content_Topic_Two:Combined_Content_Topic_Two_info?
        var Combined_Content_Topic_Three:Combined_Content_Topic_Three_info?
        var Combined_Meaningful_Activity_One:Combined_Meaningful_Activity_One_info?
        var Combined_Meaningful_Activity_Two:Combined_Meaningful_Activity_Two_info?
        var Combined_Meaningful_Activity_Three:Combined_Meaningful_Activity_Three_info?
        var Combined_Check_Understanding_One:Combined_Check_Understanding_One_info?
        var Combined_Check_Understanding_Two:Combined_Check_Understanding_Two_info?
        var Combined_Check_Understanding_Three:Combined_Check_Understanding_Three_info?
        
        // for save back
        var Content_Delivery_One:Content_Delivery_One_info?
        var Meaningful_Activity_One:Meaningful_Activity_One_info?
        var Content_Delivery_Two:Content_Delivery_Two_info?
        var Meaningful_Activity_Two:Meaningful_Activity_Two_info?
        var Content_Delivery_Three:Content_Delivery_Three_info?
        var Meaningful_Activity_Three:Meaningful_Activity_Three_info?
        var Check_Understanding:Check_Understanding_info?
         var Topics:Topics_info?
    }
    
    struct Name_info:Codable{
        var S:String
    }
    struct Grade_info:Codable{
        var S:String
    }
    struct  Subject_info:Codable{
        var S:String
    }
    struct  LessonTitle_info:Codable{
        var S:String
    }
    struct Email_info:Codable{
        var S:String
    }
    struct ContentStandard_info:Codable{
        var S:String
    }
    struct LearningObjective_One_info:Codable{
        var S:String
    }
    struct LearningObjectiveTwo_info:Codable{
        var S:String
    }
    struct Summative_Assessment_info:Codable{
        var S:String
    }
    struct Anticipatory_Set_info:Codable{
        var S:String
    }
    struct Advance_Organizer_info:Codable{
        var S:String
    }
    struct Differentiation_of_Presentation_Lecture_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Presentation_Lecture_info:Codable{
        var S:String
    }
    struct Differentiation_of_Direct_Instruction_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Direct_Instruction_info:Codable{
        var S:String
    }
    struct Differentiation_of_Cooperative_Learning_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Cooperative_Learning_info:Codable{
        var S:String
    }
    struct Differentiation_of_Classroom_Discussion_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Classroom_Discussion_info:Codable{
        var S:String
    }
    struct Differentiation_of_5Es_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_5Es_info:Codable{
        var S:String
    }
    struct Differentiation_of_ELLP_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_ELLP_info:Codable{
        var S:String
    }
    struct Direct_Instruction_info:Codable{
        var S:String
    }
    struct I_Do_info:Codable{
        var S:String
    }
    struct We_Do_info:Codable{
        var S:String
    }
    struct You_Do_Together_info:Codable{
        var S:String
    }
    struct You_Do_Independent_info:Codable{
        var S:String
    }
    struct Present_Information_info:Codable{
        var S:String
    }
    struct Organize_Teams_info:Codable{
        var S:String
    }
    struct Assist_Teams_info:Codable{
        var S:String
    }
    struct Assess_Teams_info:Codable{
        var S:String
    }
    struct Provide_Recognition_info:Codable{
        var S:String
    }
    struct Focus_Discussion_info:Codable{
        var S:String
    }
    struct Hold_Discussion_info:Codable{
        var S:String
    }
    struct End_Discussion_info:Codable{
        var S:String
    }
    struct Debrief_Discussion_info:Codable{
        var S:String
    }
    struct Engage_info:Codable{
        var S:String
    }
    struct Explore_info:Codable{
        var S:String
    }
    struct Explain_info:Codable{
        var S:String
    }
    struct Elaborate_info:Codable{
        var S:String
    }
    struct Evaluate_info:Codable{
        var S:String
    }
    struct My_Language_Objective_info:Codable{
        var S:String
    }
    struct Key_Vocabulary_info:Codable{
        var S:String
    }
    struct Closure_info:Codable{
        var S:String
    }
    struct Reflective_Questions_info:Codable{
        var S:String
    }
    struct Lesson_Adaption_info:Codable{
        var S:String
    }
    struct Learners_info:Codable{
        var S:String
    }
    struct Content_info:Codable{
        var S:String
    }
    struct Materials_info:Codable{
        var S:String
    }
    struct Rationale_for_Instructional_Model_info:Codable{
        var S:String
    }
    struct Combined_Differentiation_info:Codable{
        var S:String
    }
    struct Combined_Formative_info:Codable{
        var S:String
    }
    struct Differentiation_of_Anticipatory_Set_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Anticipatory_Set_info:Codable{
        var S:String
    }
    struct Differentiation_of_Closure_info:Codable{
        var S:String
    }
    struct Formative_Assessment_of_Closure_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_State_info:Codable{
        var S:String
    }
    struct Direct_Instruction_State_info:Codable{
        var S:String
    }
    struct Cooperative_Learning_State_info:Codable{
        var S:String
    }
    struct Classroom_Discussion_State_info:Codable{
        var S:String
    }
    struct FiveEs_State_info:Codable{
        var S:String
    }
    struct ELLP_State_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Content_Topic_One_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Content_Topic_Two_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Content_Topic_Three_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Meaningful_Activity_One_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Meaningful_Activity_Two_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Meaningful_Activity_Three_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Check_Understanding_One_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Check_Understanding_Two_info:Codable{
        var S:String
    }
    struct Presentation_Lecture_Check_Understanding_Three_info:Codable{
        var S:String
    }
    struct Language_Support_Content_Topic_One_info:Codable{
        var S:String
    }
    struct Language_Support_Content_Topic_Two_info:Codable{
        var S:String
    }
    struct Language_Support_Content_Topic_Three_info:Codable{
        var S:String
    }
    struct Language_Support_Meaningful_Activity_One_info:Codable{
        var S:String
    }
    struct Language_Support_Meaningful_Activity_Two_info:Codable{
        var S:String
    }
    struct Language_Support_Meaningful_Activity_Three_info:Codable{
        var S:String
    }
    struct Language_Support_Check_Understanding_One_info:Codable{
        var S:String
    }
    struct Language_Support_Check_Understanding_Two_info:Codable{
        var S:String
    }
    struct Language_Support_Check_Understanding_Three_info:Codable{
        var S:String
    }
    struct Combined_Content_Topic_One_info:Codable{
        var S:String
    }
    struct Combined_Content_Topic_Two_info:Codable{
        var S:String
    }
    struct Combined_Content_Topic_Three_info:Codable{
        var S:String
    }
    struct Combined_Meaningful_Activity_One_info:Codable{
        var S:String
    }
    struct Combined_Meaningful_Activity_Two_info:Codable{
        var S:String
    }
    struct Combined_Meaningful_Activity_Three_info:Codable{
        var S:String
    }
    struct Combined_Check_Understanding_One_info:Codable{
        var S:String
    }
    struct Combined_Check_Understanding_Two_info:Codable{
        var S:String
    }
    struct Combined_Check_Understanding_Three_info:Codable{
        var S:String
    }
    // for save back
    struct Content_Delivery_One_info:Codable{
        var S:String
    }
    struct Meaningful_Activity_One_info:Codable{
        var S:String
    }
    struct Content_Delivery_Two_info:Codable{
        var S:String
    }
    struct Meaningful_Activity_Two_info:Codable{
        var S:String
    }
    struct Content_Delivery_Three_info:Codable{
        var S:String
    }
    struct Meaningful_Activity_Three_info:Codable{
        var S:String
    }
    struct Check_Understanding_info:Codable{
        var S:String
    }
    struct Topics_info:Codable{
        var S:String
    }
}
