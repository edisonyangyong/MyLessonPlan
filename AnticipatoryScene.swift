//
//  AnticipatoryScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/11/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class AnticipatoryScene: UIView {
    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",55),("reminder", 200),("title", 120),("inspire", 80),("textView", 150),("textView", 150),("textView", 150)]
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_Anticipatory")
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
    var inspirationButton:UIButton = {
        let inspirationButton = UIButton(type: .system)
        inspirationButton.backgroundColor = #colorLiteral(red: 0.742426753, green: 0.1857207716, blue: 0.7242348194, alpha: 1)
        inspirationButton.setTitle("Inspire Me", for: .normal)
        inspirationButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!
        inspirationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        inspirationButton.titleLabel?.textAlignment = .center
        inspirationButton.tintColor = .white
        inspirationButton.layer.cornerRadius = 20
        inspirationButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        inspirationButton.layer.shadowRadius = 2.5
        inspirationButton.layer.shadowOpacity = 0.9
        inspirationButton.layer.shadowColor = UIColor.darkGray.cgColor
        return inspirationButton
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
        what.text = "What is Anticipatory Set"
        what.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        what.textAlignment = .center
        what.textColor = .black
        what.adjustsFontSizeToFitWidth = true
        return what
    }()
    var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "Tip: Check out some awesome ideas"
        tipLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        tipLabel.textAlignment = .center
        tipLabel.numberOfLines = 0
        tipLabel.textColor = .black
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
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
    
    var _inspirationButton:UIButton? = UIButton(type: .system)
    func showfocuseLinkBlurView(view:UIView){
         _inspirationButton = UIButton(type: .system)
        _inspirationButton!.backgroundColor = #colorLiteral(red: 0.742426753, green: 0.1857207716, blue: 0.7242348194, alpha: 1)
        _inspirationButton!.setTitle("Inspire Me", for: .normal)
        _inspirationButton!.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)!
        _inspirationButton!.titleLabel?.adjustsFontSizeToFitWidth = true
        _inspirationButton!.titleLabel?.textAlignment = .center
        _inspirationButton!.tintColor = .white
        _inspirationButton!.layer.cornerRadius = 20
        _inspirationButton!.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        _inspirationButton!.layer.shadowRadius = 2.5
        _inspirationButton!.layer.shadowOpacity = 0.9
        _inspirationButton!.layer.shadowColor = UIColor.darkGray.cgColor
        _inspirationButton!.alpha = 1
        
        let blurEffect = UIBlurEffect(style: .dark)
        var _focuseBlurView:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(_focuseBlurView!)
        _focuseBlurView!.translatesAutoresizingMaskIntoConstraints = false
        _focuseBlurView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _focuseBlurView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        _focuseBlurView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _focuseBlurView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _focuseBlurView!.alpha = 0
        
        var _hintLable:UILabel? = UILabel()
        _hintLable!.text = "Try it!"
        _hintLable!.textColor = .white
        _hintLable!.adjustsFontSizeToFitWidth = true
        _hintLable!.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _hintLable!.textAlignment = .center
        _hintLable!.numberOfLines = 0
        _hintLable!.alpha = 0
        
        var _pointer:UIImageView? = UIImageView()
        _pointer?.image = #imageLiteral(resourceName: "finger pointing-user")
        _pointer!.alpha = 0
        
        if let mainTableView = view.subviews[3] as? UITableView{
            if let cell = mainTableView.cellForRow(at: IndexPath(row: 4, section: 0)){
                let frame = cell.convert(cell.subviews[1].frame, to: view)
                _inspirationButton!.frame = frame
//                let window = UIApplication.shared.keyWindow!
                view.addSubview(_inspirationButton!)
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
                _focuseBlurView!.alpha = 1
                self._inspirationButton!.alpha = 1
                _pointer!.alpha = 1
                _hintLable!.alpha = 1
        },completion:{ finished in
            UIView.animate(
                withDuration: 0.8,
                delay: 1,
                options: .allowUserInteraction,
                animations: {
                    _focuseBlurView!.alpha = 0
                    self._inspirationButton!.alpha = 0
                    _hintLable!.alpha = 0
                    _pointer?.alpha = 0
            },
                completion: { finished in
                    _focuseBlurView!.removeFromSuperview()
                    self._inspirationButton!.removeFromSuperview()
                    _hintLable!.removeFromSuperview()
                    _pointer?.removeFromSuperview()
                    _focuseBlurView = nil
                    self._inspirationButton = nil
                    _hintLable = nil
                    _pointer = nil
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
    func setInspireButtonLayout(height h:CGFloat, view:UIView){
        inspirationButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize)
        inspirationButton.frame =  CGRect(x:sdGap*2+safeLeft, y: 0, width: view.frame.width*2/3, height: sdButtonHeight)
        inspirationButton.center.x = view.frame.width/2
        inspirationButton.center.y = h/2
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
