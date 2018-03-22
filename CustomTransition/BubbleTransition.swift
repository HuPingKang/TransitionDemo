//
//  BubbleTransition.swift
//  BubbleTransition
//
//  Created by Andrea Mazzini on 04/04/15.
//  Copyright (c) 2015 Fancy Pixel. All rights reserved.
//

import UIKit

open class BubbleTransition: NSObject {
    
    /**
    The point that originates the bubble. The bubble starts from this point
    and shrinks to it on dismiss
    */
    open var startingPoint = CGPoint.zero {
        didSet {
            bubble.center = startingPoint
        }
    }
    
    /**
    The transition duration. The same value is used in both the Present or Dismiss actions
    Defaults to `0.5`
    */
    open var duration = 0.5
    
    /**
    The transition direction. Possible values `.present`, `.dismiss` or `.pop`
     Defaults to `.Present`
    */
    open var transitionMode: BubbleTransitionMode = .present
    
    /**
    The color of the bubble. Make sure that it matches the destination controller's background color.
    */
    open var bubbleColor: UIColor = .white
    
    open fileprivate(set) var bubble = UIView()

    /**
    The possible directions of the transition.
     
     - Present: For presenting a new modal controller
     - Dismiss: For dismissing the current controller
     - Pop: For a pop animation in a navigation controller
    */
    @objc public enum BubbleTransitionMode: Int {
        case present, dismiss, pop
    }
}

extension BubbleTransition: UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    /**
    Required by UIViewControllerAnimatedTransitioning
    */
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    /**
     Required by UIViewControllerAnimatedTransitioning
     */
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)

        if transitionMode == .present {
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size

            bubble = UIView()
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            bubble.backgroundColor = bubbleColor
            containerView.addSubview(bubble)

            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)

            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform.identity
                
                }, completion: { (_) in
                    
                    presentedControllerView.center = originalCenter
                    presentedControllerView.transform = CGAffineTransform.identity
                    UIView.animate(withDuration: 0.1, animations: {
                        
                        presentedControllerView.alpha = 1
                        
                        }, completion: { (_) in
                            transitionContext.completeTransition(true)
                            self.bubble.isHidden = true
                            fromViewController?.endAppearanceTransition()
                            toViewController?.endAppearanceTransition()
                    })
                    
            })
        } else {
            let key = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            let returningControllerView = transitionContext.view(forKey: key)!
            let originalCenter = returningControllerView.center
            let originalSize = returningControllerView.frame.size

            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            bubble.isHidden = false

            UIView.animate(withDuration: 0.1, animations: {
                
                returningControllerView.alpha = 0
                
                }, completion: { (_) in
                    returningControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningControllerView.center = self.startingPoint
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
                        containerView.insertSubview(self.bubble, belowSubview: returningControllerView)
                    }
                    UIView.animate(withDuration: self.duration, animations: {
                        self.bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    }, completion: { (_) in
                        returningControllerView.center = originalCenter
                        returningControllerView.removeFromSuperview()
                        self.bubble.removeFromSuperview()
                        transitionContext.completeTransition(true)
                        
                        fromViewController?.endAppearanceTransition()
                        toViewController?.endAppearanceTransition()
                    })
                   
            })
        }
    }
}

private extension BubbleTransition {
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)

        return CGRect(origin: CGPoint.zero, size: size)
    }
}
