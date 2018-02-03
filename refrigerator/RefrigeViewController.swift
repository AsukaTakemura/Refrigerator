//
//  TestCollectionViewController.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/03/27.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit
import RealmSwift

class RefrigeViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var refrigeView: UIView!
    @IBOutlet var undoButton:UIButton!
    @IBOutlet var addDeleteButton:UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    var tag: Int = 0
    var selectedStamp : Yasai?
    var selectedStampIndex: Int = 0
    var selectedStampImageIndex: Int = 0
    var stampArray:[Yasai] = []
    var imageViewArray: [UIImageView] = []
    
    var imageNameArray: [String] = []
    var stampNameArray: [String] = []
    
    var yasai2Array: [String] = ["ninjin2.png","tomato.png","corn.png","onion.png","daion.png","kyuuri.png","kyabetsu.png","nasu.png","piman.png","hourensou.png","kabotya.png"]
    var yasainameArray: [String] = ["にんじん","トマト","とうもろこし","たまねぎ","大根","きゅうり","キャベツ","なす","ピーマン","ほうれん草","かぼちゃ"]
    
    var namamono2Array: [String] = ["tori.png","usi.png","buta.png","sake.png","kai.png","hituji.png"]
    var namamononameArray: [String] = ["鶏肉","牛肉","豚肉","魚","貝","羊肉"]
    
    var drink2Array: [String] = ["tea.png","milk.png","juice.png","drink.png"]
    var drinknameArray: [String] = ["お茶","牛乳","ジュース","パックジュース"]
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        undoButton.layer.cornerRadius = 10
        addDeleteButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(addImageView(gesture:)))
        self.refrigeView.addGestureRecognizer(singleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStamps()
        
        segmentedControl.selectedSegmentIndex = 0
        imageNameArray = yasai2Array
        stampNameArray = yasainameArray
        
        collectionView.reloadData()
    }
    
    
    func setStamps() {
        
        self.view.bringSubview(toFront: collectionView)
        
        //保存したスタンプの取り出し
        stampArray = realm.objects(Yasai.self).map{$0}
        
        //表示(消去)
        for imageView in imageViewArray{
            imageView.removeFromSuperview()
            imageViewArray = []
        }
        print("stamp array in set stamps")
        print(stampArray)
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
            
            /* パンジェスチャー(ドラック)をimageViewに追加 */
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
            imageView.addGestureRecognizer(panGesture)
            
            //長押し
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longtapdelete(gesture:)))
            imageView.addGestureRecognizer(longPressGesture)
            
            imageView.tag = i + 1
            
            imageView.isUserInteractionEnabled = true
            
            //差を取る
            
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
        
        imageview.image = UIImage(named: imageNameArray[indexPath.row])
        
        cell.backgroundView = imageview
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        selectedStampImageIndex = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func tapSingle(gesture: UITapGestureRecognizer) {
        //tagの受け渡し
        // tag = gesture.view!.tag
        if let tag = gesture.view?.tag {
            selectedStampIndex = tag - 1
        } else {
            print("no tag")
            return
        }
        selectedStamp = stampArray[selectedStampIndex]
        
        performSegue(withIdentifier: "tosetting", sender: nil)
        
    }
    
    
    func addImageView(gesture: UIGestureRecognizer) {
        
        print("add image ----------")
        //画像作成
        let imageName = imageNameArray[selectedStampImageIndex]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: imageName)
        imageView.center = gesture.location(in: gesture.view)
        
        //ジェスチャーを加える
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(gesture:)))
        imageView.addGestureRecognizer(singleTap)
        
        /* パンジェスチャーをimageViewに追加 (2行) ドラッグした時のメソッドは下にあるよ */
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImage(gesture:)))
        imageView.addGestureRecognizer(panGesture)
        
        imageView.tag = imageViewArray.count + 1
        
        imageView.isUserInteractionEnabled = true
        
        self.refrigeView.addSubview(imageView)
        
        //配列に加える
        imageViewArray.append(imageView)
        
        //保存
        let yasai = Yasai()
        yasai.imagename =  imageName
        yasai.coordinatex = Float(imageView.frame.origin.x)
        yasai.coordinatey = Float(imageView.frame.origin.y)
        yasai.date = String()
        yasai.name = stampNameArray[selectedStampImageIndex]
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(yasai)
        }
        stampArray.append(yasai)
    }
    
    @IBAction func deleteAll(){
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
            
            imageNameArray = yasai2Array
            stampNameArray = yasainameArray
        case 1:
            print("飲み物")
            
            imageNameArray = drink2Array
            stampNameArray = drinknameArray
        case 2:
            print("生もの")
            
            imageNameArray = namamono2Array
            stampNameArray = namamononameArray
            
        default:
            break
        }
        
        collectionView.reloadData()
    }
    
    
    @IBAction func undo(){
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
        if let tag = gesture.view?.tag {
            selectedStampIndex = tag - 1
        } else {
            print("no tag")
            return
        }
        
        selectedStamp = stampArray[selectedStampIndex]
        
        gesture.view?.center = gesture.location(in: self.view)
        
        try! realm.write {
            selectedStamp!.coordinatex = Float(gesture.view!.frame.origin.x)
            selectedStamp!.coordinatey = Float(gesture.view!.frame.origin.y)
        }
        
    }
    
    func longtapdelete(gesture: UILongPressGestureRecognizer){
        gesture.view?.tag
        
        let actionSheet = UIAlertController(title: "消去しますか？", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let yes = UIAlertAction(title: "はい", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            try! self.realm.write() {
                self.realm.delete(self.selectedStamp!)
            }
            gesture.view?.removeFromSuperview()
        })
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.default, handler: nil)
        
        actionSheet.addAction(yes)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
   @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController: AddViewController = segue.destination as! AddViewController
        addViewController.yasai = selectedStamp!
    }
    
}


