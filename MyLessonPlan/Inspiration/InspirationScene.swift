//
//  InspirationView.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/13/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class InspirationScene: UIView {
    
    var inspirationTableView:UITableView = {
        let inspirationTableView = UITableView()
        inspirationTableView.allowsSelection = false
        inspirationTableView.tag = 0
        inspirationTableView.backgroundColor = UIColor.byuHlightGray
        return  inspirationTableView
    }()
    var loadingGear:UIImageView = {
        let loadingGear = UIImageView()
        loadingGear.image = #imageLiteral(resourceName: "Gear")
        return loadingGear
    }()

    func setNavigationBar(navgationBar: UINavigationBar){
        navgationBar.barTintColor = UIColor.byuhPurple
    }
    func setinspirationListLayout(view: UIView ){
        inspirationTableView.translatesAutoresizingMaskIntoConstraints = false
        inspirationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        inspirationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        inspirationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        inspirationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setLoadingGearLayout(view: UIView ){
        let gearLabel = UILabel()
        view.addSubview(gearLabel)
        gearLabel.translatesAutoresizingMaskIntoConstraints = false
        gearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gearLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gearLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gearLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        gearLabel.text = "Loading"
        gearLabel.textColor = .black
        gearLabel.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        gearLabel.adjustsFontSizeToFitWidth = true
        loadingGear.translatesAutoresizingMaskIntoConstraints = false
        loadingGear.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingGear.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingGear.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loadingGear.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    func loadingGearStartAnimation(){
        UIImageView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.curveLinear,.beginFromCurrentState],
            animations: {
                UIImageView.modifyAnimations(withRepeatCount: CGFloat(Double.infinity), autoreverses: false, animations: {
                    self.loadingGear.transform = self.loadingGear.transform.rotated(by:  CGFloat(Double.pi)*0.9)
                })
        })
    }
}
