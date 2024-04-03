//
//  GameTimer.swift
//  FastWordApp
//
//  Created by Oskar Lövstrand on 2024-03-28.
//

import Foundation

class PreciseGameTimer {
    var startTime: Date?
    var timer: Timer?
    var totalSeconds: Int
    var timeUpdate: ((Int) -> Void)?
    var completion: (() -> Void)?
    
    var timeLeft: Int {
        guard let startTime = startTime else { return totalSeconds }
        return totalSeconds - Int(-startTime.timeIntervalSinceNow)
    }
    
    init (seconds: Int) {
        self.totalSeconds = seconds
    }
    
    func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func checkTimer() {
        guard let startTime = startTime else { return }
        
        let elapsedSeconds = Int(-startTime.timeIntervalSinceNow)
        if elapsedSeconds >= totalSeconds {
            completion?()
            stopTimer()
        } else {
            timeUpdate?(totalSeconds - elapsedSeconds)
        }
    }
}

