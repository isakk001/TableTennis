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
    
    @Published var servePlayer: Int = 0
    
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
        DispatchQueue.main.async {
            print("iphone: \(message)")
            self.player1 = message["player1"] as? Int ?? self.player1
            self.player2 = message["player2"] as? Int ?? self.player2
            self.set1 = message["set1"] as? Int ?? self.set1
            self.set2 = message["set2"] as? Int ?? self.set2
        }
    }
    
    
    func plusScore(player: Int) {
        if player == 0 {
            self.player1 += 1
            
            if self.player1 > self.limitScore {
                self.player1 = 0
                self.player2 = 0
                self.set1 += 1
            }
        } else {
            self.player2 += 1

            if self.player2 > self.limitScore {
                self.player1 = 0
                self.player2 = 0
                self.set2 += 1
            }
        }
        
        
        if (self.player1 + self.player2) % 2 == 0 {
            if self.servePlayer == 0 {
                self.servePlayer = 1
            } else {
                self.servePlayer = 0
            }
        }
        
    }
    
    func minusScore(player: Int) {
        if player == 0 {
            if self.player1 > 0 {
                self.player1 -= 1
            }
        } else {
            if self.player2 > 2 {
                self.player2 -= 1
            }
        }
    }
}