//
//  MainCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/7/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import PDFKit

class MainScene: UIView {
    
    // MARK: Global Var
    var barWidth = CGFloat(0)
    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",55),("logo", 100),("aloha", 85),("option", 17), ("blocks", 150)]
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_all")
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
    var questionMark:UIButton = {
        let questionMark = UIButton()
        questionMark.setImage(UIImage(named: "questionMark"), for: .normal)
        return questionMark
    }()
    var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    var alohaHint:UILabel = {
        let alohaHint = UILabel()
        alohaHint.text = "ALOHA!\nEvery lesson plan is unique\nWhat's yours?"
        alohaHint.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        alohaHint.textAlignment = .center
        alohaHint.numberOfLines = 0
        alohaHint.sizeToFit()
        alohaHint.textColor = .black
        return alohaHint
    }()
    var optionalHint:UILabel = {
        let hint2 = UILabel()
        hint2.text = "Please Select an Option to Start"
        hint2.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        hint2.textAlignment = .center
        hint2.numberOfLines = 1
        hint2.sizeToFit()
        hint2.textColor = .black
        return hint2
    }()
    var pdfView:PDFView = {
        let pdfView = PDFView()
        return pdfView
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
    
    let newCreatView : UIView = {
        let newCreatView = UIView()
        newCreatView.backgroundColor = UIColor.byuHRed
        newCreatView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        newCreatView.layer.shadowRadius = 2.5
        newCreatView.layer.shadowOpacity = 0.9
        newCreatView.layer.shadowColor = UIColor.darkGray.cgColor
        newCreatView.layer.cornerRadius = 4
        return newCreatView
    }()
    let newInspireView : UIView = {
        let newInspireView = UIView()
        newInspireView.backgroundColor = UIColor.byuHRed
        newInspireView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        newInspireView.layer.shadowRadius = 2.5
        newInspireView.layer.shadowOpacity = 0.9
        newInspireView.layer.shadowColor = UIColor.darkGray.cgColor
        newInspireView.layer.cornerRadius = 4
        return newInspireView
    }()
    let newRestoreView : UIView = {
        let newRestoreView = UIView()
        newRestoreView.backgroundColor = UIColor.byuHRed
        newRestoreView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        newRestoreView.layer.shadowRadius = 2.5
        newRestoreView.layer.shadowOpacity = 0.9
        newRestoreView.layer.shadowColor = UIColor.darkGray.cgColor
        newRestoreView.layer.cornerRadius = 4
        return newRestoreView
    }()
    let newBrowseView : UIView = {
        let newBrowseView = UIView()
        newBrowseView.backgroundColor = UIColor.byuHRed
        newBrowseView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        newBrowseView.layer.shadowRadius = 2.5
        newBrowseView.layer.shadowOpacity = 0.9
        newBrowseView.layer.shadowColor = UIColor.darkGray.cgColor
        newBrowseView.layer.cornerRadius = 4
        return newBrowseView
    }()
    let newCreateIcon:UIImageView = {
        let newCreateIcon = UIImageView()
        return newCreateIcon
    }()
    let newInspireIcon:UIImageView = {
        let newInspireIcon = UIImageView()
        return newInspireIcon
    }()
    let newRestoreIcon:UIImageView = {
        let newRestoreIcon = UIImageView()
        return newRestoreIcon
    }()
    let newBrowseIcon:UIImageView = {
        let newBrowseIcon = UIImageView()
        return newBrowseIcon
    }()
    let newCreateLable:UILabel = {
        let newCreateLable = UILabel()
        return newCreateLable
    }()
    let newInspireLable:UILabel = {
        let newInspireLable = UILabel()
        return newInspireLable
    }()
    let newRestoreLable:UILabel = {
        let newRestoreLable = UILabel()
        return newRestoreLable
    }()
    let newBrowseLable:UILabel = {
        let newBrowseLable = UILabel()
        return newBrowseLable
    }()
    
    // MARK: Functions
     var _newInspireView: UIView?
    func showfocuseCommunityBlurView(view:UIView,barWidth:CGFloat){
        _newInspireView = UIView()
        _newInspireView!.backgroundColor = UIColor.byuHRed
        _newInspireView!.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        _newInspireView!.layer.shadowRadius = 2.5
        _newInspireView!.layer.shadowOpacity = 0.9
        _newInspireView!.layer.shadowColor = UIColor.darkGray.cgColor
        _newInspireView!.layer.cornerRadius = 4
        var _newInspireIcon:UIImageView? = UIImageView()
        _newInspireView!.addSubview(_newInspireIcon!)
        _newInspireIcon!.translatesAutoresizingMaskIntoConstraints = false
        _newInspireIcon!.topAnchor.constraint(equalTo: _newInspireView!.topAnchor, constant: barWidth/8).isActive = true
        _newInspireIcon!.bottomAnchor.constraint(equalTo: _newInspireView!.bottomAnchor, constant: -barWidth*3/8).isActive = true
        _newInspireIcon!.leadingAnchor.constraint(equalTo: _newInspireView!.leadingAnchor, constant: barWidth/4).isActive = true
        _newInspireIcon!.trailingAnchor.constraint(equalTo: _newInspireView!.trailingAnchor, constant: -barWidth/4).isActive = true
        _newInspireIcon!.image = #imageLiteral(resourceName: "message-filled-1")
        _newInspireIcon!.contentMode = .scaleAspectFit
        var _newInspireLable:UILabel? = UILabel()
        _newInspireView!.addSubview(_newInspireLable!)
        _newInspireLable!.translatesAutoresizingMaskIntoConstraints = false
        _newInspireLable!.topAnchor.constraint(equalTo: _newInspireIcon!.bottomAnchor).isActive = true
        _newInspireLable!.bottomAnchor.constraint(equalTo: _newInspireView!.bottomAnchor).isActive = true
        _newInspireLable!.leadingAnchor.constraint(equalTo: _newInspireView!.leadingAnchor, constant: 7).isActive = true
        _newInspireLable!.trailingAnchor.constraint(equalTo: _newInspireView!.trailingAnchor, constant: -7).isActive = true
        _newInspireLable!.textAlignment = .center
        _newInspireLable!.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _newInspireLable!.numberOfLines = 0
        _newInspireLable!.text = "Get Inspired From Community"
        _newInspireLable!.adjustsFontSizeToFitWidth = true
        _newInspireLable!.textColor = .white
        
        let blurEffect = UIBlurEffect(style: .dark)
        var _focuseCommunityBlurView:UIVisualEffectView? = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(_focuseCommunityBlurView!)
        _focuseCommunityBlurView!.translatesAutoresizingMaskIntoConstraints = false
        _focuseCommunityBlurView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _focuseCommunityBlurView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        _focuseCommunityBlurView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _focuseCommunityBlurView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _focuseCommunityBlurView!.alpha = 0
        
        var _newInspireViewLable:UILabel? = UILabel()
        _newInspireViewLable!.text = "Try it!"
        _newInspireViewLable!.textColor = .white
        _newInspireViewLable!.adjustsFontSizeToFitWidth = true
        _newInspireViewLable!.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _newInspireViewLable!.textAlignment = .center
        _newInspireViewLable!.numberOfLines = 1
        _newInspireViewLable!.alpha = 0
        
        var _newPointer:UIImageView? = UIImageView()
        _newPointer?.image = #imageLiteral(resourceName: "finger pointing-user")
        _newPointer!.alpha = 0
        
        if let mainTableView = view.subviews[3] as? UITableView{
            if let cell = mainTableView.cellForRow(at: IndexPath(row: 5, section: 0)){
                let frame = cell.convert(cell.subviews[2].frame, to: view)
                _newInspireView!.frame = frame
                view.addSubview(_newInspireView!)
                _newInspireViewLable!.frame = CGRect(x: frame.minX-20, y: frame.minY-60, width: frame.width+40, height: 20)
                view.addSubview(_newInspireViewLable!)
                _newPointer!.frame =  CGRect(x: frame.midX-20, y: frame.minY-40, width: 40, height: 40)
                view.addSubview(_newPointer!)
            }
        }
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0.4,
//            options: .allowUserInteraction,
            animations: {
                _focuseCommunityBlurView!.alpha = 1
                _newInspireViewLable!.alpha = 1
                _newPointer!.alpha = 1
        },completion:{ finished in
            UIView.animate(
                withDuration: 0.8,
                delay: 1,
                options: .allowUserInteraction,
                animations: {
                    _focuseCommunityBlurView!.alpha = 0
                    _newInspireViewLable!.alpha = 0
                    self._newInspireView!.alpha = 0
                    _newPointer?.alpha = 0
            },
                completion: { finished in
                    _focuseCommunityBlurView!.removeFromSuperview()
                    _newInspireViewLable!.removeFromSuperview()
                    self._newInspireView!.removeFromSuperview()
                    _newPointer?.removeFromSuperview()
                    _focuseCommunityBlurView = nil
                    _newInspireViewLable = nil
                    self._newInspireView = nil
                    _newInspireIcon = nil
                    _newInspireLable = nil
                    _newPointer = nil
//                    print(focuseCommunityBlurView)
//                    print(_newInspireViewLable)
//                    print(self._newInspireView)
//                    print(_newInspireIcon)
//                    print(_newInspireLable)
//                    print(_newPointer)
                    
            })
        })
    }
    func setRoadMapLayout(height h:CGFloat, to cell: UIView){
        roadMap.frame = CGRect(x: 0, y:0, width: cell.frame.width, height: h)
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
    func setQuestionMarkLayout(safeRight s:CGFloat, view:UIView, markSize: CGFloat){
        questionMark.frame = CGRect(x: view.frame.width-30-5-s, y: 5, width: markSize, height: markSize)
    }
    func setLogoLayout(height h:CGFloat, view:UIView){
        logo.frame = CGRect(x:0, y: 0, width:h*0.9, height: h*0.9)
        logo.center.x = view.frame.width/2
        logo.center.y = h/2
        logo.layer.cornerRadius = 4
        logo.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        logo.layer.shadowRadius = 2.5
        logo.layer.shadowOpacity = 0.9
        logo.layer.shadowColor = UIColor.darkGray.cgColor
    }
    func setAlohaHintLayout(height h:CGFloat, view: UIView){
        alohaHint.center.x = view.frame.width/2
        alohaHint.center.y = h/2
    }
    func setOptionalHintLayout(height h:CGFloat, view:UIView){
        optionalHint.center.x = view.frame.width/2
        optionalHint.center.y = h/2
    }
    func setAnimatedChose(to view:UIView, safeLeft s:CGFloat){
        let animatedChose = UIImageView()
        animatedChose.image = #imageLiteral(resourceName: "chose")
        view.addSubview(animatedChose)
        animatedChose.translatesAutoresizingMaskIntoConstraints = false
        animatedChose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5-s).isActive = true
        animatedChose.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        animatedChose.widthAnchor.constraint(equalToConstant: 44).isActive = true
        animatedChose.heightAnchor.constraint(equalToConstant: 44).isActive = true
        UIImageView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: {
                UIImageView.modifyAnimations(
                    withRepeatCount: CGFloat.infinity,
                    autoreverses: true,
                    animations: {
                        animatedChose.alpha = 0.5
                })
        })
    }
    func setpdfViewLayout(to view:UIView){
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: sdGap).isActive = true
        pdfView.backgroundColor = UIColor.byuhMidGray
    }
    
    func setBlocksLayoutForOneLine(to cell:UIView, barWidth:CGFloat){
        removeAllConstraintsFromView(view: newCreatView)
        newCreatView.translatesAutoresizingMaskIntoConstraints = false
        newCreatView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newCreatView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: barWidth/2).isActive = true
        newCreatView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newCreatView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newInspireView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newInspireView)
        newInspireView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newInspireView.leadingAnchor.constraint(equalTo: newCreatView.trailingAnchor, constant: barWidth/2).isActive = true
        newInspireView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newInspireView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newRestoreView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newRestoreView)
        newRestoreView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newRestoreView.leadingAnchor.constraint(equalTo: newInspireView.trailingAnchor, constant: barWidth/2).isActive = true
        newRestoreView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newRestoreView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newBrowseView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newBrowseView)
        newBrowseView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newBrowseView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: -barWidth/2).isActive = true
        newBrowseView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newBrowseView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
    }
    func removeAllConstraintsFromView(view: UIView){
        for c in view.constraints {
            view.removeConstraint(c)
        }
    }
    func setBlocksLayoutForTwoLine(to cell:UIView, barWidth:CGFloat){
        newCreatView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newCreatView)
        newCreatView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newCreatView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: barWidth/2).isActive = true
        newCreatView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        newCreatView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newInspireView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newInspireView)
        newInspireView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: sdGap).isActive = true
        newInspireView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: -barWidth/2).isActive = true
        newInspireView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        newInspireView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newRestoreView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newRestoreView)
        newRestoreView.topAnchor.constraint(equalTo: newCreatView.bottomAnchor, constant: barWidth/4).isActive = true
        newRestoreView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newRestoreView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: barWidth/2).isActive = true
        newRestoreView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
        
        newBrowseView.translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraintsFromView(view: newBrowseView)
        newBrowseView.topAnchor.constraint(equalTo: newCreatView.bottomAnchor, constant: barWidth/4).isActive = true
        newBrowseView.heightAnchor.constraint(equalToConstant: barWidth).isActive = true
        newBrowseView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: -barWidth/2).isActive = true
        newBrowseView.widthAnchor.constraint(equalToConstant: barWidth).isActive = true
    }
    func setBlockLayout(barWidth:CGFloat){
        newCreatView.addSubview(newCreateIcon)
        newCreateIcon.translatesAutoresizingMaskIntoConstraints = false
        newCreateIcon.topAnchor.constraint(equalTo: newCreatView.topAnchor, constant: barWidth/8).isActive = true
        newCreateIcon.bottomAnchor.constraint(equalTo: newCreatView.bottomAnchor, constant: -barWidth*3/8).isActive = true
        newCreateIcon.leadingAnchor.constraint(equalTo: newCreatView.leadingAnchor, constant: barWidth/4).isActive = true
        newCreateIcon.trailingAnchor.constraint(equalTo: newCreatView.trailingAnchor, constant: -barWidth/4).isActive = true
        newCreateIcon.image = #imageLiteral(resourceName: "copy-filled")
        newCreateIcon.contentMode = .scaleAspectFit
        newCreatView.addSubview(newCreateLable)
        newCreateLable.translatesAutoresizingMaskIntoConstraints = false
        newCreateLable.topAnchor.constraint(equalTo: newCreateIcon.bottomAnchor).isActive = true
        newCreateLable.bottomAnchor.constraint(equalTo: newCreatView.bottomAnchor).isActive = true
        newCreateLable.leadingAnchor.constraint(equalTo: newCreatView.leadingAnchor, constant: 2.2*sdGap).isActive = true
        newCreateLable.trailingAnchor.constraint(equalTo: newCreatView.trailingAnchor, constant: -2.2*sdGap).isActive = true
        newCreateLable.textAlignment = .center
        newCreateLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        newCreateLable.numberOfLines = 0
        newCreateLable.text = "Create a New Lesson Plan"
        newCreateLable.adjustsFontSizeToFitWidth = true
        newCreateLable.textColor = .white
        
        newInspireView.addSubview(newInspireIcon)
        newInspireIcon.translatesAutoresizingMaskIntoConstraints = false
        newInspireIcon.topAnchor.constraint(equalTo: newInspireView.topAnchor, constant: barWidth/8).isActive = true
        newInspireIcon.bottomAnchor.constraint(equalTo: newInspireView.bottomAnchor, constant: -barWidth*3/8).isActive = true
        newInspireIcon.leadingAnchor.constraint(equalTo: newInspireView.leadingAnchor, constant: barWidth/4).isActive = true
        newInspireIcon.trailingAnchor.constraint(equalTo: newInspireView.trailingAnchor, constant: -barWidth/4).isActive = true
        newInspireIcon.image = #imageLiteral(resourceName: "message-filled-1")
        newInspireIcon.contentMode = .scaleAspectFit
        newInspireView.addSubview(newInspireLable)
        newInspireLable.translatesAutoresizingMaskIntoConstraints = false
        newInspireLable.topAnchor.constraint(equalTo: newInspireIcon.bottomAnchor).isActive = true
        newInspireLable.bottomAnchor.constraint(equalTo: newInspireView.bottomAnchor).isActive = true
        newInspireLable.leadingAnchor.constraint(equalTo: newInspireView.leadingAnchor, constant: sdGap).isActive = true
        newInspireLable.trailingAnchor.constraint(equalTo: newInspireView.trailingAnchor, constant: -sdGap).isActive = true
        newInspireLable.textAlignment = .center
        newInspireLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        newInspireLable.numberOfLines = 0
        newInspireLable.text = "Get Inspired From Community"
        newInspireLable.adjustsFontSizeToFitWidth = true
        newInspireLable.textColor = .white
        
        newRestoreView.addSubview(newRestoreIcon)
        newRestoreIcon.translatesAutoresizingMaskIntoConstraints = false
        newRestoreIcon.topAnchor.constraint(equalTo: newRestoreView.topAnchor, constant: barWidth/8).isActive = true
        newRestoreIcon.bottomAnchor.constraint(equalTo: newRestoreView.bottomAnchor, constant: -barWidth*3/8).isActive = true
        newRestoreIcon.leadingAnchor.constraint(equalTo: newRestoreView.leadingAnchor, constant: barWidth/4).isActive = true
        newRestoreIcon.trailingAnchor.constraint(equalTo: newRestoreView.trailingAnchor, constant: -barWidth/4).isActive = true
        newRestoreIcon.image = #imageLiteral(resourceName: "unarchive-filled-1")
        newRestoreIcon.contentMode = .scaleAspectFit
        newRestoreView.addSubview(newRestoreLable)
        newRestoreLable.translatesAutoresizingMaskIntoConstraints = false
        newRestoreLable.topAnchor.constraint(equalTo: newRestoreIcon.bottomAnchor).isActive = true
        newRestoreLable.bottomAnchor.constraint(equalTo: newRestoreView.bottomAnchor).isActive = true
        newRestoreLable.leadingAnchor.constraint(equalTo: newRestoreView.leadingAnchor, constant: sdGap).isActive = true
        newRestoreLable.trailingAnchor.constraint(equalTo: newRestoreView.trailingAnchor, constant: -sdGap).isActive = true
        newRestoreLable.textAlignment = .center
        newRestoreLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        newRestoreLable.numberOfLines = 0
        newRestoreLable.text = "Restore My Last Saved Lesson Plan"
        newRestoreLable.adjustsFontSizeToFitWidth = true
        newRestoreLable.textColor = .white
        
        newBrowseView.addSubview(newBrowseIcon)
        newBrowseIcon.translatesAutoresizingMaskIntoConstraints = false
        newBrowseIcon.topAnchor.constraint(equalTo: newBrowseView.topAnchor, constant: barWidth/8).isActive = true
        newBrowseIcon.bottomAnchor.constraint(equalTo: newBrowseView.bottomAnchor, constant: -barWidth*3/8).isActive = true
        newBrowseIcon.leadingAnchor.constraint(equalTo: newBrowseView.leadingAnchor, constant: barWidth/4).isActive = true
        newBrowseIcon.trailingAnchor.constraint(equalTo: newBrowseView.trailingAnchor, constant: -barWidth/4).isActive = true
        newBrowseIcon.image = #imageLiteral(resourceName: "folder-filled-1")
        newBrowseIcon.contentMode = .scaleAspectFit
        newBrowseView.addSubview(newBrowseLable)
        newBrowseLable.translatesAutoresizingMaskIntoConstraints = false
        newBrowseLable.topAnchor.constraint(equalTo: newBrowseIcon.bottomAnchor).isActive = true
        newBrowseLable.bottomAnchor.constraint(equalTo: newBrowseView.bottomAnchor).isActive = true
        newBrowseLable.leadingAnchor.constraint(equalTo: newBrowseView.leadingAnchor, constant: sdGap).isActive = true
        newBrowseLable.trailingAnchor.constraint(equalTo: newBrowseView.trailingAnchor, constant: -sdGap).isActive = true
        newBrowseLable.textAlignment = .center
        newBrowseLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        newBrowseLable.numberOfLines = 0
        newBrowseLable.text = "Browse My Lesson Plan PDFs"
        newBrowseLable.adjustsFontSizeToFitWidth = true
        newBrowseLable.textColor = .white
    }
}
