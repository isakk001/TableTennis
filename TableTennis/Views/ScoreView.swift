//
//  ScoreView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct PlayerScoreView: View {
    
    @ObservedObject var scoreViewModel = ScoreViewModel.shared
    var player: Int
    
    let mark = Constants.iconPhone
    let symbols = Symbols.self
    let colors = Colors.self
    
    enum Options {
        case radius
        case opacity
        
        var value: CGFloat {
            switch self {
            case .radius:
                return 10
            case .opacity:
                return 0.7
            }
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: Options.radius.value)
                    .fill(setFillsColor(checkServer(ScoreViewModel.shared.servePlayer, player)))
                    .padding(EdgeInsets(top: -12, leading: 56, bottom: -12, trailing: 56))
                
                VStack {
                    Button {
                        ScoreViewModel.shared.plusScore(player: player)
                        ScoreViewModel.shared.session.sendMessage(["player\(player + 1)" : getPlayerScore(player)], replyHandler: nil)
                        ScoreViewModel.shared.session.sendMessage(["set\(player + 1)" : getPlayerSet(player)], replyHandler: nil)
                    } label: {
                        Image(systemName: symbols.circlePlus.name)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .opacity(Options.opacity.value)
                    }
                    
                    Text( String(format: "%02d", getPlayerScore(player)))
                        .font(.system(size: 180))
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                        .foregroundColor(.white)
                    
                    Button {
                        ScoreViewModel.shared.minusScore(player: player)
                        ScoreViewModel.shared.session.sendMessage(["player\(player + 1)" : getPlayerScore(player)], replyHandler: nil)
                        ScoreViewModel.shared.session.sendMessage([Constants.servePlayer : ScoreViewModel.shared.servePlayer], replyHandler: nil)
                    } label: {
                        Image(systemName: symbols.circleMinus.name)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .opacity(Options.opacity.value)
                    }
                }
                
                if let markView = markServer(checkServer(ScoreViewModel.shared.servePlayer, player), player) {
                    ZStack {
                        markView
                    }
                }
            }
            .padding(.bottom, 12)
        }
    }
    
    func getPlayerScore(_ player: Int) -> Int {
        if player == 0 {
            return scoreViewModel.player1
        } else {
            return scoreViewModel.player2
        }
    }
    
    func getPlayerSet(_ player: Int) -> Int {
        if player == 0 {
            return scoreViewModel.set1
        } else {
            return scoreViewModel.set2
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
        let view = ZStack {
            Image(mark)
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
        }
        
        if isServer {
            if player == 0 {
                markView = AnyView(
                    view
                    .padding(EdgeInsets(top: 200, leading: -176, bottom: 0, trailing: 0)))
            } else {
                markView = AnyView(
                    view
                        .scaleEffect(x: -1, y: 1)
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
    @State var endGame = false
    
    let symbols = Symbols.self
    let colors = Colors.self
    
    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                GameHeader()
                HStack(spacing: -28) {
                    PlayerScoreView(player: 0)
                    
                    Text(":")
                        .font(.system(size: 160))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                    
                    PlayerScoreView(player: 1)
                }
            }
            .onChange(of: ScoreViewModel.shared.set1) { newValue in
                if newValue == 3 {
                    ScoreViewModel.shared.isWin = 0
                    PageManager.shared.pageState = .resultView
                    ScoreViewModel.shared.session.sendMessage([Constants.command: Constants.resultView], replyHandler: nil)
                }
            }
            .onChange(of: ScoreViewModel.shared.set2) { newValue in
                if newValue == 3 {
                    ScoreViewModel.shared.isWin = 1
                    PageManager.shared.pageState = .resultView
                    ScoreViewModel.shared.session.sendMessage([Constants.command: Constants.resultView], replyHandler: nil)
                }
            }
        }
        .onAppear {
            ScoreViewModel.shared.endGame()
        }
        .navigationBarBackButtonHidden()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScoreView()
        }
    }
}
