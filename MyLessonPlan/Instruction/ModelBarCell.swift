//
//  barCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/20/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class ModelBarCell: UITableViewCell {
    
    var label = UILabel()
    var checkBox = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func layout(width:CGFloat, height:CGFloat){
        setLableLayout(width: width, height: height)
        setCheckBoxLayout(width: width, height: height)
    }
    
    func setLableLayout(width:CGFloat, height:CGFloat){
        label.frame = CGRect(x: 0, y: 0, width: width*0.79, height: height)
        #if targetEnvironment(macCatalyst)
        label.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
        #else
        label.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        #endif
        label.backgroundColor = #colorLiteral(red: 0.7347576022, green: 0.7348824739, blue: 0.7347410917, alpha: 0)
        label.textAlignment = .left
        label.textColor = UIColor.byuHlightGray
        self.addSubview(label)
    }
    func setCheckBoxLayout(width:CGFloat, height:CGFloat){
        checkBox.frame = CGRect(x: width-height+6, y: 2.5, width: height-6, height: height-6)
        checkBox.layer.borderWidth = 1
        checkBox.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        checkBox.image = #imageLiteral(resourceName: "check-filled")
        self.addSubview(checkBox)
    }
}
