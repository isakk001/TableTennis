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
    
    let fillColor: String = "Fills_Primary"
    let radius:CGFloat = 30
    
    enum Symbol {
        case end
        case restart
        case person
        
        var name: String {
            switch self {
            case .end:
                return "xmark"
            case .restart:
                return "arrow.counterclockwise"
            case .person:
                return "person.circle.fill"
            }
        }
    }
    
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
        HStack(spacing: -28) {
            Button(action: {
                viewModel.isWin = viewModel.checkWinner()
                pageManager.pageState = .resultView
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 44)
                        .foregroundColor(Color(fillColor))
                        .padding(.trailing, radius)
                        .cornerRadius(radius)
                    
                    Image(systemName: Symbol.end.name)
                        .foregroundColor(.red)
                        .padding(.trailing, radius)
                }
            }

            ZStack {
                Color(fillColor)
                
                HStack {
                    Label(Player.you.label, systemImage: Symbol.person.name)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("\(viewModel.set1)-\(viewModel.set2)")
                        .font(.system(size: 24).weight(.semibold).width(.compressed))
                    
                    Spacer()
                    
                    Label(Player.partner.label, systemImage: Symbol.person.name)
                        .padding(.trailing, 20)
                }
            }
            .frame(width: 500, height: 44)
            .foregroundColor(.white)
            
            Button(action: {
                viewModel.endGame()
                pageManager.pageState = .startView
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 44)
                        .foregroundColor(Color(fillColor))
                        .padding(.leading, radius)
                        .cornerRadius(radius)
                    
                    Image(systemName: Symbol.restart.name)
                        .foregroundColor(.white)
                        .padding(.trailing, -radius)
                }
            }
        }
    }
}

struct GameHeader_Previews: PreviewProvider {
    static var previews: some View {
        GameHeader(viewModel: ScoreViewModel(), pageManager: PageManager.shared)
    }
}
