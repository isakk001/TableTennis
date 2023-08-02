//  StartView.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI
import WatchConnectivity

struct CustomButtonStyle: ButtonStyle {
    let colors = Colors.self
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 12, leading: 72, bottom: 12, trailing: 72))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(colors.gradientStart.name), Color(colors.gradientEnd.name)]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(30)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: -20, trailing: 8))
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
    let logo = Constants.appLogo
    let phrase = Constants.titlePhrase
    
    var body: some View {
        VStack {
            Image(logo)
                .resizable()
                .scaledToFit()
            
            Text(phrase)
                .foregroundColor(.gray)
                .font(.system(size: 15))
        }
    }
}

struct StartPlayView : View {
    @ObservedObject var viewModel: ScoreViewModel
    
    @State var buttonText = Constants.playButton
    
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
                viewModel.session.sendMessage([Constants.command: Constants.coinTossView], replyHandler: nil)
            } label: {
                Text(buttonText)
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
