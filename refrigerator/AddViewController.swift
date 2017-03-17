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
    var dictionaryArray: [[String: String]] = [["name": "", "limit_date": ""], ["name": "", "limit_date": ""]]
    let userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        dictionaryArray[0]["name"] = inputText
        dictionaryArray[1]["name"] = inputText
        
        textField.text = nil
        
        let inputText2 = textField2.text
        label2.text = inputText2
        
        dictionaryArray[0]["limit_date"] = inputText2
        dictionaryArray[1]["limit_date"] = inputText2
        
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
