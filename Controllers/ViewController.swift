//
//  ViewController.swift
//  FastWordApp
//
//  Created by Oskar Lövstrand on 2024-03-28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func highscoreButtonTapped(_ sender: UIButton) {
        print("Highscore-knappen trycktes på.")
            let highscoreVC = HighscoreController(nibName: "HighscoreView", bundle: nil)
            print("Presenterar HighscoreController.")
            self.present(highscoreVC, animated: true, completion: nil)
    }
    
}

