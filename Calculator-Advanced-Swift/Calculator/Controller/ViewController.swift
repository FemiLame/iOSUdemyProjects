//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    private var displayValue: Double {
        get {
            guard let currentNum = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to Double")
            }
            return currentNum
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
//        displayLabel.text = "0"
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            calculator.setNumber(displayValue)
            if let result = calculator.calculate(calcMethod: calcMethod)  {
                displayValue = result
            }
            
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
//        if (displayLabel.text == "0") {
//            displayLabel.text = sender.currentTitle!
//        } else {
//            if let numVal = sender.currentTitle, let prevText = displayLabel.text {
//                displayLabel.text = prevText + numVal
//            }
//        }
        if let numVal = sender.currentTitle {
            if isFinishedTypingNumber {
                isFinishedTypingNumber = false
                displayLabel.text = numVal
            } else {
                if numVal == "." {
                    
                    
                    let isInt = floor(displayValue) == displayValue
                    if !isInt {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numVal
            }
        }
    }
}

