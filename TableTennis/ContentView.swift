//
//  ContentView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        HStack {
            VStack {
                Text(viewModel.player1.description)
                    .font(.largeTitle)
                Text(viewModel.session.isReachable ? "Reachable" : "Unreachable")
                Button {
                    viewModel.player1 += 1
                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    viewModel.player1 -= 1
                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

            }
            VStack {
                Text(viewModel.player2.description)
                    .font(.largeTitle)
                Text(viewModel.session.isReachable ? "Reachable" : "Unreachable")
                Button {
                    viewModel.player2 += 1
                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    viewModel.player2 -= 1
                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


final class ContentViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var player1: Int = 0
    @Published var player2: Int = 0
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.player1 = message["player1"] as? Int ?? self.player1
            self.player2 = message["player2"] as? Int ?? self.player2
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
