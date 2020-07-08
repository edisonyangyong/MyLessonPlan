//
//  CommunityModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/2/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation
import DropDown

class CommunityModel{
    let subjectMenu: DropDown = {
        let subjectMenu = DropDown()
        subjectMenu.dataSource = ["All Subjects", "Math", "Language", "Arts", "Science", "P.E./Help", "Social Science"]
        return subjectMenu
    }()
    
    let gradeMenu: DropDown = {
        let gradeMenu = DropDown()
        gradeMenu.dataSource = ["All Grades", "Grade-K", "Grade-1", "Grade-2","Grade-3", "Grade-4", "Grade-5", "Grade-6"
        , "Grade-7", "Grade-8", "Grade-9", "Grade-10", "Grade-11", "Grade-12"]
        return gradeMenu
    }()
    
    let sortMenu: DropDown = {
        let sortMenu = DropDown()
        sortMenu.dataSource = ["Latest", "by Likes", "by Comments"]
        return sortMenu
    }()
}
