//
//  ProfileInputViewController.swift
//  Give
//
//  Created by shiga yuichi on 2015/07/17.
//  Copyright (c) 2015年 Jonathan Grant. All rights reserved.
//

import Foundation
import Parse
import ParseUI

class ProfileInputViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var birthPlaceField: UITextField!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var profileImage: PFImageView!
    @IBOutlet weak var birthField: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    func format(date : NSDate, style : String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
    }
    
    @IBAction func didDateChange(sender: AnyObject) {
        self.birthField.text = format(datePicker.date, style:"MM/dd/yyyy")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.backgroundColor = ColorList.getPossitiveBtnBack()
        datePicker.datePickerMode = UIDatePickerMode.Date

        self.birthPlaceField?.delegate = self
        
        var user :PFUser  = PFUser.currentUser()!

        self.nameField.text = user["username"] as! String
        
        profileImage.file = user["photo"] as! PFFile
        profileImage.loadInBackground()
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }

    
    @IBAction func didCreateTap(sender: AnyObject) {
        create()
    }
    func create() {
        var user :PFUser  = PFUser.currentUser()!
        user["birthdate"] = datePicker.date
        user["birthplace"] = birthPlaceField.text
        user.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}