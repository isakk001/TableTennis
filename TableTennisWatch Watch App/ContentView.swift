//
//  ContentView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    @State var lastScore: Int = 0
    
    var body: some View {
        HStack {
            VStack {
                Text("\(Int(viewModel.player1))")
                    .font(.largeTitle)
                    .focusable()
                    .digitalCrownRotation($viewModel.player1, from: 0.0, through: 11.0, by: 0.01, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: false)
                Button {
                    viewModel.player1 += 1
//                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
//                    WKInterfaceDevice.current().play(.notification)
                    /* WKInterfaceDevice.current().play(.) <- .play(.) 괄호 안 . 오른쪽에서 esc로 자동완성 목록들을 찾아보면 여러 햅틱 종류가 있음
                                    */
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button {
                    viewModel.player1 -= 1
//                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
//                    WKInterfaceDevice.current().play(.notification)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            VStack {
                Text(viewModel.player2.description)
                    .font(.largeTitle)
                Button {
                    viewModel.player2 += 1
//                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
//                    WKInterfaceDevice.current().play(.notification)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button {
                    viewModel.player2 -= 1
//                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
//                    WKInterfaceDevice.current().play(.notification)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }

            }
        }
        .onChange(of: viewModel.player1) { newValue in
            if abs(Int(newValue) - lastScore) >= 1 {
                lastScore = Int(newValue)
                WKInterfaceDevice.current().play(.notification)
                viewModel.session.sendMessage(["player1" : lastScore], replyHandler: nil)
            }
        }
        .onChange(of: viewModel.player2) { newValue in
                    WKInterfaceDevice.current().play(.notification)
            viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
            WKInterfaceDevice.current().play(.notification)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



final class ContentViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var player1: Double = 0.0
    @Published var player2: Int = 0

    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.player1 = message["player1"] as? Double ?? self.player1
            self.player2 = message["player2"] as? Int ?? self.player2
        }
    }
}
