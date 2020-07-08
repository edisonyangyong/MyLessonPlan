//
//  SideBar.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/27/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

internal class SideBar: UIView {
    
    var step: Int = 0 {
        didSet{
            setNeedsDisplay()
        }
    }
    var firstDotShouldFill: Bool = false{
        didSet{
            setNeedsDisplay()
        }
    }
    var secondDotShouldFill: Bool = false{
        didSet{
            setNeedsDisplay()
        }
    }
    var starShouldFill: Bool = false{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var topGap:CGFloat = CGFloat(0)
    var middleGap:CGFloat = CGFloat(0)
    var finalGap:CGFloat = CGFloat(0)
    
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
    func drawStar(isFill: Bool){
        let star = drawStarBezier(x: self.frame.midX, y: finalGap, radius: 4, sides: 5, pointyness: 2)
        star.lineWidth = 4
        #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setStroke()
        if isFill{
            #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1).setFill()
        }else{
             #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        }
        star.fill()
        star.stroke()
    }
    override func draw(_ rect: CGRect) {
        fillLine(from: CGPoint(x: self.frame.midX, y: 17/2), to: CGPoint(x: self.frame.midX, y: middleGap - 5))
        fillLine(from: CGPoint(x: self.frame.midX, y: middleGap + 5), to: CGPoint(x: self.frame.midX, y: finalGap-2))
        
        drawCircle(center: CGPoint(x:self.frame.midX, y:17/2), isFill: firstDotShouldFill)
        drawCircle(center: CGPoint(x: self.frame.midX, y: middleGap), isFill: secondDotShouldFill)
        drawStar(isFill: starShouldFill)
    }
}


