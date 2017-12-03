//
//  Tosetting.swift
//  refrigerator
//
//  Created by Takemura Asuka on 2017/02/05.
//  Copyright © 2017年 Takemura Asuka. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class AddViewController: UIViewController {
    
    @IBOutlet var textField: UITextField! // name
    @IBOutlet var label: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var TextView: UITextView!
    
    //    var tag: Int!
    var index = 0
    var dictionaryArray: [String:String]!
    var dicArray:[AnyObject] = []
    var nameArray: [String] = []
    var limitArray: [String] = []
    var stampArray: [Yasai] = []
    
    var isDoneSave = false
    
    let formatter = DateFormatter()
    
    let realm = try! Realm()
    
    var objectIndex: Int! // 前のtableviewで選ばれたcellのindexPath.row(realmにある配列の添字)
    var object: Yasai = Yasai()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.objects(Yasai.self))
        stampArray = realm.objects(Yasai.self).map{$0}
        object = stampArray[index]
        textField.text = object.name
        TextView.text = object.memo
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: object.date)
        self.TextView.layer.borderColor = UIColor(red: 152/255, green: 204/255, blue: 154/255, alpha: 1).cgColor
        self.TextView.layer.borderWidth = 3
        // datePicker.date = date!
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
        guard let memoText = TextView.text else { return }
        
        if inputText == ""{
            let alert: UIAlertController = UIAlertController(title: "文字が入力されていません", message: "文字を入力してください",preferredStyle:  UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        label2.text = formatter.string(from: datePicker.date)
        
        try! realm.write {
            object.name = inputText
            object.date = formatter.string(from: datePicker.date)
            object.memo = memoText
            
        }
        
        let content = UNMutableNotificationContent()
        var notificationTime = Calendar.current.dateComponents([.calendar,.year,.month,.day], from: datePicker.date)
        
        notificationTime.hour = 12
        notificationTime.minute = 00
        notificationTime.second = 00
        
        print(notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        content.title = ""
        content.body = "もうすぐ賞味期限です"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
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
