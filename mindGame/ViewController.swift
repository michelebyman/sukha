//
//  ViewController.swift
//  mindGame
//
//  Created by Michele Byman on 2020-10-02.
//

import UIKit
import Firebase
import MSCircularSlider

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var color = ""
    var question = ""
    var gameType = ""
    var dice = [String] ()
    var randomColor = ""
    var questions = [String] ()
    var usedQuestions = [String]()
    var counter = 0
    var timer: Timer?
    var isPaused = true
   
    @IBOutlet weak var slider: MSCircularSlider!
    @IBOutlet weak var questionDisplay: UITextView!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var questionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        dice.append("Red")
        dice.append("Green")
        dice.append("Blue")
        dice.append("Yellow")
        dice.append("Purple")
        questionDisplay.text = ""
        slider._maximumValue = 1200
        questionBtn.layer.cornerRadius = 25
        questionBtn.layer.borderWidth = 2
        questionBtn.layer.borderColor = UIColor(named: "borderBtn")?.cgColor
    }
    
    func setTimer() {
        counter = 1200
        timerBtn.setTitle("Paus", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timerBtn.setTitle("Fortsätt", for: .normal)
        timer!.invalidate()
    }

    func resumeTimer() {
        timerBtn.setTitle("Paus", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            slider._currentValue = Double(counter)
            counter -= 1
        } else {
            timerBtn.setTitle("Tiden är ute", for: .normal)
        }
    }
    
    func getQuestions() {
            randomColor = dice.randomElement()!
            let index = dice.firstIndex(where: {$0 == randomColor})
            dice.remove(at: index!)
            ref.child("questions/\(randomColor)").observeSingleEvent(of: .value, with: { [self] (snapshot) in
                for question in snapshot.children {
                    let snapQuest = question as! DataSnapshot
                    let questionObject = snapQuest.value as! [String: String]
                    let question = questionObject["question"] as Any
                    questions.append(question as! String)
                }
                let randomQuestion = questions.randomElement()
                questionDisplay.text = randomQuestion
                let index = questions.firstIndex(where: {$0 == randomQuestion})
                questions.remove(at: index!)
              }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    @IBAction func puseAndResume(_ sender: Any) {
        if counter == 0 {
            return
        }
            if isPaused {
                pauseTimer()
                isPaused = !isPaused
            } else {
                resumeTimer()
                isPaused = !isPaused
            }
          
    }
    
    @IBAction func getQuestion(_ sender: Any) {
        isPaused = true
        if counter > 1170 {
            return
        }
            counter = 1200
            timer?.invalidate()
            timerBtn.setTitle("Paus", for: .normal)
            setTimer()
            if dice.count > 0 {
                getQuestions()
                
            } else {
                if questions.count > 0 {
                    let randomQuestion = questions.randomElement()
                    questionDisplay.text = randomQuestion
                    let index = questions.firstIndex(where: {$0 == randomQuestion})
                    questions.remove(at: index!)
                } else {
                    counter = 0
                    timerBtn.setTitle("Bra jobbat!", for: .normal)
                    questionDisplay.text = "Slut på frågor, dax att reflektera och meditera."
                    questionBtn.isHidden = true
                    
                }
        }
    }
    
}


