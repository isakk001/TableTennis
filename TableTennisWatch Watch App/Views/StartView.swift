//  StartView.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI
import WatchConnectivity

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 70, bottom: 15, trailing: 70))
            .foregroundColor(.white)
            .background(LinearGradient(colors: [Color("Fills_Gradient_Start"), Color("Fills_Gradient_End")], startPoint: .topTrailing, endPoint: .bottomLeading))
            .cornerRadius(30)
    }
}

enum PageState {
    case progressBarView
    case coinTossView
    case coinResultView
    case scoreView
}

class PageManager : ObservableObject {
    static let shared = PageManager()
    private init() {}
    
    @Published var pageState: PageState = .progressBarView
    @Published var tabState: Int = 1
    @Published var isGameEnd: Bool = false
}

struct StartView: View {
    @Namespace var namespace
    @StateObject var viewModel = ScoreViewModel()
    @StateObject var pageManager = PageManager.shared
    
    var body: some View {
        VStack {
            switch pageManager.pageState {
            case .progressBarView:
                StartPlayView()
            case .coinTossView:
                CoinTossView(namespace: namespace, viewModel: viewModel)
            case .coinResultView:
                CoinResultView(namespace: namespace, viewModel: viewModel)
            case .scoreView:
                TabView(selection: $pageManager.tabState) {
                    RestartView()
                        .tag(0)
                    VStack{
                        if pageManager.isGameEnd {
                            PlayResultView()
                        } else {
                            ScoreView(viewModel: viewModel)
                        }
                    }
                    .tag(1)
                }
            }
        }
    }
}

struct LogoView: View {
    var body: some View {
        VStack {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
            Text("Let's play Table Tennis!")
                .foregroundColor(Color.gray)
                .font(.system(size: 15))
        }
    }
}

struct StartPlayView : View {
    
    var body: some View {
        VStack {
            Spacer()
            LogoView()
                .padding(10)
            Spacer()
            Button {
                withAnimation(.linear(duration: 0.2)) {
                    PageManager.shared.pageState = .coinTossView
                }
            } label: {
                Text("Play")
                    .font(.custom("SFProText-Semibold", size: 17))
            }
            .buttonStyle(CustomButtonStyle())
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
}
