//
//  InfoTableTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/20/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class InfoTableTableViewCell: UITableViewCell {
    
    var hintLabel = UILabel()
    var textView = UITextView()
    var view = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(hintLabel)
        setLayout(view:view)
        addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setLayout(view:UIView){
        let temp = sdGap*4+safeRight+safeLeft
        hintLabel.frame = CGRect(x: sdGap*2+safeLeft, y: 0, width:view.frame.width-temp, height: sdButtonHeight)
        hintLabel.textAlignment = .left
        hintLabel.numberOfLines = 0
        hintLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        hintLabel.textColor = .black
        
        let temp2 = sdGap*4+safeRight+safeLeft
        textView.frame = CGRect(x: sdGap*2+safeLeft, y: hintLabel.frame.maxY, width: view.frame.width-temp2, height: sdButtonHeight)
        textView.backgroundColor = UIColor.sdTextFieldColor()
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        textView.textColor = .black
        backgroundColor = UIColor.byuHlightGray
        selectionStyle = .none
        textView.keyboardAppearance = .light
    }
}
