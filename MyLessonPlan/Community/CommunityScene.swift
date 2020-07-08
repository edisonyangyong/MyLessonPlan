//
//  CommunityScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/2/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class CommunityScene: UIView {
    
    var mainTableView:UITableView = {
        let mainTableViwe = UITableView(frame: CGRect(), style: .plain)
        mainTableViwe.backgroundColor = UIColor.lightGray
        return mainTableViwe
    }()
    var subjectButton : UIButton = {
        let subjectButton = UIButton()
        return subjectButton
    }()
    var gradeButton: UIButton = {
        let gradeButton = UIButton()
        return gradeButton
    }()
    var sortButton: UIButton = {
        let sortButton = UIButton()
        return sortButton
    }()
    var cellheights:[CGFloat] = []
    var loadingGear:UIImageView = {
        let loadingGear = UIImageView()
        loadingGear.image = #imageLiteral(resourceName: "Gear")
        return loadingGear
    }()
    var initialNamesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let initialNamesCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        initialNamesCollectionView.register(InitialNamesCollectionViewCell.self, forCellWithReuseIdentifier: "InitialNamesCollectionViewCell")
        return initialNamesCollectionView
    }()
    
    func setNavigationBar(navgationBar: UINavigationBar){
           navgationBar.barTintColor = UIColor.byuHRed
    }
    func setupHeadViewLayout(headerView:UIView, numOfNames:Int){
        let label = UILabel()
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor,constant: sdGap).isActive = true
        label.widthAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.widthAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.textColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        label.backgroundColor = UIColor.byuHlightGray
        label.adjustsFontSizeToFitWidth = true
        label.text = "There have been \(numOfNames) teachers involved in this Lesson Plan Community."
        headerView.addSubview(self.initialNamesCollectionView)
        initialNamesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        initialNamesCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        initialNamesCollectionView.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor,constant: sdGap).isActive = true
//        initialNamesCollectionView.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        initialNamesCollectionView.widthAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        initialNamesCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        initialNamesCollectionView.backgroundColor = UIColor.byuHlightGray
    }
    func setMainTableViewLayout(view:UIView){
        view.addSubview(mainTableView)
        mainTableView.backgroundColor = UIColor.byuHlightGray
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: subjectButton.bottomAnchor, constant: sdGap).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func setButtonsLayout(view:UIView){
        view.addSubview(subjectButton)
        view.addSubview(gradeButton)
        view.addSubview(sortButton)
        
        subjectButton.translatesAutoresizingMaskIntoConstraints = false
        subjectButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        subjectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        subjectButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        subjectButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        subjectButton.setTitle("▽ Subject", for: .normal)
        subjectButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        subjectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        subjectButton.backgroundColor = UIColor.byuHRed
        subjectButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subjectButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subjectButton.layer.cornerRadius = 4
        subjectButton.tag = 0
        subjectButton.layer.cornerRadius = 4
        subjectButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        subjectButton.layer.shadowRadius = 2.5
        subjectButton.layer.shadowOpacity = 0.9
        subjectButton.layer.shadowColor = UIColor.darkGray.cgColor
        
        gradeButton.translatesAutoresizingMaskIntoConstraints = false
        gradeButton.leadingAnchor.constraint(equalTo: subjectButton.trailingAnchor, constant: sdGap).isActive = true
        gradeButton.trailingAnchor.constraint(equalTo: sortButton.leadingAnchor, constant: -sdGap).isActive = true
        gradeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        gradeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        gradeButton.setTitle("▽ Grade", for: .normal)
        gradeButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        gradeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        gradeButton.backgroundColor = UIColor.byuHRed
        gradeButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gradeButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gradeButton.layer.cornerRadius = 4
        gradeButton.tag = 1
        gradeButton.layer.cornerRadius = 4
        gradeButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        gradeButton.layer.shadowRadius = 2.5
        gradeButton.layer.shadowOpacity = 0.9
        gradeButton.layer.shadowColor = UIColor.darkGray.cgColor

        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        sortButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        sortButton.setTitle("▽ Sort", for: .normal)
        sortButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        sortButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sortButton.backgroundColor = UIColor.byuHRed
        sortButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sortButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sortButton.layer.cornerRadius = 4
        sortButton.tag = 2
        sortButton.layer.cornerRadius = 4
        sortButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        sortButton.layer.shadowRadius = 2.5
        sortButton.layer.shadowOpacity = 0.9
        sortButton.layer.shadowColor = UIColor.darkGray.cgColor
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
