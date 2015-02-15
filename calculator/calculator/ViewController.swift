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

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(isTyping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }

    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if (operandStack.count < 2) {
            return
        }
        if (isTyping) {
            enter()
        }
        
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "-": performOperation {$0 - $1}
            case "√": performOperation {sqrt($0)}
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() {
        isTyping = false
        operandStack.append(displayValue)
        println("stack - \(operandStack)")
    }
}

