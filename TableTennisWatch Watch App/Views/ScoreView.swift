//
//  ScoreView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI
import WatchConnectivity

struct ScoreView: View {

    @ObservedObject var viewModel: ScoreViewModel
//    @State var lastScore: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("\(viewModel.set1) - \(viewModel.set2)")
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            HStack {
                VStack {
                    Button {
                        viewModel.plusScore(player: 0)
                        viewModel.session.sendMessage(["set1" : viewModel.set1], replyHandler: nil)
                    } label: {
                        Image(systemName: "plus").bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                    
                    Text("\(viewModel.player1)")
                        .font(.system(size: 70).width(.condensed))
                        .padding(.bottom, -10)
                        .frame(width: 85, height: 90)
                        .background(viewModel.servePlayer == 0 ? Color("Fills_Gradient_End") : .white.opacity(0.2))
                        .cornerRadius(10)
                        .animation(.easeInOut, value: viewModel.set1)
                    Button {
                        viewModel.minusScore(player: 0)
                    } label: {
                        Image(systemName: "minus").bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                }
                VStack {
                    Button {
                        viewModel.plusScore(player: 1)
                        viewModel.session.sendMessage(["set2" : viewModel.set2], replyHandler: nil)
                    } label: {
                        Image(systemName: "plus").bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                    
                    Text("\(viewModel.player2)")
                        .font(.system(size: 70).width(.condensed))
                        .padding(.bottom, -10)
                        .frame(width: 85, height: 90)
                        .background(viewModel.servePlayer == 1 ? Color("Fills_Gradient_End") : .white.opacity(0.2))
                        .cornerRadius(10)
                        .animation(.easeInOut, value: viewModel.set2)
                    Button {
                        viewModel.minusScore(player: 1)
                    } label: {
                        Image(systemName: "minus").bold()
                    }
                    .buttonStyle(PlusMinusButtonStyle())
                }
            }
            .padding(.bottom, -15)
            .onChange(of: viewModel.player1) { newValue in
                viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                print("sessionTest : \(viewModel.player1)")
                    WKInterfaceDevice.current().play(.notification)
            }
            .onChange(of: viewModel.player2) { newValue in
                //                        WKInterfaceDevice.current().play(.notification)
                viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                print("sessionTest : \(viewModel.player2)")
                WKInterfaceDevice.current().play(.notification)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct PlusMinusButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(width: 70, height: 15)
                .padding()
                .background(.white.opacity(0.2))
                .cornerRadius(10)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(viewModel: ScoreViewModel())
    }
}
