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
            if newValue.isFinite && newValue < Double(Int.max) { // isFinete = не NAN
            let cutTheNull = Int(newValue)
            display.text = newValue == Double(cutTheNull) ? String(cutTheNull) : String(newValue)
            } else {
            display.text = "Ошибка"
            }
        }
    }
    
    @IBOutlet private weak var display: UILabel!
    
    @IBOutlet private weak var smallDisplay: UILabel!

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
    
    @IBAction func dot(_ sender: UIButton) {
        if display.text!.range(of: ".") == nil {
            display.text = display.text! + sender.currentTitle!
            inTheMiddleOFTyping = true
        }
    }
    
    @IBAction private func backSpace(_ sender: UIButton) {
        var dellLastNum = ""
        var displayTextInArray = Array(display.text!.characters)
        if displayTextInArray.count == 1 {
            displayValue = 0
        } else {
        for i in 0..<(displayTextInArray.count - 1) {
            dellLastNum = dellLastNum + String((displayTextInArray[i]))
        }
        display.text = dellLastNum
        }
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

