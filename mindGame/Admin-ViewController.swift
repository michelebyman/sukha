//
//  Admin-ViewController.swift
//  mindGame
//
//  Created by Michele Byman on 2020-10-26.
//

import UIKit
import Firebase


class Admin_ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var color = ""
    
    @IBOutlet weak var questionDescription: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

    
    }
    

    
        @IBAction func purpleQuestion(_ sender: Any) {
            color = "Purple"
            addQuestionToDatabase(color: color, question: questionDescription.text!)
        }
    
        @IBAction func greenQuestion(_ sender: Any) {
            color = "Green"
            addQuestionToDatabase(color: color, question: questionDescription.text!)
        }
    
        @IBAction func redQuestion(_ sender: Any) {
            color = "Red"
            addQuestionToDatabase(color: color, question: questionDescription.text!)
        }
    
        @IBAction func yellowQuestion(_ sender: Any) {
            color = "Yellow"
            addQuestionToDatabase(color: color, question: questionDescription.text!)
        }
    
        @IBAction func blueQuestion(_ sender: Any) {
            color = "Blue"
            addQuestionToDatabase(color: color, question: questionDescription.text!)
        }
    
        func addQuestionToDatabase(color: String, question: String) {
//            let id =  ref.childByAutoId().key
//            ref.child("questions").child("category").child("\(color)").child( "\(String(describing: id))").setValue(["question": "\(question)"])
//            questionDescription.text = ""
          
            ref.child("questions").child("\(color)").childByAutoId().setValue(["question": "\(question)"])
            questionDescription.text = ""
        }
}
