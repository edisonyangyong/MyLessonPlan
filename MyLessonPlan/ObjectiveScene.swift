//
//  ObjectiveScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/8/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class ObjectiveScene: UIView {
    
    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",55),("reminder", 200),("title",120),("content",500)]
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_Objective")
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
    var picker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .gray
        picker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        return picker
    }()
    var reminder:UILabel = {
        let reminder = UILabel()
        reminder.text = "My Lesson Plan Reminder"
        reminder.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        reminder.textAlignment = .center
        reminder.numberOfLines = 0
        reminder.textColor = .black
        reminder.adjustsFontSizeToFitWidth = true
        return reminder
    }()
    var animatedRect:UIView = {
        let animatedRect = UIView()
        animatedRect.layer.borderWidth = 4
        animatedRect.layer.borderColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        return animatedRect
    }()
    var animatedPointer:UIImageView = {
        let animatedPointer = UIImageView()
        return animatedPointer
    }()
    var rightVerbView:UIView = {
        let rightVerbView = UIView()
        return rightVerbView
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
        what.text = "What is Learning Objective"
        what.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        what.textAlignment = .center
        what.textColor = .black
        what.adjustsFontSizeToFitWidth = true
        return what
    }()
    var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "Tip: Pick a Specific Verb to Make\nYour Learning Objective Measureable"
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
    
    func showfocuseLinkBlurView(view:UIView){
        let blurEffect = UIBlurEffect(style: .dark)
        var _focuseBlurViewUp:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        var _focuseBlurViewLeft:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        var _focuseBlurViewRight:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        var _focuseBlurViewDown:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(_focuseBlurViewUp!)
        view.addSubview(_focuseBlurViewLeft!)
        view.addSubview(_focuseBlurViewRight!)
        view.addSubview(_focuseBlurViewDown!)
        
        _focuseBlurViewUp!.alpha = 0
        _focuseBlurViewLeft!.alpha = 0
        _focuseBlurViewRight!.alpha = 0
        _focuseBlurViewDown!.alpha = 0
        
        var _hintLable:UILabel? = UILabel()
        _hintLable!.text = "Pick a Verb"
        _hintLable!.textColor = .white
        _hintLable!.adjustsFontSizeToFitWidth = true
        _hintLable!.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _hintLable!.textAlignment = .center
        _hintLable!.numberOfLines = 0
        _hintLable!.alpha = 0
        
        var _pointer:UIImageView? = UIImageView()
        _pointer!.image = #imageLiteral(resourceName: "finger pointing-user-1")
        _pointer!.alpha = 0
        
        if let mainTableView = view.subviews[3] as? UITableView{
            if let cell = mainTableView.cellForRow(at: IndexPath(row: 4, section: 0)){
                let frame = cell.convert(cell.subviews[2].frame, to: view)
//                let window = UIApplication.shared.keyWindow!
                _focuseBlurViewUp!.frame = CGRect(x: frame.minX, y: 0, width: view.frame.width-frame.minX, height: frame.minY)
                _focuseBlurViewLeft!.frame = CGRect(x: 0, y: 0, width: frame.minX+1, height: frame.minY+500-2*sdGap)
                _focuseBlurViewRight!.frame = CGRect(x: frame.maxX, y: frame.minY, width: view.frame.width-frame.maxX, height: 500-2*sdGap)
                _focuseBlurViewDown!.frame = CGRect(x: 0, y: view.frame.height-safeBottom-44-4*sdGap, width: view.frame.width, height: safeBottom+44+4*sdGap)
                
                _pointer!.frame = CGRect(x: frame.minX-40, y: frame.minY+250, width: 40, height: 40)
                 view.addSubview(_pointer!)
                _hintLable!.frame = CGRect(x: frame.minX-145, y: frame.minY+255, width: 100, height: 40)
                view.addSubview(_hintLable!)
                var _animatedSwipe:UIImageView? = UIImageView()
                _animatedSwipe!.image = #imageLiteral(resourceName: "swipe down-user")
                view.addSubview(_animatedSwipe!)
                _animatedSwipe!.frame = CGRect(x: frame.midX-20, y: frame.minY+50, width: 40, height: 40)
                UIImageView.animate(
                    withDuration: 1.5,
                    delay: 0,
                    options: [],
                    animations: {
                        UIImageView.modifyAnimations(
                            withRepeatCount: 1,
                            autoreverses: true,
                            animations: {
                                _animatedSwipe!.frame = CGRect(x: frame.midX-20, y: frame.minY+450-50, width: 40, height: 40)
                        })
                },completion: { finish in
                    _animatedSwipe!.removeFromSuperview()
                    _animatedSwipe = nil
//                     print(_animatedSwipe)
                })
            }
        }
        UIView.animate(
            withDuration: 0.8,
            delay: 0.4,
            animations: {
                _focuseBlurViewUp!.alpha = 1
                _focuseBlurViewLeft!.alpha = 1
                _focuseBlurViewRight!.alpha = 1
                _focuseBlurViewDown!.alpha = 1
                _hintLable!.alpha = 1
                _pointer!.alpha = 1
        },completion:{ finished in
            UIView.animate(
                withDuration: 0.8,
                delay: 1,
                animations: {
                    _focuseBlurViewUp!.alpha = 0
                    _focuseBlurViewLeft!.alpha = 0
                    _focuseBlurViewRight!.alpha = 0
                    _focuseBlurViewDown!.alpha = 0
                    _hintLable!.alpha = 0
                    _pointer!.alpha = 0
            },
                completion: { finished in
                    _focuseBlurViewUp!.removeFromSuperview()
                    _focuseBlurViewLeft!.removeFromSuperview()
                    _focuseBlurViewRight!.removeFromSuperview()
                    _focuseBlurViewDown!.removeFromSuperview()
                    _hintLable!.removeFromSuperview()
                    _pointer!.removeFromSuperview()
                    
                    _focuseBlurViewUp = nil
                    _focuseBlurViewLeft = nil
                    _focuseBlurViewRight = nil
                    _focuseBlurViewDown = nil
                    _hintLable = nil
                    _pointer = nil
                    
//                    print(_focuseBlurViewUp)
//                    print(_focuseBlurViewLeft)
//                    print(_focuseBlurViewRight)
//                    print(_focuseBlurViewDown)
//                    print(_hintLable)
//                    print(_pointer)
            })
        })
    }
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
    func setReminderLayout(height h:CGFloat, view:UIView){
        reminder.frame = CGRect(x: 2*sdGap+safeLeft, y: 0, width: view.frame.width-4*sdGap-safeLeft-safeRight, height: h)
        reminder.center.x = view.frame.width/2
        reminder.center.y = h/2
    }
    func setRightVerbViewLayout(height h:CGFloat){
        let temp = (UIScreen.main.bounds.width-safeLeft-safeRight-5*sdGap)*3/4
        rightVerbView.frame = CGRect(x: safeLeft+3*sdGap+temp, y: 0, width: (UIScreen.main.bounds.width-safeLeft-safeRight-5*sdGap)/4, height: h)
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
