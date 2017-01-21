//
//  ViewController.swift
//  calculator
//
//  Created by Oleg&natali on 19.01.17.
//  Copyright © 2017 Oleg.Myatlikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    var inTheMiddleOFTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBOutlet weak var display: UILabel!
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if inTheMiddleOFTyping {
            let currentlyOnDisplay = display.text!
            display.text = currentlyOnDisplay + digit
        } else {
            display.text = digit
        }
        
        inTheMiddleOFTyping = true
        
    }

    
    @IBAction func aClear(_ sender: UIButton) {
        display.text = "0"
        inTheMiddleOFTyping = false
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        inTheMiddleOFTyping = false
        let mathOperation = sender.currentTitle!
        if mathOperation == "√" {
            displayValue = sqrt(displayValue)
        }
    }
    
}

