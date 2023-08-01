//
//  SwiftUIView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct PlayResultView: View {
    
    let isWin: Int
    
    enum Result {
        case win
        case lose
        
        var detail: (String, String) {
            switch self {
            case .win:
                return ("Result_Win", "YOU WIN!")
            case .lose:
                return ("Result_Lose", "YOU LOSE!")
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(showResult(isWin).0)
                .resizable()
                .frame(width: 60, height: 60)
                .padding()
            
            Text(showResult(isWin).1)
                .font(
                    .system(size: 24)
                    .weight(.semibold)
                )
        }
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
        PlayResultView(isWin: 0)
    }
}
