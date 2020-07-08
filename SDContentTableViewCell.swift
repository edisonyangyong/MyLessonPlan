//
//  SDContentTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/22/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class SDContentTableViewCell: UITableViewCell {
    var label = UILabel()
    var textView = UITextView()
    var questionMark = UIImageView()
    var shouldFill = false{
        didSet{
            setNeedsDisplay()
        }
    }
    var delegate:SDContentTableViewCellDataFlowUpdatingDelegation?
    var shape:String = ""
    var shouldReload = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        fillLine(from: CGPoint(x: sdGap+5, y: 0), to: CGPoint(x: sdGap+5, y: self.frame.maxY))
        if shape == "triangle"{
            drawTrangle(isFill: shouldFill)
        }else if shape == "circle"{
            drawCircle(center: CGPoint(x:sdGap+5, y:7), isFill: shouldFill)
        }else{
            drawStar(isFill: shouldFill)
        }
    }
    func setupLayout(view:UIView){
        label.frame = CGRect(x: 30, y: 0, width: view.frame.width-60, height: 17)
        label.textColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        label.backgroundColor = UIColor.byuHlightGray
        label.sizeToFit()
        self.addSubview(label)

        textView.frame = CGRect(x: 30, y: label.frame.maxY, width: view.frame.width-60, height: 150-17)
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor.sdTextFieldColor()
        textView.delegate = self
        shouldFill = (textView.text == "" ||
            textView.text == "(Optional)" ||
            textView.text == "(Required)"
            ) ? false : true
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
        self.addSubview(textView)
        
        questionMark.image = #imageLiteral(resourceName: "Help")
        questionMark.isUserInteractionEnabled = true
        questionMark.frame = CGRect(x: label.frame.maxX+sdGap, y: 0, width: 13, height: 13)
        self.addSubview(questionMark)
    }
    func fillLine(from: CGPoint, to: CGPoint){
        let line = UIBezierPath()
        line.move(to: CGPoint(x:from.x, y:from.y))
        line.addLine(to: CGPoint(x: to.x, y: to.y))
        line.lineWidth = 4
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setFill()
        line.fill()
        line.stroke()
    }
    func drawCircle(center: CGPoint, isFill: Bool){
        let circle = UIBezierPath()
        circle.addArc(withCenter: center, radius: 5, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        circle.lineWidth = 4
        if isFill{
            #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setFill()
        }else{
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        }
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        circle.fill()
        circle.stroke()
    }
    func drawTrangle(isFill: Bool){
        let trangle = UIBezierPath()
        trangle.move(to: CGPoint(x: sdGap+5, y: 3.5))
        trangle.addLine(to: CGPoint(x: sdGap+7.5, y: 7.5))
        trangle.addLine(to: CGPoint(x: sdGap+2.5, y: 7.5))
        trangle.close()
        if isFill{
            #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setFill()
        }else{
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        }
         #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        trangle.lineWidth = 6
        trangle.stroke()
        trangle.fill()
    }
    func drawStar(isFill: Bool){
        let star = drawStarBezier(x: sdGap+5, y: 8, radius: 4, sides: 5, pointyness: 2)
        star.lineWidth = 3
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        if isFill{
            #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setFill()
        }else{
             #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        }
        star.fill()
        star.stroke()
    }
    func changeTextViewHeight(view: UIView, to height:CGFloat){
        textView.frame = CGRect(x: 30, y: label.frame.maxY, width: view.frame.width-60, height: height-17)
    }
}

extension SDContentTableViewCell:UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        if textView.text == "(Required)" || textView.text == "(Optional)"{
            textView.text = ""
            textView.textColor = .black
        }
        #if targetEnvironment(macCatalyst)
        if shouldReload{
            shouldReload = false
            delegate?.callReloadMainTableView(cell: self)
            textView.becomeFirstResponder()
        }
        #endif
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        shouldFill = (textView.text == "") ? false : true
        // update the Module
        delegate?.updateDataFlowFromSDContentTableVC(step: label.text!, content: textView.text, save: false)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" && label.text != "My Learning Objective One" && label.text != "My Learning Objective Two"{
            if label.text == "Closure" ||
            label.text == "Anticipatory Set"{
                 textView.textColor = .lightGray
                 textView.text = "(Required)"
            }else{
                textView.textColor = .lightGray
                textView.text = "(Optional)"
            }
        }
        shouldReload = true
        delegate?.updateDataFlowFromSDContentTableVC(step: "", content: "", save: true)
    }
}



