//
//  InstructionScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/11/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class InstructionScene: UIView {
    
    //    var cellHeights: [(name:String,height:CGFloat)] = [("roadMap", 250),("curve",44),("reminder", 200),("title", 140),("bars", 500),("mainContentTitle",44)]
    
    var cellHeightsDict = [
        "0_roadMap": CGFloat(250.0),
        "1_curve": CGFloat(55.0),
        "2_reminder":CGFloat(200.0),
        "3_title":CGFloat(140.0),
        "4_bars":CGFloat(500.0),
//        "5_mainContentTitle":CGFloat(44.0)
    ]
    
    var roadMap:UIImageView = {
        let roadMap = UIImageView()
        roadMap.image = #imageLiteral(resourceName: "roadMap_Instruction")
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
    var redoImageView:UIImageView={
        let redoImageView = UIImageView()
        redoImageView.image = #imageLiteral(resourceName: "undo-filled")
        redoImageView.isUserInteractionEnabled = true
        return redoImageView
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
    var bars:[ModelBarView] = {
        var bars:[ModelBarView] = []
        for i in 0...5{
            bars.append(ModelBarView())
        }
        return bars
    }()
    var mainContentTitle:UILabel={
        let mainContentTitle = UILabel()
        return mainContentTitle
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
        what.text = "What is Instruction Sequence"
        what.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        what.textAlignment = .center
        what.textColor = .black
        what.adjustsFontSizeToFitWidth = true
        return what
    }()
    var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "Tip: use drag and drop\nto combine the following instructional models"
        tipLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        tipLabel.textAlignment = .center
        tipLabel.numberOfLines = 0
        tipLabel.textColor = .black
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
    }()
    
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
        _hintLable!.text = "Combine your models"
        _hintLable!.textColor = .white
        _hintLable!.adjustsFontSizeToFitWidth = true
        _hintLable!.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        _hintLable!.textAlignment = .center
        _hintLable!.alpha = 0
        
        var _pointer:UIImageView? = UIImageView()
        _pointer!.image = #imageLiteral(resourceName: "hand click-user")
        //        _pointer!.alpha = 0
        
        var frame = CGRect()
        if let mainTableView = view.subviews[3] as? UITableView{
            if let cell = mainTableView.cellForRow(at: IndexPath(row: 4, section: 0)){
                frame = cell.convert(cell.subviews[0].frame, to: view)
//                let window = UIApplication.shared.keyWindow!
                _focuseBlurViewUp!.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: frame.minY+sdGap)
                _focuseBlurViewLeft!.frame = CGRect(x: 0, y: frame.minY+sdGap, width: 22+safeLeft, height: view.frame.height-frame.minY+sdGap)
                _focuseBlurViewRight!.frame = CGRect(x: view.frame.width-22-safeRight, y: frame.minY+sdGap, width: 22+safeRight, height:view.frame.height-frame.minY+sdGap)
                _focuseBlurViewDown!.frame = CGRect(x: 22+safeLeft, y: view.frame.height-safeBottom-44-sdGap, width: frame.width-44, height: safeBottom+44+sdGap)
                
                _pointer!.frame = CGRect(x: 22+safeLeft+50, y: frame.minY-40, width: 40, height: 40)
                view.addSubview(_pointer!)
                
                _hintLable!.frame = CGRect(x: frame.midX-100, y: frame.minY-40-40, width: 200, height: 40)
                view.addSubview(_hintLable!)
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
            UIImageView.animate(
                withDuration: 2,
                delay: 0,
                options: [],
                animations: {
                    _pointer!.frame = CGRect(x: view.frame.width-22-self.safeRight-50, y: frame.minY-40, width: 40, height: 40)
            },completion: { finish in
                UIView.animate(
                    withDuration: 0.8,
                    delay: 0,
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
                        
//                        print(_focuseBlurViewUp)
//                        print(_focuseBlurViewLeft)
//                        print(_focuseBlurViewRight)
//                        print(_focuseBlurViewDown)
//                        print(_hintLable)
//                        print(_pointer)
                })
            })
        })
    }
    func cellHeightsSorttedList() -> Array<String>{
        var keysList = [String](self.cellHeightsDict.keys)
        keysList.sort{$0 < $1}
        return keysList
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
    func setCurveLayout(height h:CGFloat,view:UIView){
        curve.frame = CGRect(x: 0, y: 0, width:  view.frame.width, height: h)
        curve.roundedTopCorner(radius: Int(h))
    }
    func setRedoLayout(height h:CGFloat, view:UIView){
        redoImageView.frame = CGRect(x: view.frame.width-safeRight-sdGap-44, y: h-44, width: 44, height: 44)
    }
    func setBarsLayout(numOfCols: Int, cell:UIView, view:UIView, barWidth: CGFloat,data:Model, removeIndex:Int?, redo:Bool){
        if removeIndex != nil{
            bars.remove(at: removeIndex!)
        }
        if redo && bars.count < data.instructionSequence.count{
            for _ in 0..<data.instructionSequence.count-bars.count{
                bars.append(ModelBarView())
            }
        }
        // get row num
        let numOfRows = Int(ceil(Double(data.instructionSequence.count) / Double(numOfCols)))
        //        print("numOfRows: \(numOfRows)")
        //        print("numOfCols: \(numOfCols)")
        var index = 0
        for row in 0..<numOfRows{
            for col in 0..<numOfCols{
                if index < data.instructionSequence.count{
                    bars[index].frame = CGRect(
                        x: safeLeft+22+CGFloat(col+1)*2*sdGap+CGFloat(col)*barWidth,
                        y: CGFloat(row)*barWidth+CGFloat(row+1)*2*sdGap,
                        width:barWidth ,
                        height: barWidth)
                    
                    let chars = Array(data.instructionSequence[index].title)
                    if !chars.contains("\n"){
                        bars[index].defaultColor = data.instructionSequence[index].color
                        bars[index].backgroundColor = data.instructionSequence[index].color
                    }else{
                        bars[index].backgroundColor = UIColor.byuhGold
                    }
                    bars[index].data = data.instructionSequence[index].steps
                    bars[index].objectiveData = data.learningObjectiveOne + data.learningObjectiveTwo
                    bars[index].layer.cornerRadius = 10
                    bars[index].layer.masksToBounds = true
                    bars[index].barTitle = data.instructionSequence[index].title
                    bars[index].barWidth = barWidth
                    cell.addSubview(bars[index])
                    if redo{
                        UIView.transition(with: bars[index], duration: 1, options:.transitionCrossDissolve, animations: {})
                    }
                    index += 1
                }
            }
        }
    }
    func setUpmainContentTitleLayout(height h:CGFloat, view:UIView){
        mainContentTitle.frame = CGRect(x: 2*sdGap+safeLeft, y: 0, width: view.frame.width-4*sdGap-safeLeft-safeRight, height: h)
        mainContentTitle.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        mainContentTitle.numberOfLines = 0
        mainContentTitle.textAlignment = .center
        mainContentTitle.textColor = .black
        mainContentTitle.adjustsFontSizeToFitWidth = true
        mainContentTitle.center.x = view.frame.width/2
        mainContentTitle.center.y = h/2
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
