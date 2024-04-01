//
//  GameModel.swift
//  FastWordApp
//
//  Created by Ina Burström on 2024-04-01.
//

import Foundation

class GameModel {
    var wordManager = WordManager()
    var currentIndex = 0
    var timeTakenList: [Int] = []
    
    func startNewGame() {
        wordManager.shuffleWords()
        currentIndex = 0
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        guard currentIndex < wordManager.currentWords.count else { return false }
        let isCorrect = answer.lowercased() == wordManager.currentWords[currentIndex].lowercased()
        if isCorrect {
            currentIndex += 1
        }
        return isCorrect
    }
    
    func getNextWord() -> String? {
        guard let nextWord = wordManager.showNextWord(at: currentIndex) else {
            return nil
        }
        return nextWord
    }
}
