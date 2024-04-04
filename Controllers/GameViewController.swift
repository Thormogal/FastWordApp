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
    
    @IBOutlet weak var stackView: UIStackView!
    let gameTimer = PreciseGameTimer()
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
        gameTimer.timeUpdate = { [weak self] timeLeft in
            self?.timerLabel.text = "\(timeLeft)"}
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStartGameAlert()
        writeWordTextfield.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        stackView.spacing = 50
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        stackView.spacing = 100
    }
    
    
    //func goToStartPage() {
    //      self.navigationController?.popToRootViewController(animated: true)
    //}
    
    func startNewGame() {
        gameModel.resetGame()
        let initialTime = gameTimer.totalSeconds
            timerLabel.text = "\(initialTime)"
        let firstWord = gameModel.startNewGame()
        writeThisWordLabel.text = firstWord
        updateWordCounterLabel()
        cleanInput()
    }
    
    func showStartGameAlert() {
        let alert = UIAlertController(title: "Are you ready?", message: "Press Ok to start the game.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.gameTimer.startTimer()
        }))
        
        self.present(alert, animated: true)
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
        gameModel.score = max(gameModel.score - 1, 0)   // // Decrease score but not under zero
        let alert = UIAlertController(title: "Time's Up!", message: "Too slow, you got -1 points", preferredStyle: .alert)
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
        gameModel.saveHighScore()
        //implement logic to what happens when the word list is finished
        let message = "Spelet är slut! Din poäng blev \(gameModel.score)."
        let alert = UIAlertController(title: "Spelet är slut", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Spela igen", style: .default, handler: { [weak self] _ in
            self?.gameModel.resetGame()
            self?.startNewGame()
            self?.showStartGameAlert()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Gå till startsida", style: .default, handler: { [weak self] _ in
            self?.goToStartPage()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToStartPage() {
        //self.navigationController?.popToRootViewController(animated: true)
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension GameViewController: GameModelDelegate {
    func scoreDidUpdate(to newScore: Int) {
        DispatchQueue.main.async {
            self.pointsCounterLabel.text = "Count points: \(newScore)"
        }
    }
}
