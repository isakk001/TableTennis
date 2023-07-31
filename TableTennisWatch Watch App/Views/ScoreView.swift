//
//  ScoreView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI
import WatchConnectivity

struct ScoreView: View {

    @ObservedObject var viewModel: ScoreViewModel
    @ObservedObject var pageManager: PageManager
//    @State var lastScore: Int = 0
    
    enum Player {
        case you
        case partner
        
        var label: String {
            switch self {
            case .you:
                return "YOU"
            case .partner:
                return "PTR"
            }
        }
    }
    
    enum Symbol {
        case person
        case plus
        case minus
        
        var name: String {
            switch self {
            case .person:
                return "person.circle.fill"
            case .plus:
                return "plus"
            case .minus:
                return "minus"
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                HStack(spacing: 2){
                    Text(Player.you.label)
                        .font(.system(size: 13))
//                        .frame(width: 50, alignment: .trailing)
                    
                    Image(systemName: Symbol.person.name)
                        .font(.system(size: 13))
                }
                
                Text("\(viewModel.set1) - \(viewModel.set2)")
                    .fontWeight(.semibold)
                
                HStack(spacing: 2) {
                    Image(systemName: Symbol.person.name)
                        .font(.system(size: 13))
                    Text(Player.partner.label)
                        .font(.system(size: 13))
//                        .frame(width: 50, alignment: .leading)
                }
            }
            HStack {
                VStack {
                    Button {
                        viewModel.plusScore(player: 0)
                        viewModel.session.sendMessage(["set1" : viewModel.set1], replyHandler: nil)
                    } label: {
                        Image(systemName: Symbol.plus.name).bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                    
                    Text("\(viewModel.player1)")
                        .font(.system(size: 70).width(.condensed))
                        .padding(.bottom, -10)
                        .frame(width: 85, height: 90)
                        .background(viewModel.servePlayer == 0
                                    ? LinearGradient(colors: [Color("Fills_Gradient_Start"), Color("Fills_Gradient_End")], startPoint: .top, endPoint: .bottom)
                                    : LinearGradient(colors: [.white.opacity(0.2)], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .animation(.easeInOut, value: viewModel.set1)
                    Button {
                        viewModel.minusScore(player: 0)
                    } label: {
                        Image(systemName: Symbol.minus.name).bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                }
                VStack {
                    Button {
                        viewModel.plusScore(player: 1)
                        viewModel.session.sendMessage(["set2" : viewModel.set2], replyHandler: nil)
                    } label: {
                        Image(systemName: Symbol.plus.name).bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                    
                    Text("\(viewModel.player2)")
                        .font(.system(size: 70).width(.condensed))
                        .padding(.bottom, -10)
                        .frame(width: 85, height: 90)
                        .background(viewModel.servePlayer == 1
                                    ? LinearGradient(colors: [Color("Fills_Gradient_Start"), Color("Fills_Gradient_End")], startPoint: .top, endPoint: .bottom)
                                    : LinearGradient(colors: [.white.opacity(0.2)], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .animation(.easeInOut, value: viewModel.set2)
                    Button {
                        viewModel.minusScore(player: 1)
                    } label: {
                        Image(systemName: Symbol.minus.name).bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                }
            }
            .padding(.bottom, -15)
            .onChange(of: viewModel.player1) { newValue in
                viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
                WKInterfaceDevice.current().play(.notification)
            }
            .onChange(of: viewModel.player2) { newValue in
                //                        WKInterfaceDevice.current().play(.notification)
                viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
                WKInterfaceDevice.current().play(.notification)
            }
            .onChange(of: viewModel.set1) { newValue in
                if newValue == 5 {
                    pageManager.isGameEnd = true
                }
            }
            .onChange(of: viewModel.set2) { newValue in
                if newValue == 5 {
                    pageManager.isGameEnd = true
                }
            }
        }
        .onAppear {
            viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
        }
    }
}

struct PlusMinusButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(width: 70, height: 13)
                .padding()
                .background(.white.opacity(0.2))
                .cornerRadius(10)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
    }
}
