//
//  WordManager.swift
//  FastWordApp
//
//  Created by Ina Burström on 2024-03-29.
//

import Foundation

class WordManager {
    
    var originalWords = ["pineapple","strawberry","lingonberry","passion fruit","apple","pear","kiwi","orange","watermelon","cape gooseberry"]
    var currentWords: [String] = []
    
    func shuffleWords() {
        currentWords = originalWords.shuffled()
    }
    
    func showNextWord(at index: Int) -> String? {
            guard index < currentWords.count else { return nil }
            return currentWords[index]
        }
}
