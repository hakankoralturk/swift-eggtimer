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
    
    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var progressTimer: UIProgressView!
    
    var audioPlayer: AVAudioPlayer!
    
    let eggTimes = ["Soft": 10, "Medium": 480, "Hard": 720]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    func playAlarm(sound: String) {
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        
        do {
            /* All time playing, silent or no silent */
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try! AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func selectedHardness(_ sender: UIButton) {
        
        progressTimer.progress = 1
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressTimer.progress = 0.0
        secondsPassed = 0
        lblSummary.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            print("\(secondsPassed) seconds.")
            secondsPassed += 1
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            progressTimer.progress = percentageProgress
        } else {
            timer.invalidate()
            
            lblSummary.text = "Done!"
            
            playAlarm(sound: "alarm_sound")
        }
    }
    
}
