//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    var calculatorBrain = CalculatorBrain()
    @IBOutlet weak var hightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var hightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hightSlider.value = (hightSlider.maximumValue + hightSlider.minimumValue) / 2
        weightSlider.value = (weightSlider.maximumValue + weightSlider.minimumValue) / 2
        // Do any additional setup after loading the view.
    }

    @IBAction func hightSliderValueChanged(_ sender: UISlider) {
        hightLabel.text = "\(String(format: "%.02f", sender.value))m"
    }
    
    @IBAction func weightSliderValueChanged(_ sender: UISlider) {
        weightLabel.text = "\(Int(sender.value))Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {

        calculatorBrain.calculateBMI(height: hightSlider.value, weight: weightSlider.value)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
           
            destinationVC.bmiValue =  calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.colour = calculatorBrain.getColour()
        }
    }
}

