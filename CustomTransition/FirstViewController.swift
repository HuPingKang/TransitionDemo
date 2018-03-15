//
//  ViewController.swift
//  CustomTransition
//
//  Created by qwer on 2018/3/15.
//  Copyright © 2018年 qwer. All rights reserved.
//
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var titelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .bottom
        
    }

    
    @IBAction func tapMe(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        self.navigationController?.pushTo(vc, sender.center)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

