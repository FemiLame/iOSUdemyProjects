//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    @IBOutlet weak var MainText: UILabel!
    @IBOutlet weak var ProgressBar1: UIProgressView!
    
    let eggsTimes = ["Soft" : 30, "Medium" : 4800, "Hard" : 7200]
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        self.ProgressBar1.progress = 0
        var secondsPassed = 0
        
        let hardness = sender.currentTitle!
        
        MainText.text = hardness

        let totalTime: Int = eggsTimes[hardness]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percentagePrograss = Float(secondsPassed) / Float(totalTime)
                self.ProgressBar1.progress = percentagePrograss
            } else {
                self.MainText.text = "DONE"
                
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player?.play()
                
                Timer.invalidate()
                }
            }
     
    }
    
    
        
}
