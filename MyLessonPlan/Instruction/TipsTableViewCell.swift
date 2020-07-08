//
//  TipsTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/26/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class TipsTableViewCell: UITableViewCell {
    
    var myLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        myLabel.textColor = .black
        myLabel.numberOfLines = 0
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.textAlignment = .justified
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
