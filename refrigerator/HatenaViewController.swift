//
//  hatenaViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2018/02/03.
//  Copyright © 2018年 Takemura Asuka. All rights reserved.
//

import UIKit

class HatenaViewController: UIViewController {
    
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapPageControl(sender: UIPageControl) {
        ScrollView.contentOffset.x = ScrollView.frame.maxX * CGFloat(sender.currentPage)
        PageControl.currentPage = Int(ScrollView.contentOffset.x / ScrollView.frame.maxX)
    }
    
    @IBAction func modoru(){
        self.dismiss(animated: true, completion: nil)
    }

   

}
