//  StartView.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI
import WatchConnectivity

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 75, bottom: 15, trailing: 75))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.33725490196078434, green: 0.5215686274509804, blue: 0.9058823529411765), Color(red: 0.12156862745098039, green: 0.8862745098039215, blue: 0.8549019607843137)]), startPoint: .topTrailing, endPoint: .bottomLeading))
            .cornerRadius(30)
    }
}

struct StartView: View {
    @State private var showScoreView = false

    var body: some View {
        NavigationView {
            VStack {
                TitleView()

                NavigationLink(destination: ScoreView(), isActive: $showScoreView) {
                    Text("Play")
                        .font(.custom("SFProText-Semibold", size: 17))
                        .onTapGesture {
                            self.showScoreView = true
                            WatchSessionManager.sharedManager.sendPlayCommand()
                        }
                }
                .buttonStyle(CustomButtonStyle())
            }
            .onAppear {
                WatchSessionManager.sharedManager.startSession()
            }
            .onReceive(WatchSessionManager.sharedManager.$showScoreView) { value in
                self.showScoreView = value
            }
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Let's Play")
                .font(.system(size: 17))
                .foregroundColor(Color(red: 0.5568627715110779, green: 0.5568627715110779, blue: 0.5764706134796143))
            Text("Table Tennis")
                .font(.custom("SFCompactRounded-Semibold", size: 32))
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

final class WatchSessionManager: NSObject, ObservableObject, WCSessionDelegate {
    static let sharedManager = WatchSessionManager()
    @Published var showScoreView = false

    private override init() {
        super.init()
    }

    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

    func startSession() {
        session?.delegate = self
        session?.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let command = message["command"] as? String, command == "play" {
            DispatchQueue.main.async {
                self.showScoreView = true
            }
        }
    }

    func sendPlayCommand() {
        guard WCSession.default.isReachable else {
            print("Not Reachable")
            return
        }
        let message = ["command": "play"]
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: { error in
            print(error.localizedDescription)
        })
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
}
