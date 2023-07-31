//
//  ScoreView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/27.
//

import SwiftUI

enum Player {
    case player1
    case player2
}

enum Symbol {
    case triangle

    var name: String {
        switch self {
        case .triangle:
            return "triangle.fill"
        }
    }
}

struct Score: View {
    
    @EnvironmentObject var viewModel: iphoneScoreModel
    
    var player: Player
    // TODO: set - score
    var maxScore: Int = 11
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Fill_Primary"))
            .overlay(
                VStack {
                    Image(systemName: Symbol.triangle.name)
                    
                    Spacer()
                    
                    ZStack {
                        Text(String(format: "%02d", checkPlayer(player)))
                            .fontWeight(.bold)
                        
                        Color.black
                            .frame(height: 3)
                    }
                    
                    Spacer()
                    
                    Image(systemName: Symbol.triangle.name)
                        .rotationEffect(.degrees(180))
                }
            )
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        updateScore(gesture)
                }
            )
    }
    
    func checkPlayer(_ player: Player) -> Int {
        if player == .player1 {
            return viewModel.player1
        } else {
            return viewModel.player2
        }
    }
    
    func updateScore(_ gesture: DragGesture.Value) {
        // TODO: onChange로 수정
        if gesture.translation.height > 0 {
            if player == .player1 {
                viewModel.player1 += 1
                viewModel.session.sendMessage(["player1": viewModel.player1], replyHandler: nil)
                print("sessionTest(iphone) : \(viewModel.player1)")
            } else {
                viewModel.player2 += 1
                viewModel.session.sendMessage(["player2": viewModel.player2], replyHandler: nil)
                print("sessionTest(iphone) : \(viewModel.player2)")
            }
        } else {
            if player == .player1 {
                viewModel.player1 -= 1
                viewModel.session.sendMessage(["player1": viewModel.player1], replyHandler: nil)
                print("sessionTest(iphone) : \(viewModel.player1)")
            } else {
                viewModel.player2 -= 1
                viewModel.session.sendMessage(["player2": viewModel.player2], replyHandler: nil)
                print("sessionTest(iphone) : \(viewModel.player2)")
            }
        }
    }
}