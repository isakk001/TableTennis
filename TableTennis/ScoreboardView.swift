//
//  ScoreboardView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/27.
//

import SwiftUI

struct ScoreboardView: View {
    @ObservedObject var viewModel = iphoneScoreModel()
    
    var body: some View {
        HStack {
            SingleBoardView(player: .player1)
            
            Text(":")
            
            SingleBoardView(player: .player2)
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
