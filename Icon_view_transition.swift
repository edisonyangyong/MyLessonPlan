//
//  Icon_view_transition.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/18/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
class Icon_view_transition: NSObject {
    public var circle = UIView()
    var startingPoint = CGPoint(x: 0, y: 0)
    var circleColor:UIColor?
    var duration = 2.5
    enum CircularTransitionMode: Int{
        case present, dismiss, pop
    }
    var transitionMode: CircularTransitionMode = .present
}

extension Icon_view_transition: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present{
            if let presentedView = transitionContext.view(forKey:UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                containerView.addSubview(presentedView)
                circle.transform = CGAffineTransform(scaleX: 0.001 , y: 0.001)
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001 , y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(circle)
                containerView.addSubview(presentedView)
                UIView.animate(
                    withDuration: 1,
                    animations: {
                        self.circle.transform = CGAffineTransform.identity
                },
                    completion: { (success:Bool) in
                        transitionContext.completeTransition(success)
                })
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        presentedView.transform = CGAffineTransform.identity
                                                presentedView.alpha = 1
                                                presentedView.center = viewCenter
                })
            }
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        self.circle.transform = CGAffineTransform(scaleX: 0.001, y:0.001)
                })
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        returningView.transform = CGAffineTransform(scaleX: 0.001, y:0.001)
                        returningView.alpha = 0
                        returningView.center = self.startingPoint
                        if self.transitionMode == .pop{
                            containerView.insertSubview(returningView, belowSubview:returningView)
                            containerView.insertSubview(self.circle, belowSubview: returningView)
                        }
                },
                    completion: { (success:Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()
                        self.circle.removeFromSuperview()
                        transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect{
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        let offsetVector = sqrt(xLength * xLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        return CGRect(origin:CGPoint.zero, size:size)
    }
}

