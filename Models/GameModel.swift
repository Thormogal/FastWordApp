//
//  GameModel.swift
//  FastWordApp
//
//  Created by Ina Burström on 2024-04-01.
//

import Foundation

protocol GameModelDelegate: AnyObject {
    func scoreDidUpdate(to newScore: Int)
}

class GameModel {
    //var score = 0
    weak var delegate: GameModelDelegate?
    var wordManager = WordManager()
    var currentIndex = 0
    var timeTakenList: [Int] = []
    
    
    var score: Int = 0 {
        didSet {
            UserDefaults.standard.set(score, forKey: "SavedScore")
            delegate?.scoreDidUpdate(to: score)
        }
    }
    
    func startNewGame() -> String? {
        wordManager.shuffleWords()
        currentIndex = 0
        if !wordManager.currentWords.isEmpty {
                return wordManager.currentWords[0]
            } else {
                return nil
            }
    }
    
    func saveHighScore() {
     let highScores = UserDefaults.standard.array(forKey: "HighScores") as? [Int] ?? []
     let updatedHighScores = highScores + [score]

         let sortedAndReversedHighScores = Array(updatedHighScores.sorted().reversed())
             UserDefaults.standard.set(sortedAndReversedHighScores, forKey: "HighScores")
        print("Sparade högsta poäng: \(sortedAndReversedHighScores)")

     //UserDefaults.standard.set(updatedHighScores.sorted().reversed(), forKey: "HighScores")
     }

     func resetGame() {
             score = 0
             currentIndex = 0
             timeTakenList = []
            // shuffleWords()

     }

    
    func checkAnswer(_ answer: String) -> Bool {
        guard currentIndex < wordManager.currentWords.count else { return false }
        let isCorrect = answer.lowercased() == wordManager.currentWords[currentIndex].lowercased()
        if isCorrect {
            increaseIndex()
        }
        return isCorrect
    }
    
    func increaseIndex() {
        currentIndex += 1
    }
    
    func getNextWord() -> String? {
        guard let nextWord = wordManager.showNextWord(at: currentIndex) else {
            return nil
        }
        return nextWord
    }
}
