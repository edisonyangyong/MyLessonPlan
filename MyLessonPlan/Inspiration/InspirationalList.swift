//
//  InspirationalList.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/13/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

// 最好把 [] 写在 request 里， 不要写在这里

import Foundation

struct InspiritionalIdea: Codable{
    var Item: InspiritionalIdea_info?
}

struct InspiritionalIdea_info:Codable{
    var Id: Id_info?
    var Title: Title_info?
    var Idea: Idea_info?
    var Likes: Like_info?
    var isLiked: Bool?
}

struct Id_info:Codable{
    var S:String
}

struct Title_info:Codable{
    var S:String
}

struct Idea_info:Codable{
    var S:String
}

struct Like_info:Codable{
    var S:String
}


