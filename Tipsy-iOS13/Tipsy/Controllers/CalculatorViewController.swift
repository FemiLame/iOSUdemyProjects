//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var lastSelectedButton: UIButton?
    var splitNumber: Int = 2
    var tipAmount: Float = 0
    var result: String = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        if lastSelectedButton != nil {
            lastSelectedButton?.isSelected = false
        } else {
            tenPctButton.isSelected = false
//            for case let button as UIButton in self.view.subviews {
//                button.isSelected = false
//            }
            
//            let buttons = self.view.subviews
//                .map { subview in subview.subviews } // second level subviews
//                .joined() // join the second level subviews into one flat array
//                .map { subview in subview.subviews } // third level subviews
//                .joined()
//                .map { subview in subview.subviews } // forth level subviews
//                .joined()
//                .compactMap { $0 as? UIButton }
//                .map { button in
//                    button.isSelected = false
//                    print(button.titleLabel)
//                }
        }
        
        sender.isSelected = true
        lastSelectedButton = sender
        
        tipAmount = (Float(sender.titleLabel!.text!.dropLast()) ?? 0) / 100
        
        if billTextField.text != nil {
            billTextField.endEditing(true)
        }
        
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(describing: splitNumber)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billAmount: Float = Float(billTextField!.text!)!
        result = String(format: "%.2f", billAmount * (1 + tipAmount) / Float(splitNumber))
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToResult" {
                let destinationVC = segue.destination as! ResultsViewController
                destinationVC.payPerPerson = result
                destinationVC.splitAmount = splitNumber
                destinationVC.tipAmount = tipAmount
            }
        }
}

