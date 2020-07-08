//
//  Protocols.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/16/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

protocol ObjectiveDataFlowUpdatingDelegation {
    func updateDataFlowFromSubObjective(viewController vc:SubObjectiveViewController, from endObjectiveText: String)
    func saveToDiskAndUpdateReminer()
}

protocol InspirationViewControllerDataFlowUpdatingDelegation {
    func updateDataFlowFromInspirationVC(idea:String)
}

protocol SDContentTableViewCellDataFlowUpdatingDelegation {
    func updateDataFlowFromSDContentTableVC(step: String, content:String, save:Bool)
    func callReloadMainTableView(cell: SDContentTableViewCell)
}

protocol popViewTextViewDelegation{
    func scrollToTop()
}
