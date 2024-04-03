//
//  TableViewController.swift
//  FastWordApp
//
//  Created by Oskar Lövstrand on 2024-04-03.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
}

class HighscoreController: UITableViewController {
    
    var highScores = [1, 2, 4, 3, 5, 9, 10, 7, 8, 6]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HighscoreTableViewCell", bundle: nil), forCellReuseIdentifier: "HighscoreCell")
        highScores.sort(by: >)
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    func createTableHeaderView() -> UIView {
            let headerLabel = UILabel()
            headerLabel.text = "High Score"
            headerLabel.textAlignment = .center
            headerLabel.font = UIFont.systemFont(ofSize: 24)
            headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
            return headerLabel
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(highScores.count, 10)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreCell", for: indexPath) as! HighscoreTableViewCell
        let scoreItem = highScores[indexPath.row]
        cell.rankingLabel.text = "#\(indexPath.row + 1)"  // Rankningen baserat på index
        cell.scoreLabel.text = "\(scoreItem) points"           // Poängen från den sorterade listan
        return cell
    }
}
