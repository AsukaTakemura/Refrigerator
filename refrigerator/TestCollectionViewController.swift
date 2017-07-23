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
    var judgeIndex: Int = 0
    
    var userDefaults = UserDefaults.standard
    let saveData: UserDefaults = UserDefaults.standard
    
    var stampArray: [[String: String]] = []
    
    var yasaiArray: [UIImageView] = []
    var namamonoArray: [UIImageView] = []
    var drinkArray: [UIImageView] = []
    
    var imageArray: [UIImage] = []
    var imageViewArray: [UIImageView] = []
    
    
    var yasai2Array: [UIImage] = [UIImage(named: "ninjin2.png")!,UIImage(named: "tomato.png")!,UIImage(named: "corn.png")!,UIImage(named: "onion.png")!,UIImage(named: "daion.png")!,UIImage(named: "kyuuri.png")!,UIImage(named: "kyabetsu.png")!,UIImage(named: "nasu.png")!,UIImage(named: "piman.png")!,UIImage(named: "hourensou.png")!,UIImage(named: "kabotya.png")!]
    
    var namamono2Array: [UIImage] = [UIImage(named: "tori.png")!,UIImage(named: "usi.png")!,UIImage(named: "buta.png")!,UIImage(named: "sake.png")!,UIImage(named: "kai.png")!,UIImage(named: "hituji.png")!]
    
    var drink2Array: [UIImage] = [UIImage(named: "tea.png")!,UIImage(named: "milk.png")!,UIImage(named: "juice.png")!,UIImage(named: "drink.png")!]
    
    
    
    var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addImageView(gesture:)))
        self.stampView.addGestureRecognizer(singleTap)
        
        
        self.view.bringSubview(toFront: collectionView)
        
        imageArray = yasai2Array
        
        // saveData.set(stampArray, forKey: "stampArray")
        if (userDefaults.object(forKey: "stampArray") != nil) {
            print("データ有り")
        }
        stampArray = userDefaults.array(forKey: "stampArray") as? [[String : String]] ?? []
        
        for stamp in stampArray{
            //画像作成
            let image = imageArray[Int(stamp["index"]!)!]
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.image = image
            imageView.frame.origin.x = CGFloat(Double(stamp["locationx"]!)!)
            imageView.frame.origin.y = CGFloat(Double(stamp["locationy"]!)!)
            
            //ジェスチャーを加える
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(gesture:)))
            imageView.addGestureRecognizer(singleTap)
            
            /* パンジェスチャーをimageViewに追加 */
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
            imageView.addGestureRecognizer(panGesture)
            
            imageView.tag = imageViewArray.count + 1
            
            imageView.isUserInteractionEnabled = true
            
            self.view.addSubview(imageView)
            
            //配列に加える
            imageViewArray.append(imageView)
        }
        
        
        
        /*let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.addImageView(gesture:)))
         self.view.addGestureRecognizer(singleTap)*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        stampArray = []
        for imageView in imageViewArray{
            let index: Int = imageArray.index(of: imageView.image!)!
            let stamp = ["locationx": String(describing: imageView.frame.origin.x),"locationy": String(describing: imageView.frame.origin.y),"index": String(describing: index)]
            stampArray.append(stamp)
        }
       saveData.set(stampArray, forKey: "stampArray")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        
        let imageview = UIImageView()
        
        
        
        imageview.image = imageArray[indexPath.row]
        
        cell.backgroundView = imageview
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        imageIndex = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapSingle(gesture: UITapGestureRecognizer) {
        //var hoge = dragImage(gesture: <#T##UIGestureRecognizer#>)
        
        performSegue(withIdentifier: "tosetting", sender: nil)
    }
    
    
    func addImageView(gesture: UIGestureRecognizer) {
        //画像作成
        let image = imageArray[imageIndex]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = image
        imageView.center = gesture.location(in: self.view)
        
        //ジェスチャーを加える
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(gesture:)))
        imageView.addGestureRecognizer(singleTap)
        
        /* パンジェスチャーをimageViewに追加 (2行) ドラッグした時のメソッドは下にあるよ */
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
        imageView.addGestureRecognizer(panGesture)
        
        imageView.tag = imageViewArray.count + 1
        
        imageView.isUserInteractionEnabled = true
        
        self.view.addSubview(imageView)
        
        //配列に加える
        imageViewArray.append(imageView)
    }
    
    @IBAction func push(){
        //画面にある画像全削除
        for imageView in imageViewArray{
            imageView.removeFromSuperview()
        }
        imageViewArray.removeAll()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("野菜")
            
            imageArray = yasai2Array
        case 1:
            print("飲み物")
            
            imageArray = drink2Array
        case 2:
            print("生もの")
            
            imageArray = namamono2Array
        default:
            break
        }
        
        collectionView.reloadData()
    }
    
    @IBAction func back(){
        if imageViewArray.count != 0 {
            imageViewArray.last?.removeFromSuperview()
            imageViewArray.removeLast()
        }
        
    }
    
    /* ドラッグした時のメソッド */
    /* 内容はgesuture.viewの中心座標をgesture.locationの位置にする */
    func dragImage(gesture: UIGestureRecognizer) {
        gesture.view?.center = gesture.location(in: self.view)
    }
    
    @IBAction func modoru() {
        self.dismiss(animated: true, completion: nil)
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


