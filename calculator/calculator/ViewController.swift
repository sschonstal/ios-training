//
//  ViewController.swift
//  calculator
//
//  Created by Schonstal, Sam (DS) on 2/14/15.
//  Copyright (c) 2015 Schonstal, Sam (DS). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!

    
    var isTyping = false
    var operandStack = Array<Double>()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set {
            display.text = "\(newValue)"
            isTyping = false
        }
    }
    
    func initialize () {
        displayValue = 0
        isTyping = false
        operandStack.removeAll(keepCapacity: false)
        historyDisplay.text = ""
    }
    

   
    
    @IBAction func appendDigit(sender: UIButton) {
        var digit = ""
        if ("π" == sender.currentTitle!) {
            digit = "\(M_PI)"
        } else {
            digit = sender.currentTitle!
        }
        if(isTyping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }

    }
    
    @IBAction func enterDecimal() {
        if(display.text?.rangeOfString(".") == nil){
            display.text = display.text! + "."
            isTyping = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operationKey = sender.currentTitle!
        if (operandStack.count < 2) {
            return
        }
        if (isTyping) {
            enter()
        }
        
        switch operationKey {
            case "×": performOperation(operationKey, {$0 * $1})
            case "÷": performOperation(operationKey, {$1 / $0})
            case "+": performOperation(operationKey, {$0 + $1})
            case "-": performOperation(operationKey, {$0 - $1})
            case "√": performOperation(operationKey, {sqrt($0)})
            case "sin": performOperation(operationKey, {sin($0)})
            case "cos": performOperation(operationKey, {cos($0)})
            default: break
        }
    }
    
    func performOperation(operationKey: String, operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            var firstOperand = operandStack.removeLast()
            var secondOperand = operandStack.removeLast()
            historyDisplay.text = "\(firstOperand) \(operationKey) \(secondOperand)"
            displayValue = operation(firstOperand, secondOperand)
            enter()
        }
    }
    
    func performOperation(operationKey: String, operation: Double -> Double) {
        if (operandStack.count >= 1) {
            var theOperand = operandStack.removeLast()
            historyDisplay.text = "\(operationKey) (\(theOperand))"
            displayValue = operation(theOperand)
            enter()
        }
    }
    
    @IBAction func clear() {
        initialize()
    }
    
    @IBAction func enter() {
        isTyping = false
        operandStack.append(displayValue)
        println("stack - \(operandStack)")
    }
}

