//
//  ScoreView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI


struct ScoreView: View {
    
    @StateObject var viewModel = ScoreViewModel()
    @State var endGame: Bool = false
    @State var isWin: Bool = false
    
    var body: some View {
        ZStack {
            Color("BG_Primary")
                .ignoresSafeArea()
            VStack {
                GameHeader(viewModel: viewModel)
                HStack {
                    ZStack {
                        VStack {
                            Button {
                                viewModel.plusScore(player: 0)
                                viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                                viewModel.session.sendMessage(["set1" : viewModel.set1], replyHandler: nil)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .opacity(0.3)
                                    .padding()
                            }
                            Spacer()
                            Text( String(format: "%02d", viewModel.player1))
                                .font(.system(size: 150).weight(.semibold).width(.compressed))
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                viewModel.minusScore(player: 0)
                                viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                                viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.white)
                                    .opacity(0.3)
                                    .padding()
                            }
                        }
                    }
                    .frame(width: 240, height: 280)
                    .background(
                        viewModel.servePlayer == 0 ?
                        AnyView(LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Fills_Gradient_Start"),
                                Color("Fills_Gradient_Middle"),
                                Color("Fills_Gradient_End")
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        : AnyView(Color("Fills_Primary"))
                    )
                    .cornerRadius(8)
                    
                    
                    Text(":")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                    
                    ZStack {
                        VStack {
                            Button {
                                viewModel.plusScore(player: 1)
                                viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                                viewModel.session.sendMessage(["set2" : viewModel.set2], replyHandler: nil)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .opacity(0.3)
                                    .padding()
                            }
                            Spacer()
                            Text( String(format: "%02d", viewModel.player2))
                                .font(.system(size: 150).weight(.semibold).width(.compressed))
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                viewModel.minusScore(player: 1)
                                viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                                viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.white)
                                    .opacity(0.3)
                                    .padding()
                            }
                        }
                    }
                    .frame(width: 240, height: 280)
                    .background(
                        viewModel.servePlayer == 1 ?
                        AnyView(LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Fills_Gradient_Start"),
                                Color("Fills_Gradient_Middle"),
                                Color("Fills_Gradient_End")
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        : AnyView(Color("Fills_Primary"))
                    )
                    .cornerRadius(8)
                    NavigationLink(destination: PlayResultView(isWin: isWin), isActive: $endGame) {
                        EmptyView()
                    }
                }
            }
            .onChange(of: viewModel.set1) { newValue in
                if newValue == 5 {
                    endGame = true
                    isWin = true
                }
            }
            .onChange(of: viewModel.set2) { newValue in
                if newValue == 5 {
                    endGame = true
                    isWin = false
                }
            }
        }
        .onAppear {
            viewModel.endGame()
            viewModel.session.sendMessage(["servePlayer" : viewModel.servePlayer], replyHandler: nil)
        }
        .navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScoreView()
        }
    }
}
