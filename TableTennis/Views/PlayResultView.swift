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
    
    let backgroundColor: String = "BG_Primary"
    
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
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                Image(showResult(viewModel.isWin).0)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 16)
                Text(showResult(viewModel.isWin).1)
                    .foregroundColor(.white)
                    .font(.system(size: 34).weight(.semibold))
                    .padding(.bottom, 36)
                Button(action: {
                    pageManager.pageState = .startView
                    viewModel.session.sendMessage(["command": "StartView"], replyHandler: nil)
                }) {
                    Label("Restart", systemImage: "arrow.counterclockwise")
                        .labelStyle(.titleAndIcon)
                        .font(.system(size: 17).weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 54)
                        .background(Color("Fills_Primary"))
                        .cornerRadius(30)
                }
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
