//
//  Tosetting.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/02/05.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet var textField: UITextField! // name
    @IBOutlet var label: UILabel!
    @IBOutlet var textField2: UITextField! // deadline
    @IBOutlet var label2: UILabel!
    
    //    var tag: Int!
    var index = 0
    var dictionaryArray: [String:String]!
    var dicArray:[AnyObject] = []
    var nameArray: [String] = []
    var limitArray: [String] = []
    var stampArray: [Yasai] = []
    
    var isDoneSave = false
    
    let realm = try! Realm()
    
    var objectIndex: Int! // 前のtableviewで選ばれたcellのindexPath.row(realmにある配列の添字)
    var object: Yasai = Yasai()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(realm.objects(Yasai.self))
        stampArray = realm.objects(Yasai.self).map{$0}
        object = stampArray[index]
        textField.text = object.name
        textField2.text = object.date
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decision() {
        
        if isDoneSave {
            return
        }
        
        guard let inputText = textField.text else { return }
        guard let inputText2 = textField2.text else { return }
        if inputText == "" || inputText2 == "" {
            let alert: UIAlertController = UIAlertController(title: "文字が入力されていません", message: "文字を入力してください",preferredStyle:  UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        label.text = inputText
        
        label2.text = inputText2
        
       
        
        try! realm.write {
            object.name = inputText
            object.date = inputText2
        }
        
    
    }
    
    @IBAction func lost(){
        try! realm.write() {
            realm.delete(object)
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
    
}
