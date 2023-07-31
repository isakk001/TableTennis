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
            .padding(EdgeInsets(top: 15, leading: 75, bottom: 15, trailing: 75))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.33725490196078434, green: 0.5215686274509804, blue: 0.9058823529411765), Color(red: 0.12156862745098039, green: 0.8862745098039215, blue: 0.8549019607843137)]), startPoint: .topTrailing, endPoint: .bottomLeading))
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
    @StateObject var viewModel = ScoreViewModel()
    @State private var path = NavigationPath()
    @State var progress: CGFloat = 0.0
    @StateObject var pageManager = PageManager.shared
//    @State private var showScoreView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                //                         TitleView()
                
                        VStack {
                            switch pageManager.pageState {
                                case .progressBarView:
                                    ProgressBarView()
                                case .coinTossView:
                                    CoinTossView(viewModel: viewModel)
                                case .coinResultView:
                                    CoinResultView(viewModel: viewModel)
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
                
//                NavigationLink(destination: ScoreView(), isActive: $showScoreView) {
//                    Text("Play")
//                        .font(.custom("SFProText-Semibold", size: 17))
//                        .onTapGesture {
//                            self.showScoreView = true
//                            WatchSessionManager.sharedManager.sendPlayCommand()
//                        }
//                }
//                        .buttonStyle(CustomButtonStyle())
            }
            .onAppear {
                WatchSessionManager.sharedManager.startSession()
            }
//            .onReceive(WatchSessionManager.sharedManager.$showScoreView) { value in
//                self.showScoreView = value
//            }
        }
        
        //        NavigationView {
        //            VStack {
        //                TitleView()
        //
        //                NavigationLink(destination: CoinTossView()) {
        //                    Text("Play")
        //                        .font(.custom("SFProText-Semibold", size: 17))
        //                }
        //                .buttonStyle(CustomButtonStyle())
        //            }
        //        }
        
    }
    
    //struct TitleView: View {
    //    var body: some View {
    //        VStack(alignment: .leading) {
    //            Text("Let's Play")
    //                .font(.system(size: 17))
    //                .foregroundColor(Color(red: 0.5568627715110779, green: 0.5568627715110779, blue: 0.5764706134796143))
    //            Text("Table Tennis")
    //                .font(.custom("SFCompactRounded-Semibold", size: 32))
    //        }
    //    }
    //}
    
    struct ProgressBarView : View {
        
        @StateObject var pageManager = PageManager.shared
        @State var progress: CGFloat = 0.0
        
        var body: some View {
            
            ZStack {
                Text("Start")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                
                Circle()
                    .stroke(Color(.gray), lineWidth: 15)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: -90))
            }
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    self.progress += 0.05
                    print(self.progress)
                    if self.progress >= 1.0 {
                        timer.invalidate()
                        pageManager.pageState = .coinTossView
                    }
                }
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
}
