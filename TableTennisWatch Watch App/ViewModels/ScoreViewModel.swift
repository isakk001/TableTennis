//
//  ScoreViewModel.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/29.
//

import Foundation
import WatchConnectivity

final class ScoreViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var player1: Int = 0
    @Published var player2: Int = 0
    
    @Published var set1: Int = 0
    @Published var set2: Int = 0
    
    @Published var limitScore: Int = 10
    @Published var isWin: Int = 0
    
    @Published var servePlayer: Int = 0

    @Published var shouldStartAnimation: Bool = false
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let command = message[Constants.command] as? String {
            DispatchQueue.main.async {
                if command == Constants.startView {
                    PageManager.shared.pageState = .startView
                } else if command == Constants.coinTossView {
                    PageManager.shared.pageState = .coinTossView
                } else if command == Constants.coinResultView {
                    PageManager.shared.pageState = .coinResultView
                } else if command == Constants.scoreView {
                    PageManager.shared.pageState = .scoreView
                } else if command == Constants.resultView {
                    PageManager.shared.isGameEnd = true
                    PageManager.shared.pageState = .scoreView
                } else if command == Constants.coinToss {
                    self.shouldStartAnimation = true
                }
            }
        } else {
            DispatchQueue.main.async {
                self.player1 = message[Constants.player1] as? Int ?? self.player1
                self.player2 = message[Constants.player2] as? Int ?? self.player2
                self.set1 = message[Constants.set1] as? Int ?? self.set1
                self.set2 = message[Constants.set2] as? Int ?? self.set2
                self.servePlayer = message[Constants.servePlayer] as? Int ?? self.servePlayer
            }
        }
    }
    
    
    func plusScore(player: Int) {
        
        if player == 0 {
            self.player1 += 1
        } else {
            self.player2 += 1
        }
        
        if checkDeuce() {
            if (self.player1 - self.player2) == 2 {
                self.player1 = 0
                self.player2 = 0
                self.set1 += 1
            } else if (self.player2 - self.player1) == 2 {
                self.player1 = 0
                self.player2 = 0
                self.set2 += 1
            }
            
            if self.servePlayer == 0 {
                self.servePlayer = 1
            } else {
                self.servePlayer = 0
            }
            
        } else {
            if self.player1 > self.limitScore {
                self.player1 = 0
                self.player2 = 0
                self.set1 += 1
            }
            
            if self.player2 > self.limitScore {
                self.player1 = 0
                self.player2 = 0
                self.set2 += 1
            }
            
            if (self.player1 + self.player2) % 2 == 0 {
                if self.servePlayer == 0 {
                    self.servePlayer = 1
                } else {
                    self.servePlayer = 0
                }
            }
        }
    }
    
    func minusScore(player: Int) {
        if player == 0 {
            if self.player1 > 0 {
                self.player1 -= 1
            }
        } else {
            if self.player2 > 0 {
                self.player2 -= 1
            }
        }
        
        if (self.player1 + self.player2) % 2 == 1 {
            if self.servePlayer == 0 {
                self.servePlayer = 1
            } else {
                self.servePlayer = 0
            }
        }
    }
    
    func checkDeuce() -> Bool {
        if self.player1 >= 10 && self.player2 >= 10 {
            return true
        } else {
            return false
        }
    }

    func setServePlayer() {
        self.servePlayer = Int.random(in: 0...1)
    }
    
    func setRestart() {
        self.player1 = 0
        self.player2 = 0
        self.set1 = 0
        self.set2 = 0
    }
    
    func checkWinner() {
        if self.set1 > self.set2 {
            self.isWin = 0
        } else if self.set1 == self.set2 {
            if self.player1 >= self.player2 {
                self.isWin = 0
            } else {
                self.isWin = 1
            }
        } else {
            self.isWin = 1
        }
    }
}
