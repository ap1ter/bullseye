//
//  ViewController.swift
//  Bullseye
//
//  Created by Андрей Питеров on 7/15/17.
//  Copyright © 2017 Sobiq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func showAlert(){
        let diff = abs(targetValue - currentValue)
        var points = 100 - diff
        
        var title: String
        
        if diff == 0 {
            title = "Perfect"
            points += 100
        } else if diff < 5{
            title = "You almost had it!"
            if diff == 1 {
                points += 50
            }
        } else if diff < 10 {
            title = "Pretty close"
        } else {
            title = "Not even close..."
        }
        
        let message = "Slider value is: \(currentValue)\nThe target value is: \(targetValue)\nYou scored \(points) points."
        score += points
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionItem = UIAlertAction(title: "OK", style: .default) { [weak self]
            action in
                self?.startNewRound()
                self?.updateLabels()
        }
        
        alertController.addAction(actionItem)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame(){
        round = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound(){
        round += 1
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
    }

}

