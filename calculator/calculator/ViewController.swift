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
    var isTyping: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(isTyping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }

    }
}

