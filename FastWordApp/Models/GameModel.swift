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
    
    func startNewGame() -> String? {
        wordManager.shuffleWords()
        currentIndex = 0
        if !wordManager.currentWords.isEmpty {
                return wordManager.currentWords[0]
            } else {
                return nil
            }
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
