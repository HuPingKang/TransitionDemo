//
//  UINavigationController.swift
//  CustomTransition
//
//  Created by qwer on 2018/3/15.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

let KSW = UIScreen.main.bounds.size.width
let KSH = UIScreen.main.bounds.size.height

extension UINavigationController{
    
    func pushTo(_ viewController:UIViewController , _ fromPoint:CGPoint = CGPoint.zero){
        
        // Get the screen width and height.
        let screenWidth = KSW
        let screenHeight = KSH
        
        // Assign the source and destination views to local variables.
        let firstVCView = self.view as UIView!
        let secondVCView = viewController.view as UIView!
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect.init(x: 0, y: 64, width: screenWidth, height: screenHeight-64)
        
        secondVCView?.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        secondVCView?.alpha = 0
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)

//        // Animate the transition.
        UIView.animate(withDuration: 0.2, animations: { () -> Void in

            secondVCView?.transform = CGAffineTransform.identity
            secondVCView?.alpha = 1

        }) { (Finished) -> Void in

           self.pushViewController(viewController, animated: false)

        }
    }
    
    func popViewController(){
        
        // Get the screen width and height.
        let screenWidth = KSW
        let screenHeight = KSH
        
        //当前页面：
        let firstVCView = self.view as UIView!
        
        let viewController = self.viewControllers[self.viewControllers.count-2]
        //返回的界面：
        let secondVCView = viewController.view as UIView!
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect.init(x: 0, y: 64, width: screenWidth, height: screenHeight-64)
        
        secondVCView?.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        secondVCView?.alpha = 0
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            
            secondVCView?.alpha = 1
            secondVCView?.transform = CGAffineTransform.identity
            
            
//            secondVCView?.frame = CGRect.init(x: 0, y: 64, width: screenWidth, height: screenHeight-64)
            
        }) { (Finished) -> Void in
            
            self.popViewController(animated: false)
            
        }
    }
    
}
