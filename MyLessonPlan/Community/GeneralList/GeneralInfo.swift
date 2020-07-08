//
//  CommunityList.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/3/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

struct GeneralInfo:Codable{
    var Items: [Items_info]
}

struct Items_info:Codable{
    var Name:Name_info?
    var ID:ID_info?
    var Title: Title_info?
    var Subject: Subject_info?
    var Grade: Grade_info?
    var Date: Date_info?
    var Comments:Comments_info?
    var NumOfLikes: NumOfLikes_info?
    var realNumOfLikes:Int?
    var isLiked:Bool?
    var realDate: Date?
    var numOfComments:Int?
    var commentList: [String]?
    var isCommentExpended:Bool?
}

struct Name_info:Codable{
    var S:String
}

struct ID_info:Codable{
    var S:String
}

struct Subject_info:Codable{
    var S:String
}

struct Grade_info:Codable{
    var S:String
}

struct Date_info:Codable{
    var S:String
}

struct Comments_info:Codable{
    var S:String
}

struct NumOfLikes_info:Codable{
    var S:String
}
