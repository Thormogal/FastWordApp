//
//  GameViewController.swift
//  FastWordApp
//
//  Created by Ina Burström on 2024-03-28.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var writeWordTextfield: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var writeThisWordLabel: UILabel!
    @IBOutlet weak var pointsCounterLabel: UILabel!
    @IBOutlet weak var wordCounterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeWordTextfield.becomeFirstResponder()
    }

}
