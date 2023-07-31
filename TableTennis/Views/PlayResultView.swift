//
//  PlayResultView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/31.
//

import SwiftUI
import SpriteKit

struct PlayResultView: View {
    let backgroundColor: String = "BG_Primary"
    
    let isWin: Bool
    
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
                    Image(showResult(isWin).0)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .padding()
                
                Text(showResult(isWin).1)
                    .foregroundColor(.white)
                    .font(.system(size: 40).weight(.semibold))
            }
        }
    }
    
    func showResult(_ isWin: Bool) -> (String, String) {
        if isWin {
            return Result.win.detail
        } else {
            return Result.lose.detail
        }
    }
}

struct PlayResultView_Previews: PreviewProvider {
    static var previews: some View {
        PlayResultView(isWin: false)
    }
}
