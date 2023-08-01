//
//  PlayResultView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/31.
//

import SwiftUI
import SpriteKit

struct PlayResultView: View {
    @ObservedObject var pageManager: PageManager
    @ObservedObject var viewModel: ScoreViewModel
    
    let colors = Colors.self
    
    enum Result {
        case win
        case lose
        
        var detail: (String, String) {
            switch self {
            case .win:
                return ("Result_Win", "You WIN!")
            case .lose:
                return ("Result_Lose", "Partner WIN!")
            }
        }
    }
    
    var symbols = Symbols.self
    let buttonText = "Restart"
    
    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack {
                Image(showResult(viewModel.isWin).0)
                    .resizable()
                    .scaledToFit()
                    .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
                    .padding(.bottom, 16)
                
                Text(showResult(viewModel.isWin).1)
                    .foregroundColor(.white)
                    .font(.system(size: 34))
                    .fontWeight(.semibold)
                    .padding(.bottom, 36)
                
                Button(action: {
                    pageManager.pageState = .startView
                    viewModel.session.sendMessage(["command": "StartView"], replyHandler: nil)
                }) {
                    Label(buttonText, systemImage: symbols.restart.name)
                        .labelStyle(.titleAndIcon)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 52)
                        .background(Color(colors.fillsPrimary.name))
                        .cornerRadius(30)
                }
                .padding(.bottom, 36)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func showResult(_ isWin: Int) -> (String, String) {
        if isWin == 0 {
            return Result.win.detail
        } else {
            return Result.lose.detail
        }
    }
}

struct PlayResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlayResultView(pageManager: PageManager.shared, viewModel: ScoreViewModel())
        }
    }
}
