//
//  ViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/01/08.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate();
        
        let statusBar = UIView(frame:CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        statusBar.backgroundColor = UIColor(red: 0.286, green: 0.208, blue: 0.208, alpha: 1.0)
        
        view.addSubview(statusBar)
    }
    
   /* override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;

    } */
    
    /*   @IBOutlet var Label: UILabel!
    
    override func viewDidLoad() {
    Label.font = UIFont(name: )
    } */
}

