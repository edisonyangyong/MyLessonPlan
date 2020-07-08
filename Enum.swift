//
//  Enum.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/24/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

enum Sequecne{
    case pdf
    case main
    case info
    case content
    case objectives
    case summative
    case anticipatory
    case instruction
    case closure
    case background
    case lesson
}

enum InstructionSequenceStepState:String {
    case empty = "empty"
    case separated = "separated"
    case combined = "combined"
}

enum NotificationName:String {
    case broadcastToReloadReminderAndTitle = "broadcastToReloadReminderAndTitle"
    case notifyMainViewToUpdateDataFlow = "notifyMainViewToUpdateDataFlow"
}
