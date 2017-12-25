//
//  TestCollectionViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/03/27.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit
import RealmSwift

class TestCollectionViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var stampView: UIView!
    
    @IBOutlet var image:UIImageView!
    
    @IBOutlet var backButton:UIButton!
    
    @IBOutlet var deletionButton:UIButton!
    
    
    
    var imageIndex: Int = 0
    var judgeIndex: Int = 0
    
    var object: Yasai = Yasai()
    
    var tag: Int = 0
    var selectedIndex : Int = 0
    var stampArray: [Yasai] = []
    
    var imageArray: [String] = []
    var imageViewArray: [UIImageView] = []
    
    
    var yasai2Array: [String] = ["ninjin2.png","tomato.png","corn.png","onion.png","daion.png","kyuuri.png","kyabetsu.png","nasu.png","piman.png","hourensou.png","kabotya.png"]
    
    var namamono2Array: [String] = ["tori.png","usi.png","buta.png","sake.png","kai.png","hituji.png"]
    
    
    var drink2Array: [String] = ["tea.png","milk.png","juice.png","drink.png"]
    
    let realm = try! Realm()
    
    let dateFormatter = DateFormatter()
//    dateFormatter.dateFomatter = "yyyy/MM/dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        backButton.layer.cornerRadius = 10
        deletionButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStamps()
    }
    func setStamps() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addImageView(gesture:)))
        self.stampView.addGestureRecognizer(singleTap)
        
        self.view.bringSubview(toFront: collectionView)
        
        imageArray = yasai2Array
        
        //保存したスタンプの取り出し
        stampArray = realm.objects(Yasai.self).map{$0}
        print(stampArray)
        
        //表示
        for imageView in imageViewArray{
            imageView.removeFromSuperview()
            imageViewArray = []
        }
        
        for i in 0 ..< stampArray.count {
            //画像作成
            let stamp = stampArray[i]
            let image = UIImage(named: stamp.imagename)!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.image = image
            imageView.frame.origin.x = CGFloat(stamp.coordinatex)
            imageView.frame.origin.y = CGFloat(stamp.coordinatey)
            
            //ジェスチャーを加える
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(gesture:)))
            imageView.addGestureRecognizer(singleTap)
            
            /* パンジェスチャーをimageViewに追加 */
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
            imageView.addGestureRecognizer(panGesture)
            
            imageView.tag = i + 1
            
            imageView.isUserInteractionEnabled = true
            
            //差を取る
            
            // self.imageViewArray[selectedIndex].layer.borderColor = UIColor.red.cgColor
            // self.imageViewArray[selectedIndex].layer.borderWidth = 5
            
            let now = Date()
            let calendar = Calendar(identifier: .gregorian)
            
            let dateString: String = stampArray[i].date
            if dateString != "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd"
                let date: Date = dateFormatter.date(from: dateString)!
                if calendar.dateComponents([.day], from: now, to: date).day! <= 3{
                    imageView.layer.borderColor = UIColor.red.cgColor
                    imageView.layer.borderWidth = 3
                }
            }
            
            
            
            self.view.addSubview(imageView)
            
            //配列に加える
            imageViewArray.append(imageView)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        
        let imageview = UIImageView()
        
        imageview.image = UIImage(named: imageArray[indexPath.row])
        
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
    
    func tapSingle(gesture: UITapGestureRecognizer) {
        //tagの受け渡し
        // tag = gesture.view!.tag
        if let tag = gesture.view?.tag {
            selectedIndex = tag - 1
            print(selectedIndex)
        } else {
            print("no tag")
            return
        }
        print(selectedIndex)
        performSegue(withIdentifier: "tosetting", sender: nil)
    }
    
    
    func addImageView(gesture: UIGestureRecognizer) {
        //画像作成
        let imageName = imageArray[imageIndex]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: imageName)
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
        
        //保存
        let yasai = Yasai()
        yasai.imagename =  imageName
        yasai.coordinatex = Float(imageView.frame.origin.x)
        yasai.coordinatey = Float(imageView.frame.origin.y)
        yasai.date = String()
        yasai.name = "名前"
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(yasai)
        }
        
    }
    
    func push(){
        //画面にある画像全削除
        for imageView in imageViewArray{
            imageView.removeFromSuperview()
        }
        imageViewArray.removeAll()
        
        let yasaiList = realm.objects(Yasai.self)
        try! realm.write {
            realm.delete(yasaiList)
        }
        setStamps()
    }
    
    func segmentedControlChanged(_ sender: UISegmentedControl) {
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
    
    
    func back(){
        if imageViewArray.count != 0 {
            imageViewArray.last?.removeFromSuperview()
            imageViewArray.removeLast()
        }
        stampArray = realm.objects(Yasai.self).map{$0}
        
        guard let object = stampArray.last else {
            return
        }
        
        try! realm.write {
            realm.delete(object)
        }
        
    }
    
    /* ドラッグした時のメソッド */
    /* 内容はgesuture.viewの中心座標をgesture.locationの位置にする */
    func dragImage(gesture: UIGestureRecognizer) {
        gesture.view?.center = gesture.location(in: self.view)
        let yasai: Yasai = stampArray[gesture.view!.tag-1]
        
        try! realm.write {
            yasai.coordinatex = Float(gesture.view!.frame.origin.x)
            yasai.coordinatey = Float(gesture.view!.frame.origin.y)
        }
    }
    
    func modoru() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController: AddViewController = segue.destination as! AddViewController
        //        addViewController.tag = self.tag
        addViewController.index = self.selectedIndex
        
    }
    
}


