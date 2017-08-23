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
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var label2: UILabel!
    
    var tag: Int!
    var dictionaryArray: [String:String]!
    var dicArray:[AnyObject] = []
    var nameArray: [String] = []
    var limitArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tag)
        
        let realm = try! Realm()
        print(realm.objects(Yasai.self))
        
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
        let inputText = textField.text
        label.text = inputText
        
        nameArray.append(inputText!)
        textField.text = nil
        
        let inputText2 = textField2.text
        label2.text = inputText2
        
        dictionaryArray = [inputText!:inputText2!]
        
        dicArray.append(dictionaryArray as AnyObject)
        
        //dictionaryArray[1]["limit_date"] = inputText2
        
        textField2.text = nil
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
