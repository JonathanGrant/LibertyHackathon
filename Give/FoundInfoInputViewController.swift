//
//  FoundInfoInputViewController.swift
//  Give
//
//  Created by shiga yuichi on 2015/07/18.
//  Copyright (c) 2015年 Jonathan Grant. All rights reserved.
//

import Foundation

import Foundation
import Parse
import ParseUI

class FoundInfoInputViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var purposeField: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBtn.backgroundColor = ColorList.getPossitiveBtnBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCreateTap(sender: AnyObject) {
        
        var user :PFUser  = PFUser.currentUser()!
        user["money"] = moneyField.text
        user["purpose"] = purposeField.text
        user.saveInBackground()
    }
}