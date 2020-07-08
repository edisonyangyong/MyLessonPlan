//
//  ReminderCollectionViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var textView = UITextView()
    var editLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(textView)
         addSubview(editLabel)
        setupLayout()
        self.backgroundColor = #colorLiteral(red: 0.9994434714, green: 0.3189594448, blue: 0, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.9
        self.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        titleLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        titleLabel.adjustsFontSizeToFitWidth = true
        
//        editImage.image = #imageLiteral(resourceName: "write-filled")
        editLabel.frame = CGRect(x: 300-40, y: 200-42, width: 40, height: 20)
        editLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
//        editImage.layer.cornerRadius = 0.5*40
//        editImage.backgroundColor = #colorLiteral(red: 0.1397448778, green: 0.673778832, blue: 0.7773730159, alpha: 1)
        editLabel.isUserInteractionEnabled = true
        editLabel.text = "EDIT"
        editLabel.adjustsFontSizeToFitWidth = true
//        editLabel.layer.cornerRadius = 5
//        editLabel.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        editLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9983946918)
//        editLabel.layer.borderWidth = 2
        
        textView.frame =  CGRect(x: 0, y: 30, width: 300, height: 200-80)
        textView.backgroundColor = #colorLiteral(red: 0.9238938689, green: 0.2960730493, blue: 0.2057518959, alpha: 1)
        textView.textColor = .white
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        textView.isEditable = false
    }
}
