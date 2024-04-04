//
//  ViewController.swift
//  FastWordApp
//
//  Created by Oskar Lövstrand on 2024-03-28.
//

import UIKit

class StartPageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaderboardButtonTapped(_ sender: UIButton) {
        let leaderboardVC = LeaderboardController(nibName: "LeaderboardView", bundle: nil)
        self.present(leaderboardVC, animated: true, completion: nil)
    }
    
}

