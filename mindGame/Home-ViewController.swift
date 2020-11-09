//
//  Home-ViewController.swift
//  mindGame
//
//  Created by Michele Byman on 2020-10-28.
//

import UIKit

class Home_ViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = 50
        startBtn.layer.borderWidth = 2
        startBtn.layer.borderColor = UIColor(named: "borderBtn")?.cgColor
        
    }
}
