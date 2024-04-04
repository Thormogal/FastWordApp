//
//  TableViewController.swift
//  FastWordApp
//
//  Created by Oskar Lövstrand on 2024-04-03.
//

import UIKit

extension UIColor {
    static let gold = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
    static let silver = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
    static let bronze = UIColor(red: 205/255, green: 127/255, blue: 50/255, alpha: 1)
    static let customBlue = UIColor(red: 0/255, green: 60/255, blue: 128/255, alpha: 1)
}

class LeaderboardTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var crownImageView: UIImageView!
}

class LeaderboardController: UITableViewController {
    
    
    var highScores: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: "HighscoreCell")
        loadHighScores()
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    func loadHighScores() {
        if let savedHighScores = UserDefaults.standard.array(forKey: "HighScores") as? [Int] {
            highScores = savedHighScores
        }
    }
    
    func createTableHeaderView() -> UIView {
        let headerLabel = UILabel()
        headerLabel.text = "Leaderboard"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        headerLabel.textColor = UIColor.customBlue
        
        // Background for the header
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60))
        backgroundView.backgroundColor = UIColor.gold
        
        // Shadow for the text
        headerLabel.shadowColor = UIColor.gray
        headerLabel.shadowOffset = CGSize(width: 1, height: 1)
        
        // Adds the headerLabel to the background and centers it
        headerLabel.frame = backgroundView.bounds
        backgroundView.addSubview(headerLabel)
        
        return backgroundView
    }
    
    //create an additional cell without information above the first cell
    func createSpacingView() -> UIView {
        let spacingView = UIView()
        spacingView.backgroundColor = .clear
        let spacingHeight: CGFloat = 20
        spacingView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: spacingHeight)
        return spacingView
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createSpacingView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(highScores.count, 50) //maximum number of rows in tableView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreCell", for: indexPath) as? LeaderboardTableViewCell else {
            fatalError("The dequeued cell is not an instance of LeaderboardTableViewCell.")
        }
        let scoreItem = highScores[indexPath.row]
        
        cell.rankingLabel.isHidden = false
        cell.crownImageView.isHidden = true
        cell.rankingLabel.text = "#\(indexPath.row + 1)"
        cell.scoreLabel.text = "\(scoreItem) points"
        cell.rankingLabel.textColor = .white
        cell.scoreLabel.textColor = .white
        
        switch indexPath.row {
        case 0: // First place, gold
            cell.crownImageView.isHidden = false  // Show the crown
            cell.rankingLabel.isHidden = true     // Hide the ranking label
            cell.scoreLabel.textColor = .gold     // Golden color on points
            cell.crownImageView.image = UIImage(named: "crownIcon")
        case 1: // Second place, silver
            cell.rankingLabel.textColor = .silver
            cell.scoreLabel.textColor = .silver
        case 2: // Third place, bronze
            cell.rankingLabel.textColor = .bronze
            cell.scoreLabel.textColor = .bronze
        default: // Every other placing
            cell.rankingLabel.textColor = .gray
            cell.scoreLabel.textColor = .gray
            break
        }
        
        return cell
    }
}
