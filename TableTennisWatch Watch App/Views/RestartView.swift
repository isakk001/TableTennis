//
//  EndView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/26.
//

import SwiftUI
import WatchKit

struct RestartView: View {
    @ObservedObject var viewModel: ScoreViewModel
    
    @State private var isEnding = false
    
    enum System {
        case end
        case restart
        
        var button: (String, String) {
            let symbols = Symbols.self
            switch self {
            case .end:
                return (symbols.end.name, "End")
            case .restart:
                return (symbols.restart.name, "Restart")
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            if !PageManager.shared.isGameEnd {
                VStack {
                    Button {
                        PageManager.shared.isGameEnd = true
                        PageManager.shared.tabState = 1
                        viewModel.session.sendMessage(["command": "ResultView"], replyHandler: nil)
                        viewModel.checkWinner()
                    } label: {
                            Image(systemName: System.end.button.0)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                    }
                    .buttonStyle(BorderedButtonStyle(tint: .red))
                    
                    Text(System.end.button.1)
                        .multilineTextAlignment(.center)
                }
            }
            
            VStack {
                Button {
                    PageManager.shared.isGameEnd = false
                    viewModel.session.sendMessage(["command": "StartView"], replyHandler: nil)
                    PageManager.shared.pageState = .startView
                    PageManager.shared.tabState = 1
                    viewModel.checkWinner()
                } label: {
                    Image(systemName: System.restart.button.0)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }

                Text(System.restart.button.1)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, 28)
    }
}



struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        RestartView(viewModel: ScoreViewModel())
    }
}
