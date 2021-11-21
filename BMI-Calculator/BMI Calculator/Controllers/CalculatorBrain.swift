//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Alex Osipova on 20.07.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    private var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue =  weight / pow(height, 2)
        switch bmiValue {
        case 0..<18.5:
            bmi = BMI(value: bmiValue, advice: "eat more pies please", colour: #colorLiteral(red: 0.9652952552, green: 0.8814823031, blue: 0.8795922399, alpha: 1))
        case 18.5...24.9:
            bmi = BMI(value: bmiValue, advice: "OK", colour: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
//        case 24....24.9:
//            bmi = BMI(value: bmiValue, advice: "F", colour: .red)
        default:
            bmi = BMI(value: bmiValue, advice: "F", colour: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
        }
        // bmi = BMI(value: weight / pow(height, 2), advice: "", colour: .red)
    }
    
    func getBMIValue() -> String {
        return "\(String(format: "%.1f", bmi?.value ?? 0.0))"
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "Do whatever you want, it's your life"
    }
    
    func getColour() -> UIColor {
        return bmi?.colour ?? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }

}

