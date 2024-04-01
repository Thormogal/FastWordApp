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
    var wordManager = WordManager()
    var currentIndex = 0
    var timeTakenList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func startNewGame() {
        wordManager.shuffleWords()
        currentIndex = 0
        showNextWord()
        gameTimer.startTimer()
    }
    
    
    //checks user input and compares it to the word that is shown on the screen.
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Current index: \(currentIndex)")
        var currentWord = wordManager.currentWords[currentIndex]
        print("Current word: \(currentWord)")
        print("Current words: \(wordManager.currentWords.joined(separator: ", "))")
        guard currentIndex < wordManager.currentWords.count else { return }
        
        if textField.text?.lowercased() == wordManager.currentWords[currentIndex].lowercased() {
            gameTimer.stopTimer()
            let timeTaken = 5 - gameTimer.timeLeft
            timeTakenList.append(timeTaken)
            proceedToNextWord()
        }
    }
    
    //clear the textfield and prepares for the upcoming word that will be shown
    func proceedToNextWord() {
        currentIndex += 1
        if currentIndex < wordManager.currentWords.count {
            cleanInput()
            showNextWord()
            gameTimer.startTimer() // resets the timer for the upcoming word
        } else {
            // implements the logic to what happens when the list is finished
            finishGame()
        }
    }
    
    func timerDidFinish() {
        // show an alert to the user
        let alert = UIAlertController(title: "Time's Up!", message: "Too slow, you got 0 points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            // proceed to next word when "OK" is pressed.
            self?.proceedToNextWord()
        }))
        
        // Present the alert
        present(alert, animated: true)
    }
    
    func showNextWord() {
        let nextWord = wordManager.currentWords[currentIndex]
        writeThisWordLabel.text = nextWord
    }
    
    func cleanInput() {
        writeWordTextfield.text = ""
    }
    
    func finishGame() {
        //implement logic to what happens when the word list is finished
    }
}
