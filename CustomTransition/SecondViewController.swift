//
//  SecondViewController.swift
//  CustomTransition
//
//  Created by qwer on 2018/3/15.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var titelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .bottom
        // Do any additional setup after loading the view.
//        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(showFirstViewController))
//        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
//        self.view.addGestureRecognizer(swipeGestureRecognizer)
//
    }
//
//    @objc private func showFirstViewController() {
//        self.performSegue(withIdentifier: "idFirstSegueUnwind", sender: self)
//    }
    
    
    @IBAction func tapMe(_ sender: Any) {
        self.navigationController?.popViewController()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
