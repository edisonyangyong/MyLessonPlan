//
//  CommentTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/4/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    var commentLabel = UILabel()
    var dateLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.byuHlightGray
        setCellLabelLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellLabelLayout(){
        let userImage = UIImageView()
        userImage.image = #imageLiteral(resourceName: "profile-filled")
        userImage.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.addSubview(userImage)
        
        self.addSubview(commentLabel)
        commentLabel.numberOfLines = 0
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 44+sdGap).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -22).isActive = true
        commentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        commentLabel.textColor = .black
        
        self.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        dateLabel.textColor = UIColor.byuhMidGray
        dateLabel.textAlignment = .right
    }

}
