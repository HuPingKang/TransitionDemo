//
//  RotationAnimation.swift
//  CustomTransition
//
//  Created by qwer on 2018/3/22.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class RotationAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    //是否推出：
    var isPresenting:Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //present 时调用；
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let finalRect = transitionContext.finalFrame(for: toVc!)
   
        toVc?.view.frame = finalRect.offsetBy(dx: isPresenting ? UIScreen.main.bounds.width:-(UIScreen.main.bounds.width), dy: 0)
        
        transitionContext.containerView.addSubview((toVc?.view)!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
           
             toVc?.view.frame = finalRect
           
        }) { (finished) in
            //报告vc切换成功：
            transitionContext.completeTransition(true)
        }
        
    }
    
}
