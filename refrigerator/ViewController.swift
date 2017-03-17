//
//  ViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/01/08.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageIndex: Int = 0
    var yasaiArray: [UIImageView] = []
    var reizoukoArray: [UIImage] = [#imageLiteral(resourceName: "ninjin2.png"),#imageLiteral(resourceName: "tomato.png")]
    var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.addImageView(gesture:)))
        self.view.addGestureRecognizer(singleTap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addImageView(gesture: UIGestureRecognizer) {
        //画像作成
        let image = reizoukoArray[imageIndex]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = image
        imageView.center = gesture.location(in: self.view)
        
        //ジェスチャーを加える
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapSingle(gesture:)))
        imageView.addGestureRecognizer(singleTap)
        
        /* パンジェスチャーをimageViewに追加 (2行) ドラッグした時のメソッドは下にあるよ */
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.dragImage(gesture:)))
        imageView.addGestureRecognizer(panGesture)
        
        
        imageView.isUserInteractionEnabled = true
        
        self.view.addSubview(imageView)
        
        //配列に加える
        yasaiArray.append(imageView)
    }
    
    @IBAction func push(){
        //画面にある画像全削除
        for imageView in yasaiArray{
            imageView.removeFromSuperview()
        }
        yasaiArray.removeAll()
    }
    
    @IBAction func back(){
        if yasaiArray.count != 0 {
            yasaiArray.last?.removeFromSuperview()
            yasaiArray.removeLast()
        }
    }
    
    @IBAction func ninjin(){
        imageIndex = 0
    }
    
    @IBAction func tomato(){
        imageIndex = 1
    }
    
    func tapSingle(gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "tosetting", sender: nil)
    }
    
    /* ドラッグした時のメソッド */
    /* 内容はgesuture.viewの中心座標をgesture.locationの位置にする */
    func dragImage(gesture: UIGestureRecognizer) {
        gesture.view?.center = gesture.location(in: self.view)
    }
    
}



