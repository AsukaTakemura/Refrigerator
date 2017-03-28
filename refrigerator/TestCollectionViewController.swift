//
//  TestCollectionViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/03/27.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit

class TestCollectionViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var stampView: UIView!
    
    @IBOutlet var image:UIImageView!
    
    
    var imageIndex: Int = 0
    var yasaiArray: [UIImageView] = []
    
    var reizoukoArray: [UIImage] = [UIImage(named: "ninjin2.png")!,UIImage(named: "tomato.png")!,UIImage(named: "corn.png")!,UIImage(named: "onion.png")!,UIImage(named: "daion.png")!,UIImage(named: "kyuuri.png")!,UIImage(named: "kyabetsu.png")!,UIImage(named: "nasu.png")!,UIImage(named: "piman.png")!,UIImage(named: "hourensou.png")!,UIImage(named: "kabotya.png")!]
    
    var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addImageView(gesture:)))
        self.stampView.addGestureRecognizer(singleTap)
    
        
        self.view.bringSubview(toFront: collectionView)
        
        
        /*let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.addImageView(gesture:)))
        self.view.addGestureRecognizer(singleTap)*/
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        
        var imageview = UIImageView()
        
        imageview.image = reizoukoArray[indexPath.row]
        
        cell.backgroundView = imageview
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print(indexPath.row)
        
        
        imageIndex = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapSingle(gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "tosetting", sender: nil)
    }
    
    func addImageView(gesture: UIGestureRecognizer) {
        //画像作成
        let image = reizoukoArray[imageIndex]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = image
        imageView.center = gesture.location(in: self.view)
        
        //ジェスチャーを加える
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(gesture:)))
        imageView.addGestureRecognizer(singleTap)
        
        /* パンジェスチャーをimageViewに追加 (2行) ドラッグした時のメソッドは下にあるよ */
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
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
    

    /* ドラッグした時のメソッド */
    /* 内容はgesuture.viewの中心座標をgesture.locationの位置にする */
    func dragImage(gesture: UIGestureRecognizer) {
        gesture.view?.center = gesture.location(in: self.view)
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


