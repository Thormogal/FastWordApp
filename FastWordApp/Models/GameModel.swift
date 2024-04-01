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
    
}
