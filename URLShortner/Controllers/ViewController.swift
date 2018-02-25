//
//  ViewController.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "URL Shortner"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = nil
        return true
    }

}
