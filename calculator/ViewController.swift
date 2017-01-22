//
//  ViewController.swift
//  calculator
//
//  Created by Oleg&natali on 19.01.17.
//  Copyright © 2017 Oleg.Myatlikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    private var inTheMiddleOFTyping = false
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            let cutTheNull = Int(newValue)
            display.text = newValue == Double(cutTheNull) ? String(cutTheNull) : String(newValue)
            //display.text = String(newValue)
        }
    }
    
    @IBOutlet private weak var display: UILabel!
    
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if inTheMiddleOFTyping {
            let currentlyOnDisplay = display.text!
            display.text = currentlyOnDisplay + digit
        } else {
            display.text = digit
        }
        
        inTheMiddleOFTyping = true
        
    }

    
    
    private var calc = modelCalc()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if inTheMiddleOFTyping {
            calc.setOperand(operand: displayValue)
            inTheMiddleOFTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            calc.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = calc.result
    }
    
}

