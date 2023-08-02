//
//  ScoreView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI
import WatchConnectivity

struct PlayerScoreView: View {
    @ObservedObject var viewModel: ScoreViewModel
    
    var player: Int
    
    let symbols = Symbols.self
    let mark = Constants.iconWatch
    
    var body: some View {
        VStack(spacing: -4) {
            Button {
                viewModel.plusScore(player: player)
                viewModel.session.sendMessage(["set\(player + 1)" : getPlayerSet(player)], replyHandler: nil)
            } label: {
                Image(systemName: symbols.plus.name)
                    .fontWeight(.semibold)
            }
            .buttonStyle(PlusMinusButtonStyle())
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(setFillsColor(checkServer(viewModel.servePlayer, player)))
                
                Text("\(getPlayerScore(player))")
                    .font(.system(size: 70))
                    .animation(.easeInOut, value: getPlayerSet(player))
                
                if let markView = markServer(checkServer(viewModel.servePlayer, player), player) {
                    markView
                }
            }
            .padding(EdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4))
            
            Button {
                viewModel.minusScore(player: player)
            } label: {
                Image(systemName: symbols.minus.name)
                    .fontWeight(.semibold)
            }
            .buttonStyle(PlusMinusButtonStyle())
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
            markView = AnyView(
            Image(mark)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.6)
                .padding(EdgeInsets(top: 56, leading: 56, bottom: 0, trailing: 0)))
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
    
    let symbols = Symbols.self
    
    enum Player {
        case you
        case partner
        
        var label: String {
            switch self {
            case .you:
                return Constants.you_watchOS
            case .partner:
                return Constants.partner_watchOS
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                HStack(spacing: 2){
                    Text(Player.you.label)
                    
                    Image(systemName: symbols.person.name)
                }
                .font(.system(size: 13))
                
                Text("\(viewModel.set1) - \(viewModel.set2)")
                    .fontWeight(.semibold)
                
                HStack(spacing: 2) {
                    Image(systemName: symbols.person.name)
                    
                    Text(Player.partner.label)
                }
                .font(.system(size: 13))
            }
            
            HStack {
                PlayerScoreView(viewModel: viewModel, player: 0)
                
                PlayerScoreView(viewModel: viewModel, player: 1)
            }
            .padding(.bottom, -15)
            .onChange(of: viewModel.player1) { newValue in
                viewModel.session.sendMessage([Constants.player1 : viewModel.player1], replyHandler: nil)
                viewModel.session.sendMessage([Constants.servePlayer : viewModel.servePlayer], replyHandler: nil)
                WKInterfaceDevice.current().play(.notification)
            }
            .onChange(of: viewModel.player2) { newValue in
                //                        WKInterfaceDevice.current().play(.notification)
                viewModel.session.sendMessage([Constants.player2 : viewModel.player2], replyHandler: nil)
                viewModel.session.sendMessage([Constants.servePlayer : viewModel.servePlayer], replyHandler: nil)
                WKInterfaceDevice.current().play(.notification)
            }
            .onChange(of: viewModel.set1) { newValue in
                if newValue == 3 {
                    pageManager.isGameEnd = true
                }
            }
            .onChange(of: viewModel.set2) { newValue in
                if newValue == 3 {
                    pageManager.isGameEnd = true
                }
            }
        }
    }
}

struct PlusMinusButtonStyle: ButtonStyle {
    let colors = Colors.self
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            .background(Color(colors.fillsPrimary.name))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
    }
}
