//
//  Step.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/5/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class Step: UIView {
    
    var stepNum = "1"
    
    var isComplete = true{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 12.5,y: 0))
        line.addLine(to: CGPoint(x: 12.5, y: self.frame.height/2-14))
        line.move(to: CGPoint(x: 12.5,y: self.frame.height/2+9))
        line.addLine(to: CGPoint(x: 12.5, y: self.frame.height))
        line.lineWidth = 4
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        line.stroke()
        
        let num = UIButton()
        num.frame = CGRect(x: 3.5, y: (self.frame.height)/2-15+3.5, width: 18, height: 18)
        num.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        num.titleLabel?.adjustsFontSizeToFitWidth = true
        num.layer.cornerRadius = 0.5*24
        num.layer.borderColor = #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 0)
        num.layer.borderWidth = 4
        num.setTitle(stepNum, for: .normal)
        if !isComplete{
            num.setTitleColor(#colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1), for: .normal)
            num.titleLabel?.backgroundColor = .white
            num.titleLabel?.tintColor = .white
        }else{
            num.backgroundColor = UIColor.byuHRed
            num.titleLabel?.backgroundColor = UIColor.byuHRed
            num.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.addSubview(num)
        
        let gearImage = UIImageView()
        gearImage.image = #imageLiteral(resourceName: "Gear")
        gearImage.frame =  CGRect(x: 0, y: (self.frame.height)/2-15, width: 24, height: 24)
        self.addSubview(gearImage)
        
        UIImageView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.curveLinear,.beginFromCurrentState],
            animations: {
                UIImageView.modifyAnimations(withRepeatCount: CGFloat(Double.infinity), autoreverses: false, animations: {
                    gearImage.transform = gearImage.transform.rotated(by:  CGFloat(Double.pi)*0.9)
                })
        })
    }
}
