//
//  EndView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/26.
//

import SwiftUI
import WatchKit

struct RestartView: View {
    @StateObject var pageManager = PageManager.shared
    @ObservedObject var viewModel: ScoreViewModel
    @State private var isEnding = false
    
    enum System {
        case end
        case restart
        
        var button: (String, String) {
            switch self {
            case .end:
                return ("xmark", "End")
            case .restart:
                return ("arrow.counterclockwise", "Restart")
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            if !pageManager.isGameEnd {
                VStack {
                    Button {
                        PageManager.shared.isGameEnd = true
                        PageManager.shared.tabState = 1
                        viewModel.setRestart()
                    } label: {
                        Image(systemName: System.end.button.0)
                            .resizable()
                            .frame(width: 16, height: 16, alignment: .center)
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 80, height: 45)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(20)
                    Text(System.end.button.1)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17).weight(.medium))
                }
            }
            
            VStack {
                Button {
                    PageManager.shared.isGameEnd = false
                    PageManager.shared.pageState = .progressBarView
                    PageManager.shared.tabState = 1
                    viewModel.setRestart()
                } label: {
                    Image(systemName: System.restart.button.0)
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                .frame(width: 80, height: 45)
                .background(Color.white.opacity(0.3))
                .cornerRadius(20)
                Text(System.restart.button.1)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17).weight(.medium))
            }
        }
    }
}



struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        RestartView(viewModel: ScoreViewModel())
    }
}
