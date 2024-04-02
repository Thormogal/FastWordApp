//
//  GameViewController.swift
//  FastWordApp
//
//  Created by Ina Burström on 2024-03-28.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var writeWordTextfield: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var writeThisWordLabel: UILabel!
    @IBOutlet weak var pointsCounterLabel: UILabel!
    @IBOutlet weak var wordCounterLabel: UILabel!
    
    let gameTimer = PreciseGameTimer(seconds: 5)
    let gameModel = GameModel()
    
    override func viewDidLoad() {
        
     super.viewDidLoad()
        gameModel.delegate = self
        
        gameModel.score = UserDefaults.standard.integer(forKey: "SavedScore")
        writeWordTextfield.delegate = self
        writeWordTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        startNewGame()
        gameTimer.completion = { [weak self] in
            self?.timerDidFinish()
            
        }
        
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeWordTextfield.becomeFirstResponder()
    }
    
    
    //func goToStartPage() {
      //      self.navigationController?.popToRootViewController(animated: true)
        //}
    
    func startNewGame() {
        let firstWord = gameModel.startNewGame()
        writeThisWordLabel.text = firstWord
        gameTimer.startTimer()
        updateWordCounterLabel()
        cleanInput()
    }

    
    //checks user input and compares it to the word that is shown on the screen.
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let answer = textField.text else { return }
        
        if gameModel.checkAnswer(answer) {
            gameModel.score += 1
            gameTimer.stopTimer()
            let timeTaken = 5 - gameTimer.timeLeft
            gameModel.timeTakenList.append(timeTaken)
            proceedToNextWord()
            
            
            
        }
    }
    
    func proceedToNextWord() {
        if let nextWord = gameModel.getNextWord() {
            writeThisWordLabel.text = nextWord
            updateWordCounterLabel()
            cleanInput()
            gameTimer.startTimer() // resets the timer for the upcoming word
        } else {
            finishGame()
        }
    }
    
    func timerDidFinish() {
        // show an alert to the user
        gameModel.score = max(gameModel.score - 1, 0)   // // Minska poängen men inte under 0
        let alert = UIAlertController(title: "Time's Up!", message: "Too slow, you got 0 points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            // proceed to next word when "OK" is pressed.
            self?.increaseIndex()
            self?.proceedToNextWord()
        }))
        
        present(alert, animated: true)
    }
    
    func cleanInput() {
        writeWordTextfield.text = ""
    }
    
    func increaseIndex() {
        gameModel.increaseIndex()
    }
    
    
    
    func updateWordCounterLabel() {
            let currentWordNumber = gameModel.currentIndex + 1
            let totalWordsCount = gameModel.wordManager.currentWords.count
            wordCounterLabel.text = "\(currentWordNumber)/\(totalWordsCount)"
        }
    
    func finishGame() {
        //implement logic to what happens when the word list is finished
        let message = "Spelet är slut! Din poäng blev \(gameModel.score)."
            let alert = UIAlertController(title: "Spelet är slut", message: message, preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Spela igen", style: .default, handler: { [weak self] _ in
                self?.startNewGame()
                
            }))
        
    
        
       // alert.addAction(UIAlertAction(title: "Gå till startsida", style: .default, handler: { [weak self] _ in
                
               // self?.goToStartPage()
           // }))
        
            self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension GameViewController: GameModelDelegate {
    func scoreDidUpdate(to newScore: Int) {
        DispatchQueue.main.async {
            self.pointsCounterLabel.text = "Count points: \(newScore)"
        }
    }
}
