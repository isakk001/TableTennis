//
//  ContentView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        HStack {
            VStack {
                Text(viewModel.player1.description)
                    .font(.largeTitle)
                Text(viewModel.session.isReachable ? "Reachable" : "Unreachable")
                Button {
                    viewModel.player1 += 1
                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    viewModel.player1 -= 1
                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

            }
            VStack {
                Text(viewModel.player2.description)
                    .font(.largeTitle)
                Text(viewModel.session.isReachable ? "Reachable" : "Unreachable")
                Button {
                    viewModel.player2 += 1
                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    viewModel.player2 -= 1
                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
