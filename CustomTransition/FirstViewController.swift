//
//  ViewController.swift
//  CustomTransition
//
//  Created by qwer on 2018/3/15.
//  Copyright © 2018年 qwer. All rights reserved.
//
import UIKit

class FirstViewController: UIViewController {
    
    private var isCircle:Bool = false
    
    @IBOutlet weak var circleBtn: UIButton!
    let transition = RotationAnimation()
    let transitionBubble = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.edgesForExtendedLayout = .top
        
    }
    
    @IBAction func push(_ sender: Any) {
        isCircle = false
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func presentMove(_ sender: Any) {
        isCircle = false
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func presentCircle(_ sender: Any) {
        
        isCircle = true
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FirstViewController : UIViewControllerTransitioningDelegate{
     public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        if isCircle {
            transitionBubble.transitionMode = .present
            transitionBubble.startingPoint = circleBtn.center
            transitionBubble.bubbleColor = UIColor.init(red: 202/255.0, green: 203/255.0, blue: 206/255.0, alpha: 1)
            return self.transitionBubble
        }else{
            self.transition.isPresenting = true
            return self.transition
        }
        
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if isCircle {
            transitionBubble.transitionMode = .dismiss
            transitionBubble.startingPoint = circleBtn.center
            transitionBubble.bubbleColor = UIColor.init(red: 1.0, green: 196/255.0, blue: 76/255.0, alpha: 1)
            return transitionBubble
        }else{
            self.transition.isPresenting = false
            return self.transition
        }
    }
    
}

//push or pop curstom transation:
extension FirstViewController:UINavigationControllerDelegate{
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        self.transition.isPresenting = (operation == UINavigationControllerOperation.push)
        return self.transition
    }
}

