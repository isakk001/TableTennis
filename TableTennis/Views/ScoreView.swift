//
//  ScoreView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        HStack {
            Spacer()
            Divider()
                .frame(maxWidth: 10)
                .foregroundColor(.black)
            Spacer()
        }
    }
}


struct ScoreView: View {
    
    @ObservedObject var viewModel = ScoreViewModel()

    var body: some View {
        ZStack {
            Color("BG_Primary")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                    }
                    .padding(.leading)
                    Spacer()
                    Label("You", systemImage: "person.circle.fill")
                        .font(.system(size: 16).weight(.semibold).width(.compressed))
                    Spacer()
                    Text("\(viewModel.set1)-\(viewModel.set2)")
                        .font(.system(size: 24).weight(.semibold).width(.compressed))
                    Spacer()
                    Label("Partner", systemImage: "person.circle.fill")
                        .font(.system(size: 16).weight(.semibold).width(.compressed))
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .padding(.trailing)
                }
                .foregroundColor(.white)
                .padding(12)
                .background(Color("Fills_Primary"))
                .cornerRadius(50)
                .padding(.top)
                .padding(.horizontal)
                
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
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
