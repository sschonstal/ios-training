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
    var brain = CalculatorBrain()
    
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

        if (isTyping) {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        

    }
    
    @IBAction func clear() {
        initialize()
    }
    
    @IBAction func enter() {
        isTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
        
    }
}

