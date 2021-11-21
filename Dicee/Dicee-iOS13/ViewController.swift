//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    @IBAction func rollButtomPressed(_ sender: UIButton) {
        let arrayOfDiceImages = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
        
        func getDiceRandomNumber() -> Int {
            return Int.random(in: 0...5)
        }
        
        diceImageView1.image = arrayOfDiceImages[getDiceRandomNumber()]
        diceImageView2.image = arrayOfDiceImages.randomElement()
    }

    
}
 
