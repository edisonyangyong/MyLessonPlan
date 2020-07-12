//
//  SubObjectiveViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/25/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class SubObjectiveViewController: UIViewController {
    
    // MARK: Global Var
    var objectiveData = ""
    var delegate:ObjectiveDataFlowUpdatingDelegation?
    var subContentWidth: CGFloat = 0
    var subContentHeight: CGFloat = 0
    private let textViewWhat = UITextView()
    private let textViewHow = UITextView()
    private let textViewEnd = UITextView()
    private let verbRect = UILabel()
    private let sideBarView = SideBar()
    private var currentTabbedTextView = 0
    var preObjectiveText = ""{
        didSet{
            textViewEnd.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textViewEnd.text = preObjectiveText + " " + middleObjectiveText.lowercased() + " " + postObjectiveText.lowercased()
            delegate?.updateDataFlowFromSubObjective(viewController: self, from: textViewEnd.text)
        }
    }
    var middleObjectiveText = ""{
        didSet{
            textViewEnd.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textViewEnd.text = preObjectiveText + " " + middleObjectiveText.lowercased() + " " + postObjectiveText.lowercased()
            delegate?.updateDataFlowFromSubObjective(viewController: self, from: textViewEnd.text)
        }
    }
    var postObjectiveText:String = ""{
        didSet{
            textViewEnd.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textViewEnd.text = preObjectiveText + " " + middleObjectiveText.lowercased() + " " + postObjectiveText.lowercased()
            delegate?.updateDataFlowFromSubObjective(viewController: self, from: textViewEnd.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleHeight = CGFloat(17.0)
        let textFieldHeight = (subContentHeight-50.0-titleHeight*3)/4
        
        // What
        let titleWhat = UILabel()
        titleWhat.frame = CGRect(x: 30, y: 50, width: subContentWidth-30, height: 17)
        titleWhat.text = "What"
        titleWhat.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        titleWhat.textColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        self.view.addSubview(titleWhat)
        
        // Border
        let borderForColor = UIView()
        borderForColor.frame = CGRect(x:  30, y: 50+17 , width: subContentWidth-30, height: textFieldHeight)
        borderForColor.backgroundColor = UIColor.sdTextFieldColor()
        self.view.addSubview(borderForColor)
        
        // Each student can
        let labelEachStudentCan = UILabel()
        labelEachStudentCan.frame = CGRect(x: 30, y: titleWhat.frame.maxY, width: (subContentWidth-30)*2/3 - titleHeight, height: textFieldHeight/3)
        labelEachStudentCan.text = "Each student can"
        labelEachStudentCan.textAlignment = .left
        labelEachStudentCan.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        labelEachStudentCan.textColor = .black
        labelEachStudentCan.adjustsFontSizeToFitWidth = true
        self.view.addSubview(labelEachStudentCan)

        // Verb
        verbRect.frame = CGRect(x: 30 + labelEachStudentCan.frame.width + titleHeight/2, y: labelEachStudentCan.frame.minY, width: subContentWidth - (30 + labelEachStudentCan.frame.width + titleHeight), height: textFieldHeight/3)
        verbRect.textAlignment = .center
        verbRect.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        verbRect.textColor = .lightGray
        verbRect.numberOfLines = 0
        verbRect.adjustsFontSizeToFitWidth = true
        verbRect.text = "Select a Verb From Right"
        self.view.addSubview(verbRect)

        // Insert what
        textViewWhat.frame = CGRect(x: 30, y: labelEachStudentCan.frame.maxY, width: subContentWidth-30, height: textFieldHeight*2/3)
        textViewWhat.backgroundColor = UIColor.sdTextFieldColor()
        textViewWhat.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
        textViewWhat.textColor = .lightGray
        textViewWhat.delegate = self
        textViewWhat.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        textViewWhat.text = "insert \"what\" "
        textViewWhat.tag = 1
        self.view.addSubview(textViewWhat)
        textViewWhat.isAccessibilityElement = true
        textViewWhat.accessibilityIdentifier = "whatTextView"

        // How well
        let titleHowWell = UILabel()
        titleHowWell.frame = CGRect(x: 30, y: 50+titleHeight+textFieldHeight, width: subContentWidth-30, height: titleHeight)
        titleHowWell.text = "How Well"
        titleHowWell.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        titleHowWell.adjustsFontSizeToFitWidth = true
        titleHowWell.textColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        self.view.addSubview(titleHowWell)

        // Insert How well
        textViewHow.frame = CGRect(x:  30, y: titleHowWell.frame.maxY, width: subContentWidth-30, height: textFieldHeight)
        textViewHow.backgroundColor = UIColor.sdTextFieldColor()
        textViewHow.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
        textViewHow.textColor = .lightGray
        textViewHow.delegate = self
        textViewHow.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        textViewHow.text = "insert \"How well\""
        textViewHow.tag = 2
        self.view.addSubview(textViewHow)
        textViewHow.isAccessibilityElement = true
        textViewHow.accessibilityIdentifier = "howTextView"
        
        // Complete Objective
        let titleComplete = UILabel()
        titleComplete.frame = CGRect(x: 30, y: textViewHow.frame.maxY, width: subContentWidth-30, height: titleHeight)
        titleComplete.text = "Complete Objective"
        titleComplete.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        titleComplete.textColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        self.view.addSubview(titleComplete)
        
        // Each student can ....
        textViewEnd.frame = CGRect(x:  30, y: titleComplete.frame.maxY, width: subContentWidth-30, height: textFieldHeight*2-6)
        textViewEnd.backgroundColor = UIColor.sdTextFieldColor()
        textViewEnd.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
        if objectiveData == ""{
             textViewEnd.textColor = .lightGray
             textViewEnd.text = "Each student can ..."
        }else{
            textViewEnd.textColor = .black
            textViewEnd.text = objectiveData
        }
        textViewEnd.delegate = self
        textViewEnd.textAlignment = .left
        textViewEnd.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        textViewEnd.tag = 3
        self.view.addSubview(textViewEnd)
        textViewEnd.isAccessibilityElement = true
        textViewEnd.accessibilityIdentifier = "endTextView"
        
        // Side Bar
        sideBarView.backgroundColor = UIColor.byuHlightGray
        sideBarView.frame = CGRect(x: 0, y: 50, width: 30, height: subContentHeight-50)
        sideBarView.step = 0
        sideBarView.topGap = labelEachStudentCan.frame.height/2
        sideBarView.middleGap = titleHowWell.frame.midY - 50
        sideBarView.finalGap = titleComplete.frame.midY - 50
        self.view.addSubview(sideBarView)
    }
}

// MARK: Functions
extension SubObjectiveViewController{
    func getVerb(selected s: String){
        verbRect.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize)
        verbRect.numberOfLines = 1
        verbRect.textColor = .black
        verbRect.adjustsFontSizeToFitWidth = true
        verbRect.text = s.lowercased()
        preObjectiveText = "Each student can " + s.lowercased()
    }
    @objc func tapDone(){
        self.view.endEditing(true)
    }
    @objc func tabPaste(){
        let pb: UIPasteboard = UIPasteboard.general
        switch currentTabbedTextView {
        case 1:
            textViewWhat.text += pb.string ?? ""
            textViewWhat.textColor = .black
            middleObjectiveText = textViewWhat.text
        case 2:
            textViewHow.text += pb.string ?? ""
            textViewHow.textColor = .black
            postObjectiveText = textViewHow.text
        case 3:
            textViewEnd.text += pb.string ?? ""
            textViewEnd.textColor = .black
            delegate?.updateDataFlowFromSubObjective(viewController: self, from: textViewEnd.text)
        default:
            return
        }
    }
}

//  MARK: Delegate
extension SubObjectiveViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text == "insert \"what\" " ||
            textView.text == "insert \"How well\"" ||
        textView.text == "Each student can ..."{
            textView.text = ""
            textView.textColor = .black
        }
        switch textView.tag {
        case 1:
            sideBarView.firstDotShouldFill = (textView.text == "") ? false : true
            sideBarView.step = 1
            currentTabbedTextView = 1
        case 2:
            sideBarView.secondDotShouldFill = (textView.text == "") ? false : true
            sideBarView.step = 2
            currentTabbedTextView = 2
        case 3:
            sideBarView.starShouldFill = (textView.text == "") ? false : true
            sideBarView.step = 3
            currentTabbedTextView = 3
        default:
            sideBarView.step = 0
            currentTabbedTextView = 0
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        switch textView.tag {
        case 1:
            sideBarView.firstDotShouldFill = (textView.text == "") ? false : true
            middleObjectiveText = textView.text
        case 2:
            sideBarView.secondDotShouldFill = (textView.text == "") ? false : true
            postObjectiveText = textView.text
        case 3:
            sideBarView.starShouldFill = (textView.text == "") ? false : true
            delegate?.updateDataFlowFromSubObjective(viewController: self, from: textViewEnd.text)
        default:
            return
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.saveToDiskAndUpdateReminer()
    }
}

