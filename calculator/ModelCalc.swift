//
//  File.swift
//  calculator
//
//  Created by Oleg&natali on 19.01.17.
//  Copyright © 2017 Oleg.Myatlikov. All rights reserved.
//

import Foundation

class modelCalc {
    
    private var accumulator = 0.0
    
    func setOperand (operand: Double) {
        accumulator = operand
    }
    
    private var operations : [String: Operations] = [
        "AC" : Operations.Constants(0),
        "π" : Operations.Constants(M_PI),
        "ｅ" : Operations.Constants(M_E),
        "√" : Operations.UnaryOperations(sqrt),
        "sin" : Operations.UnaryOperations(sin),
        "cos" : Operations.UnaryOperations(cos),
        "tg" : Operations.UnaryOperations(tan),
        "＋" : Operations.BinaryOperations({$0 + $1}),
        "−" : Operations.BinaryOperations({$0 - $1}),
        "×" : Operations.BinaryOperations({$0 * $1}),
        "÷" : Operations.BinaryOperations({$0 / $1}),
        "=": Operations.Equals
    ]
    
    enum Operations {
        case Constants(Double)
        case UnaryOperations((Double) -> Double)
        case BinaryOperations((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation (symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constants(let value):
                accumulator = value
            case .UnaryOperations(let function):
                accumulator = function(accumulator)
            case .BinaryOperations(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
        
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperation?
    
    struct PendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}

