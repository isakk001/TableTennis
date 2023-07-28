//
//  ScoreModel.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/27.
//

import Foundation
import WatchConnectivity

final class ScoreModel: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var player1: Int = 0
    @Published var player2: Int = 0
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.player1 = message["leftPlayer"] as? Int ?? self.player1
            self.player2 = message["rightPlayer"] as? Int ?? self.player2
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
