//
//  SummativeScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/11/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class SummativeScene: UIView {
    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",55),("reminder", 200),("title", 120),
                                                       ("textView", 500)]
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_Summative")
        roadMap.backgroundColor = UIColor.byuHRed
        roadMap.tag = 0
        return roadMap
    }()
    var curve:UIView = {
        let curveView = UIView()
        curveView.backgroundColor = UIColor.byuHlightGray
        curveView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        curveView.layer.shadowRadius = 50
        curveView.layer.shadowOpacity = 1
        return curveView
    }()
    var hint:UILabel = {
        let hint = UILabel()
        hint.text = "Write the Summative Assessment"
        hint.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        hint.textAlignment = .center
        hint.numberOfLines = 0
        hint.sizeToFit()
        hint.textColor = .black
        return hint
    }()
    var textView:UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.sdTextFieldColor()
        return textView
    }()
    var titleView:UIView = {
        let titleView = UIView()
        return titleView
    }()
    var questionMark:UIImageView = {
        let questionMark = UIImageView()
        questionMark.tag = 1
        questionMark.isUserInteractionEnabled = true
        return questionMark
    }()
    var what:UILabel = {
        let what = UILabel()
        what.text = "What is Summative"
        what.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        what.textAlignment = .center
        what.textColor = .black
        what.adjustsFontSizeToFitWidth = true
        return what
    }()
    var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "Tip: "
        tipLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        tipLabel.textAlignment = .center
        tipLabel.numberOfLines = 0
        tipLabel.textColor = .black
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
    }()
    let contenttv = UIView()
    let objectivestv = UIView()
    let summativetv = UIView()
    let closuretv = UIView()
    let instructiontv = UIView()
    let anticipatorytv = UIView()
    let backgroundtv = UIView()
    let lessontv = UIView()
    let reflectivetv = UIView()
    
    func setRoadMapLayout(height h:CGFloat, to cell: UIView, view:UIView){
        roadMap.frame = CGRect(x: 0, y:0, width: view.frame.width, height: h)
        roadMap.contentMode = .scaleAspectFit
        let standardR = roadMap.frame.height/3.2
        objectivestv.frame = CGRect(x: roadMap.frame.midX - standardR/2, y: roadMap.frame.minY, width: standardR, height: standardR)
        cell.addSubview(objectivestv)
        contenttv.frame = CGRect(x: objectivestv.frame.minX - standardR*2, y: roadMap.frame.minY, width: standardR, height: standardR)
        cell.addSubview(contenttv)
        summativetv.frame = CGRect(x: objectivestv.frame.maxX + standardR, y: roadMap.frame.minY, width: standardR, height: standardR)
        cell.addSubview(summativetv)
        anticipatorytv.frame = CGRect(x: objectivestv.frame.minX, y: objectivestv.frame.maxY + 0.3*standardR, width: standardR, height: standardR)
        cell.addSubview(anticipatorytv)
        closuretv.frame = CGRect(x: summativetv.frame.minX, y: summativetv.frame.maxY + 0.3*standardR, width: standardR, height: standardR)
        cell.addSubview(closuretv)
        instructiontv.frame = CGRect(x: roadMap.frame.midX, y: anticipatorytv.frame.maxY, width: standardR*2, height: standardR)
        cell.addSubview(instructiontv)
        backgroundtv.frame = CGRect(x: contenttv.frame.minX, y: roadMap.frame.midY-standardR/2, width: standardR*1.1, height: standardR*2/3)
        cell.addSubview(backgroundtv)
        lessontv.frame = CGRect(x: contenttv.frame.minX, y: backgroundtv.frame.maxY+standardR/4, width: standardR*1.1, height: standardR)
        cell.addSubview(lessontv)
    }
    func setCurveLayout(height h:CGFloat, view:UIView){
        curve.frame = CGRect(x: 0, y: 0, width:  view.frame.width, height: h)
        curve.roundedTopCorner(radius: Int(h))
    }
    func setHintLayout(height h:CGFloat, view:UIView){
        hint.center.x = view.frame.width/2
        hint.center.y = h/2
    }
    func setTextViewLayout(height h:CGFloat,view:UIView){
        let temp2 = sdGap*4+safeRight+safeLeft
        textView.frame = CGRect(x: sdGap*2+safeLeft, y: 0, width: view.frame.width-temp2, height: h)
        textView.backgroundColor = UIColor.sdTextFieldColor()
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        textView.textColor = .lightGray
        textView.text = "Insert Summative Assessment"
        backgroundColor = UIColor.byuHlightGray
        textView.keyboardAppearance = .light
    }
    func setTitleViewLayout(height h:CGFloat, view:UIView){
        titleView.frame = CGRect(x: 2*sdGap+safeLeft, y: 0, width: view.frame.width-4*sdGap-safeLeft-safeRight, height: h)
        questionMark.frame =  CGRect(x: 0, y: 15, width: titleView.frame.width, height: 25)
        questionMark.image = #imageLiteral(resourceName: "questionMark")
        questionMark.contentMode = .scaleAspectFit
        titleView.addSubview(questionMark)
        what.frame = CGRect(x: 0, y: questionMark.frame.maxY+sdGap, width: titleView.frame.width, height: 20)
        titleView.addSubview(what)
        tipLabel.frame = CGRect(x: 0, y: what.frame.maxY+sdGap, width: titleView.frame.width, height: 30)
        titleView.addSubview(tipLabel)
    }
}
