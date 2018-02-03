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
    @IBOutlet var textField2: UITextField! //date
    var datePicker = UIDatePicker()
    @IBOutlet var textView: UITextView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var lostButton: UIButton!
    @IBOutlet var decisionButton: UIButton!
    
    var isDoneSave = false
    
    let formatter = DateFormatter()
    
    let realm = try! Realm()
    
    var yasai: Yasai!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = yasai.name
        textView.text = yasai.memo
        textField2.text = yasai.date
        
        self.textView.layer.borderColor = UIColor(hex: "5EC43B").cgColor
        self.textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        
        datePicker.datePickerMode = UIDatePickerMode.date
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: yasai.date)
        datePicker.date = date ?? Date()
        textField2.inputView = datePicker
        
        let toolBar = UIToolbar(frame:  CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        let toolBarButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action:#selector(tappedToolBarButton(sender:)))
        
        datePicker.addTarget(self, action: #selector(changedDateEvent(sender:)), for: .valueChanged)
        toolBarButton.tag = 1
        toolBar.items = [toolBarButton]
        textField2.inputAccessoryView = toolBar
        
        lostButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        decisionButton.layer.cornerRadius = 10
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hex: "5EC43B").cgColor
        textField2.layer.cornerRadius = 10
        textField2.layer.borderWidth = 1
        textField2.layer.borderColor = UIColor(hex: "5EC43B").cgColor
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decision() {
        
        if isDoneSave {
            return
        }
        
        guard let inputText = textField.text else { return }
        guard let memoText = textView.text else { return }
        
        if inputText == ""{
            let alert: UIAlertController = UIAlertController(title: "文字が入力されていません", message: "文字を入力してください",preferredStyle:  UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        
        try! realm.write {
            yasai.name = inputText
            yasai.date = formatter.string(from: datePicker.date)
            yasai.memo = memoText
            
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
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lost(){
        try! realm.write() {
            realm.delete(yasai)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tappedToolBarButton(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
        
    }
    
    func changedDateEvent(sender: UIDatePicker){
        var dateSelecter: UIDatePicker = sender
        self.changeLabelDate(date: datePicker.date as NSDate)
    }
    
    func changeLabelDate(date:NSDate) {
        textField2.text = formatter.string(from: datePicker.date)
    }
}
