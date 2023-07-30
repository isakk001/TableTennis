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
}
