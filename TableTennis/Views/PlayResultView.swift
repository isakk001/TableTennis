//
//  PlayResultView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/31.
//

import SwiftUI
import SpriteKit

struct PlayResultView: View {
    let colors = Colors.self
    let radius: CGFloat = 30
    
    enum Result {
        case win
        case lose
        
        var detail: (String, String) {
            switch self {
            case .win:
                return (Constants.resultWin, Constants.youWin)
            case .lose:
                return (Constants.resultLose, Constants.partnerWin)
            }
        }
    }
    
    var symbols = Symbols.self
    let buttonText = Constants.restartButton
    
    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack {
                Image(showResult(ScoreViewModel.shared.isWin).0)
                    .resizable()
                    .scaledToFit()
                    .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
                
                Text(showResult(ScoreViewModel.shared.isWin).1)
                    .foregroundColor(.white)
                    .font(.system(size: 34))
                    .fontWeight(.semibold)
                    .padding(.bottom, 28)
                
                Button(action: {
                    PageManager.shared.pageState = .startView
                    ScoreViewModel.shared.session.sendMessage([Constants.command: Constants.startView], replyHandler: nil)
                }) {
                    Label(buttonText, systemImage: symbols.restart.name)
                        .labelStyle(.titleAndIcon)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 48)
                        .background(Color(colors.fillsPrimary.name))
                        .cornerRadius(radius)
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
            PlayResultView()
        }
    }
}
