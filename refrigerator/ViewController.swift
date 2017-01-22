//
//  ViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/01/08.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageIndex: Int = 0;
    
    var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch:UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        let image = UIImage(named: "ninjin.png")
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = image
        
        imageView.center = CGPoint(x: location.x ,y: location.y)
        
        self.view.addSubview(imageView)
        
        
    }
    
    
}
