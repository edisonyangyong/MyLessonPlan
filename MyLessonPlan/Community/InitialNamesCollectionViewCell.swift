//
//  InitialNamesCollectionViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/28/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class InitialNamesCollectionViewCell: UICollectionViewCell {
    var nameLabel = UILabel()
    override init(frame: CGRect) {
         super.init(frame: frame)
         addSubview(nameLabel)
         setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout(){
        nameLabel.frame = CGRect(x: 0, y: 0, width: 27, height: 27)
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.byuHRed
        nameLabel.layer.cornerRadius = 0.5*27
        nameLabel.clipsToBounds = true
    }
}
