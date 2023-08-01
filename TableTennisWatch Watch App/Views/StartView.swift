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
            .background(LinearGradient(gradient: Gradient(colors: [Color("Fills_Gradient_Start"), Color("Fills_Gradient_End")]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(30)
    }
}

enum PageState {
    case startView
    case coinTossView
    case coinResultView
    case scoreView
}

class PageManager : ObservableObject {
    static let shared = PageManager()
    private init() {}
    
    @Published var pageState: PageState = .startView
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
            case .startView:
                StartPlayView(viewModel: viewModel)
                    .onAppear {
                        viewModel.setRestart()
                    }
            case .coinTossView:
                CoinTossView(namespace: namespace, viewModel: viewModel)
            case .coinResultView:
                CoinResultView(namespace: namespace, viewModel: viewModel)
            case .scoreView:
                TabView(selection: $pageManager.tabState) {
                    RestartView(viewModel: viewModel)
                        .tag(0)
                    VStack{
                        if pageManager.isGameEnd {
                            PlayResultView(isWin: viewModel.isWin)
                        } else {
                            ScoreView(viewModel: viewModel, pageManager: pageManager)
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
    @ObservedObject var viewModel: ScoreViewModel
    
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
                viewModel.session.sendMessage(["command": "CoinTossView"], replyHandler: nil)
            } label: {
                Text("Play")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
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
