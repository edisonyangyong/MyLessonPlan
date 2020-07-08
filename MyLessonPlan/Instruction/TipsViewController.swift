//
//  TipsViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/26/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl

class TipsViewController: UIViewController {
    
    private var instructionModel = InstructionModel()
    lazy private var sortedKeys = Array(instructionModel.practiceDict.keys).sorted(by: <)
    private var headerColor = [#colorLiteral(red: 1, green: 0.899531126, blue: 0.5972177982, alpha: 1),#colorLiteral(red: 0.7047251463, green: 0.7756387591, blue: 0.9056091905, alpha: 1),#colorLiteral(red: 0.467544198, green: 0.8510561585, blue: 0.9029257894, alpha: 1),#colorLiteral(red: 0.9690490365, green: 0.7917336822, blue: 0.6743237376, alpha: 1),#colorLiteral(red: 0.776977241, green: 0.876768291, blue: 0.7060309052, alpha: 1),#colorLiteral(red: 0.9114952683, green: 0.5578820109, blue: 0.4802418351, alpha: 1),#colorLiteral(red: 0.7386561036, green: 0.8361151218, blue: 0.9307842255, alpha: 1),#colorLiteral(red: 0.9035755992, green: 0.7187419534, blue: 0.876262486, alpha: 1)]
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Effective Pedagogy Features"
        
        self.setNavigationBar(title: "Effective Pedagogy Features")
        self.addBackNaviButton(title: "Back")
        
        let mainTableView = UITableView()
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = .white
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(TipsTableViewCell.self, forCellReuseIdentifier: "TipsTableViewCell")
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        let tableHeaderLabel = UILabel()
        tableHeaderLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        tableHeaderLabel.backgroundColor = #colorLiteral(red: 0.6639491916, green: 0.2502551973, blue: 0.3286128044, alpha: 1)
        tableHeaderLabel.text = "Putting into practice these effective pedagogy features is key to meeting the needs of ALL students, including and especially your English Language Learners. This list is adapted from: Echevarria, J., Vogt, M.E., Short, D.J. (2017). Making Content Comprehensible for English Learners: The SIOP Model. 5th Ed. Boston, MA: Pearson Educational Inc. which we highly recommend."
        tableHeaderLabel.textAlignment = .justified
        tableHeaderLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        tableHeaderLabel.textColor = .white
        tableHeaderLabel.numberOfLines = 0
        tableHeaderLabel.adjustsFontSizeToFitWidth = true
        
        mainTableView.tableHeaderView = tableHeaderLabel
        mainTableView.refreshControl = gearRefreshControl
        gearRefreshControl.gearTintColor = UIColor.byuHRed
    }
}

extension TipsViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension TipsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = UIView()
        headerView.backgroundColor = headerColor[section]
        let headLable = UILabel()
        headerView.addSubview(headLable)
        headLable.translatesAutoresizingMaskIntoConstraints = false
        headLable.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        headLable.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        headLable.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        headLable.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headLable.text = sortedKeys[section]
        headLable.textAlignment = .left
        headLable.textColor = .black
        headLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return instructionModel.practiceDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructionModel.practiceDict[sortedKeys[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsTableViewCell") as! TipsTableViewCell
        cell.myLabel.text = instructionModel.practiceDict[sortedKeys[indexPath.section]]![indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.byuHlightGray
        return cell
    }
}
