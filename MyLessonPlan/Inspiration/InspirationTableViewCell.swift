//
//  InspirationCellTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/14/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class InspirationTableViewCell: UITableViewCell {
    
    var cellLabel = UILabel()
    var cellTitle = UILabel()
    var cellLike = UIButton(type: .system)
    var insertButton = UIButton(type: .system)
    var likeImageView = UIImageView()
    var likeNum = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.byuHlightGray
        setCellLabelLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellLabelLayout(){
        addSubview(cellTitle)
        addSubview(cellLabel)
        addSubview(cellLike)
        addSubview(insertButton)
        addSubview(likeImageView)
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50-sdGap).isActive = true
        cellTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        #if targetEnvironment(macCatalyst)
        cellTitle.font = UIFont(name: "HoeflerText-BlackItalic", size: 40)
        #else
        cellTitle.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        #endif
        cellTitle.adjustsFontSizeToFitWidth = true
        cellTitle.textColor = .black
        
        likeImageView.image = #imageLiteral(resourceName: "like_unselect")
        likeImageView.isUserInteractionEnabled = true
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        likeImageView.leadingAnchor.constraint(equalTo: cellTitle.trailingAnchor,constant: -5).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        likeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -sdGap-5).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        cellLabel.numberOfLines = 0
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        #if targetEnvironment(macCatalyst)
        cellLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        #else
        cellLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        #endif
        cellLabel.textColor = .black
        
        cellLike.translatesAutoresizingMaskIntoConstraints = false
        cellLike.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        cellLike.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        cellLike.heightAnchor.constraint(equalToConstant: 44).isActive = true
        cellLike.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        #if targetEnvironment(macCatalyst)
        cellLike.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        #else
        cellLike.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        #endif
        cellLike.titleLabel!.adjustsFontSizeToFitWidth = true
        cellLike.layer.cornerRadius = 4
        cellLike.tintColor = .white
        cellLike.titleLabel?.textAlignment = .center
        cellLike.backgroundColor = #colorLiteral(red: 0.9070218205, green: 0.2940552235, blue: 0.5282635093, alpha: 1)
        
        insertButton.translatesAutoresizingMaskIntoConstraints = false
        insertButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        insertButton.leadingAnchor.constraint(equalTo: cellLike.trailingAnchor, constant: sdGap).isActive = true
        insertButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        insertButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        insertButton.setTitle("Insert It Into My Lesson Plan", for: .normal)
        insertButton.layer.cornerRadius = 4
        insertButton.backgroundColor = #colorLiteral(red: 0, green: 0.3587287962, blue: 0.7226245999, alpha: 1)
        insertButton.tintColor = .white
        #if targetEnvironment(macCatalyst)
        insertButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        #else
        insertButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        #endif
        insertButton.titleLabel?.adjustsFontSizeToFitWidth = true
        insertButton.titleLabel?.textAlignment = .center
    }
}
