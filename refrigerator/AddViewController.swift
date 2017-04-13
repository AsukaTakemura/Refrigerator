//
//  Tosetting.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/02/05.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var label2: UILabel!
    var dictionaryArray: [String:String]!
    
    var dicArray:[AnyObject] = []
    
    var yasaidetailsArray: [[String: String]] = []
    var nameArray: [String] = []
    var limitArray: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yasaidetailsArray = userDefaults.array(forKey: "yasaidetailsArray") as? [[String : String]] ?? []
        if yasaidetailsArray.count != 0 {
            label.text = yasaidetailsArray[0]["name"]
            label2.text = yasaidetailsArray[0]["limit"]
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        yasaidetailsArray = []
        for label in yasaidetailsArray{
            let name = ["name": label]
            let limit = ["limit": label]
            nameArray.append(String(describing: name))
            limitArray.append(String(describing: limit))
        }
        userDefaults.set(yasaidetailsArray, forKey: "yasaidetailsArray")
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
        
        
        UserDefaults.standard.set(dicArray, forKey: "ARRAY")
        
        //UserDefaults.standard.set(true, forKey: "boolKeyName")
        //UserDefaults.standard.set(1, forKey: "integerKeyName")
        
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
