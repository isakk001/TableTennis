//
//  ScoreViewModel.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/07/29.
//

import Foundation
import WatchConnectivity

final class ScoreViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    static let shared = ScoreViewModel()
    private override init() {
        self.session = WCSession.default
        super.init()
        session.delegate = self
        session.activate()
    }
    
    @Published var player1: Int = 0
    @Published var player2: Int = 0
    @Published var isWin: Int = 0
    
    @Published var set1: Int = 0
    @Published var set2: Int = 0
    @Published var limitScore: Int = 10
    
    @Published var servePlayer: Int = 0

    @Published var shouldStartAnimation: Bool = false
    
    var session: WCSession

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
                    PageManager.shared.pageState = .resultView
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

    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
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
    }
    
    func checkDeuce() -> Bool {
        if self.player1 >= 10 && self.player2 >= 10 {
            return true
        } else {
            return false
        }
    }
    
    func endGame() {
        self.player1 = 0
        self.player2 = 0
        self.set1 = 0
        self.set2 = 0
    }
    
    func restartGame() {
        self.player1 = 0
        self.player2 = 0
    }
    
    func checkGameSet() -> Bool {
        self.set1 == 3 || self.set2 == 3
    }
    
    func checkWinner() -> Int {
        if self.set1 > self.set2 {
            return 0
        } else if self.set1 == self.set2 {
            if self.player1 >= self.player2 {
                return 0
            } else {
                return 1
            }
        } else {
            return 1
        }
    }

    func setServePlayer() {
        self.servePlayer = Int.random(in: 0...1)
    }
}
