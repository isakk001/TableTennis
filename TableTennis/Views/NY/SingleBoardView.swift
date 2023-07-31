//
//  SingleBoardView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/27.
//

import SwiftUI

struct SingleBoardView: View {
    
    @StateObject var viewModel = iphoneScoreModel()
    
    @State var isDownward: Bool = false
    @State var isUpward: Bool = false
    
//    var playerScore: Int
    var player: Player
    
    var body: some View {
        if player == .player1 {
            HStack {
                ZStack {
                    Score(player: .player1)
                        .environmentObject(viewModel)
//                    Score(player: .player1)
                    
                    Color.black
                        .frame(height: 1)
                }
                
                Set()
            }
        } else {
            HStack {
                Set()
                ZStack {
                    Score(player: .player2)
                        .environmentObject(viewModel)
//                    Score(player: .player2)
                }
            }
        }
    }
}


struct SingleBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleBoardView(player: Player.player1)
    }
}