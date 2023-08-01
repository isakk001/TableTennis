//
//  ScoreView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct PlayerScoreView: View {
    @ObservedObject var viewModel: ScoreViewModel
    
    var player: Int
    
    let mark = "Icon_Phone"
    let symbols = Symbols.self
    let colors = Colors.self
    
    let uiscreen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(setFillsColor(checkServer(viewModel.servePlayer, player)))
                    .padding(EdgeInsets(top: -12, leading: 56, bottom: -12, trailing: 56))
                
                VStack {
                    Button {
                        viewModel.plusScore(player: player)
                        viewModel.session.sendMessage(["player\(player + 1)" : getPlayerScore(player)], replyHandler: nil)
                        viewModel.session.sendMessage(["set\(player + 1)" : getPlayerSet(player)], replyHandler: nil)
                    } label: {
                        Image(systemName: symbols.circlePlus.name)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                    
                    Text( String(format: "%02d", getPlayerScore(player)))
                        .font(.system(size: 180))
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                        .foregroundColor(.white)
                    
                    Button {
                        viewModel.minusScore(player: player)
                        viewModel.session.sendMessage(["player\(player + 1)" : getPlayerScore(player)], replyHandler: nil)
                        viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
                    } label: {
                        Image(systemName: symbols.circleMinus.name)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                }
                
                if let markView = markServer(checkServer(viewModel.servePlayer, player), player) {
                    ZStack {
                        markView
                    }
                }
            }
        }
    }
    
    func getPlayerScore(_ player: Int) -> Int {
        if player == 0 {
            return viewModel.player1
        } else {
            return viewModel.player2
        }
    }
    
    func getPlayerSet(_ player: Int) -> Int {
        if player == 0 {
            return viewModel.set1
        } else {
            return viewModel.set2
        }
    }
    
    func checkServer(_ server: Int, _ player: Int) -> Bool {
        if server == player {
            return true
        } else {
            return false
        }
    }
    
    func markServer(_ isServer: Bool, _ player: Int) -> AnyView? {
        var markView: AnyView?
        
        if isServer {
            if player == 0 {
                markView = AnyView(
                    ZStack {
                        Image(mark)
                            .resizable()
                            .scaledToFit()
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 200, leading: -176, bottom: 0, trailing: 0)))
            } else {
                markView = AnyView(
                    ZStack {
                        Image(mark)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(x: -1, y: 1)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 200, leading: 170, bottom: 0, trailing: -112)))
            }
        }
        
        return markView
    }
    
    func setFillsColor(_ isServer: Bool) -> AnyShapeStyle {
        let colors = Colors.self
        
        if isServer {
            let fillsView = LinearGradient(
                gradient: Gradient(colors: [
                    Color(colors.gradientStart.name),
                    Color(colors.gradientEnd.name)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            return AnyShapeStyle(fillsView)
        } else {
            let fillsView = Color(colors.fillsPrimary.name)
            
            return AnyShapeStyle(fillsView)
        }
    }
}

struct ScoreView: View {
    
    @ObservedObject var viewModel: ScoreViewModel
    @ObservedObject var pageManager: PageManager
    @State var endGame = false
    
    let symbols = Symbols.self
    let colors = Colors.self
    
    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                GameHeader(viewModel: viewModel, pageManager: pageManager)
                HStack(spacing: -28) {
                    PlayerScoreView(viewModel: viewModel, player: 0)
                    
                    Text(":")
                        .font(.system(size: 160))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                    
                    PlayerScoreView(viewModel: viewModel, player: 1)
                }
            }
            .onChange(of: viewModel.set1) { newValue in
                if newValue == 3 {
                    viewModel.isWin = 0
                    pageManager.pageState = .resultView
                    viewModel.session.sendMessage(["command": "ResultView"], replyHandler: nil)
                }
            }
            .onChange(of: viewModel.set2) { newValue in
                if newValue == 3 {
                    viewModel.isWin = 1
                    pageManager.pageState = .resultView
                    viewModel.session.sendMessage(["command": "ResultView"], replyHandler: nil)
                }
            }
        }
        .onAppear {
            viewModel.endGame()
        }
        .navigationBarBackButtonHidden()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScoreView(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
        }
    }
}
