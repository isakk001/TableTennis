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
    let radius:CGFloat = 30
    
    
    enum Player {
        case you
        case partner
        
        var label: String {
            switch self {
            case .you:
                return "You"
            case.partner:
                return "Partner"
            }
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.isWin = viewModel.checkWinner()
                pageManager.pageState = .resultView
                viewModel.session.sendMessage(["command": "ResultView"], replyHandler: nil)
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(colors.fillsPrimary.name))
                        .padding(.trailing, radius)
                        .cornerRadius(radius)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
                    
                    Image(systemName: symbols.end.name)
                        .font(.system(size: 21))
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .padding(.trailing, radius)
                        .padding(.leading, 4)
                }
                .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
            }
            
            ZStack {
                Color(colors.fillsPrimary.name)
                
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
            }
            .padding(EdgeInsets(top: 8, leading: -84, bottom: 12, trailing: -84))
            .foregroundColor(.white)
            
            Button(action: {
                viewModel.endGame()
                viewModel.session.sendMessage(["command": "StartView"], replyHandler: nil)
                pageManager.pageState = .startView
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(colors.fillsPrimary.name))
                        .padding(.leading, radius)
                        .cornerRadius(radius)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
                    
                    Image(systemName: symbols.restart.name)
                        .font(.system(size: 21))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, radius)
                        .padding(.bottom, 4)
                }
                .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
            }
        }
    }
}


struct GameHeader_Previews: PreviewProvider {
    static var previews: some View {
        GameHeader(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
    }
}
