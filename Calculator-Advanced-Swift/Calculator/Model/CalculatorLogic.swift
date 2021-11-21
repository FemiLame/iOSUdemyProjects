//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Alex Osipova on 15.08.2021.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    private var intermediateCalculation: (firstNum: Double, calcMethod: String)?
    
    mutating func setNumber (_ n: Double) {
        number = n
    }
    
    mutating func calculate(calcMethod: String) -> Double? {
        if let n = number {
            switch calcMethod {
            case "+/-":
                return n * -1
            case "%":
                return n / 100
            case "AC":
                return 0
            case "=":
                return perfomTwoNumCalcultion(n2: n)
            default:
                intermediateCalculation = (firstNum: n, calcMethod: calcMethod)
            }
        }
        return nil
    }
    
    private mutating func perfomTwoNumCalcultion(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.firstNum, let operation = intermediateCalculation?.calcMethod  {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "÷":
                return n1 / n2
            case "×":
                return n1 * n2
            default:
                fatalError("Operation is weird sorry")
            }
        }
        return nil
    }
}
