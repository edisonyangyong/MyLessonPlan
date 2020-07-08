//
//  ContentScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/8/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class ContentScene:UIView{
    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",55),("reminder", 200),("hint", 120),("link", 85),("textView",500)]
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_Content")
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
    var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "Tip: copy the Content Standard\nfrom the following purple link"
        tipLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        tipLabel.textAlignment = .center
        tipLabel.numberOfLines = 0
        tipLabel.textColor = .black
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
    }()
    var what:UILabel = {
        let what = UILabel()
        what.text = "What is Content Standard"
        what.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        what.textColor = .black
        what.adjustsFontSizeToFitWidth = true
        what.textAlignment = .center
        return what
    }()
    var linkButton:UIButton = {
        let linkButton = UIButton(type: .system)
        linkButton.backgroundColor = #colorLiteral(red: 0.742426753, green: 0.1857207716, blue: 0.7242348194, alpha: 1)
        linkButton.setTitle("Hawai’i State DOE Subject Matter Standards", for: .normal)
        linkButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regulary", size: 15)
        linkButton.tintColor = .white
        linkButton.titleLabel?.adjustsFontSizeToFitWidth = true
        linkButton.titleLabel?.textAlignment = .center
        linkButton.layer.cornerRadius = 20
        linkButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        linkButton.layer.shadowRadius = 2.5
        linkButton.layer.shadowOpacity = 0.9
        linkButton.layer.shadowColor = UIColor.darkGray.cgColor
        return linkButton
    }()
    var standardTextView: UITextView = {
        let standardTextView = UITextView()
        standardTextView.backgroundColor = UIColor.sdTextFieldColor()
        standardTextView.textAlignment = .justified
        if standardTextView.text == ""{
            standardTextView.textColor = .lightGray
            standardTextView.text = "Paste the Standard Here"
        }
        return standardTextView
    }()
    var blurView:UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    var popView: UIView = {
        let popView = UIView()
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return popView
    }()
    var popButton:UIButton = {
        let popButton = UIButton(type: .system)
        popButton.backgroundColor = #colorLiteral(red: 0.1809800863, green: 0.5333758593, blue: 0.9840556979, alpha: 1)
        popButton.setTitle("Done", for: .normal)
        popButton.titleLabel?.textAlignment = .center
        popButton.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        popButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        return popButton
    }()
    var pointerUp:UIImageView = {
        let pointer = UIImageView()
        pointer.image = #imageLiteral(resourceName: "finger pointing-user (1)")
        return pointer
    }()
    var pointerDown:UIImageView = {
        let pointer = UIImageView()
        pointer.image = #imageLiteral(resourceName: "finger pointing-user (1)")
        return pointer
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
    
    var _linkButton:UIButton? = UIButton(type: .system)
    func showfocuseLinkBlurView(view:UIView){
        _linkButton = UIButton(type: .system)
        _linkButton!.backgroundColor = #colorLiteral(red: 0.742426753, green: 0.1857207716, blue: 0.7242348194, alpha: 1)
        _linkButton!.setTitle("Hawai’i State DOE Subject Matter Standards", for: .normal)
        _linkButton!.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regulary", size: 17)
        _linkButton!.tintColor = .white
        _linkButton!.titleLabel?.adjustsFontSizeToFitWidth = true
        _linkButton!.titleLabel?.textAlignment = .center
        _linkButton!.layer.cornerRadius = 20
        _linkButton!.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        _linkButton!.layer.shadowRadius = 2.5
        _linkButton!.layer.shadowOpacity = 0.9
        _linkButton!.layer.shadowColor = UIColor.darkGray.cgColor

        _linkButton!.alpha = 1
        let blurEffect = UIBlurEffect(style: .dark)
        var _focuseCommunityBlurView:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(_focuseCommunityBlurView!)
        _focuseCommunityBlurView!.translatesAutoresizingMaskIntoConstraints = false
        _focuseCommunityBlurView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _focuseCommunityBlurView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        _focuseCommunityBlurView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _focuseCommunityBlurView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _focuseCommunityBlurView!.alpha = 0
        
        var _hintLable:UILabel? = UILabel()
        _hintLable!.text = "Content Standard\nFind it Here"
        _hintLable!.textColor = .white
        _hintLable!.adjustsFontSizeToFitWidth = true
        _hintLable!.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _hintLable!.textAlignment = .center
        _hintLable!.numberOfLines = 0
        _hintLable!.alpha = 0
        
        var _pointer:UIImageView? = UIImageView()
        _pointer!.image = #imageLiteral(resourceName: "finger pointing-user")
        _pointer!.alpha = 0
        
        if let mainTableView = view.subviews[3] as? UITableView{
            if let cell = mainTableView.cellForRow(at: IndexPath(row: 4, section: 0)){
                let frame = cell.convert(cell.subviews[2].frame, to: view)
                _linkButton!.frame = frame
//                let window = UIApplication.shared.keyWindow!
                view.addSubview(_linkButton!)
                _hintLable!.frame = CGRect(x: frame.minX-20, y: frame.minY-80, width: frame.width+40, height: 40)
                view.addSubview(_hintLable!)
                view.addSubview(_pointer!)
                _pointer!.frame =  CGRect(x: frame.midX-20, y: frame.minY-40, width: 40, height: 40)
            }
        }
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0.4,
//            options: .allowUserInteraction,
            animations: {
                _focuseCommunityBlurView!.alpha = 1
                _hintLable!.alpha = 1
                _pointer!.alpha = 1
        },completion:{ finished in
            UIView.animate(
                withDuration: 0.8,
                delay: 1,
                options: .allowUserInteraction,
                animations: {
                    _focuseCommunityBlurView!.alpha = 0
                    _hintLable!.alpha = 0
                    self._linkButton!.alpha = 0
                    _pointer!.alpha = 0
            },
                completion: { finished in
                    _focuseCommunityBlurView!.removeFromSuperview()
                    _hintLable!.removeFromSuperview()
                    self._linkButton!.removeFromSuperview()
                    _pointer!.removeFromSuperview()
                    _focuseCommunityBlurView = nil
                    _hintLable = nil
                    self._linkButton = nil
                    _pointer = nil
//                    print(_focuseCommunityBlurView)
//                    print(_hintLable)
//                    print(_linkButton)
//                    print(_pointer)
            })
        })
    }
    func setRoadMapLayout(height h:CGFloat, to cell: UIView, from view:UIView){
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
    func setLinkButtonLayout(height h:CGFloat, view:UIView){
        linkButton.frame =  CGRect(x:sdGap*2+safeLeft, y: 0, width: view.frame.width*2/3, height: sdButtonHeight)
        linkButton.center.x = view.frame.width/2
        linkButton.center.y = h/2
    }
    func setStandardTextViewLayout(height h:CGFloat, view:UIView){
        let temp = 4*sdGap+safeLeft+safeRight
        standardTextView.frame = CGRect(x:sdGap*2+safeLeft+18+15, y: 15, width: view.frame.width-temp-45, height:h)
        standardTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
    }
    func setStepViewLayout(stepNum num:Int, isComplete b:Bool, height h:CGFloat) -> Step{
        let stepView = Step()
        stepView.stepNum = String(num)
        stepView.isComplete = b
        stepView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        stepView.frame = CGRect(x: sdGap*2+safeLeft, y: 0, width: UIScreen.main.bounds.width-4*sdGap-safeLeft-safeRight, height: h)
        return stepView
    }
}
