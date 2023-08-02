//
//  GameHeader.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/31.
//

import SwiftUI

struct GameHeader: View {
    @ObservedObject var viewModel: ScoreViewModel
    @ObservedObject var pageManager: PageManager
    
    let symbols = Symbols.self
    let colors = Colors.self
    let radius: CGFloat = 30
    let gap: CGFloat = 4
    
    
    enum Player {
        case you
        case partner
        
        var label: String {
            switch self {
            case .you:
                return Constants.you_iOS
            case.partner:
                return Constants.partner_iOS
            }
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(colors.fillsPrimary.name))
            
            HStack(spacing: 0) {
                Button(action: {
                    viewModel.isWin = viewModel.checkWinner()
                    pageManager.pageState = .resultView
                    viewModel.session.sendMessage([Constants.command: Constants.resultView], replyHandler: nil)
                }) {
                    ZStack {
                        Image(systemName: symbols.end.name)
                            .font(.system(size: 21))
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .padding(.horizontal, radius)
                    }
                }
                
                Divider()
                    .frame(width: gap)
                    .background(Color(colors.backgroundPrimary.name))
                
                HStack {
                    Label(Player.you.label, systemImage: symbols.person.name)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("\(viewModel.set1)-\(viewModel.set2)")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                    
                    Spacer()
                    
                    Label(Player.partner.label, systemImage: symbols.person.name)
                        .font(.system(size: 20))
                        .padding(.trailing, 20)
                }
                .foregroundColor(.white)
                
                Divider()
                    .frame(width: gap)
                    .background(Color(colors.backgroundPrimary.name))
                
                Button(action: {
                    viewModel.endGame()
                    viewModel.session.sendMessage([Constants.command: Constants.startView], replyHandler: nil)
                    pageManager.pageState = .startView
                }) {
                    ZStack {
                        Image(systemName: symbols.restart.name)
                            .font(.system(size: 21))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, radius)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
    }
}


struct GameHeader_Previews: PreviewProvider {
    static var previews: some View {
        GameHeader(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
    }
}
