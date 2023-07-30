//
//  ScoreView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct ScoreView: View {
    
    @StateObject var viewModel = ScoreViewModel()
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
                        if viewModel.player1 < 11 {
                            viewModel.player1 += 1
                        } else {
                            viewModel.set1 += 0
                            viewModel.player1 = 0
                            viewModel.session.sendMessage(["set1" : viewModel.set1], replyHandler: nil)
                        }
    //                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
    //                    WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(Buttons())
                    VStack {
                        Text("L")
                            .font(.system(size: 13).width(.condensed))
                            .padding(.top, 10)
                        Text("\(viewModel.player1)")
                            .font(.system(size: 70).width(.condensed))
                            .multilineTextAlignment(.center)
                            .focusable()
//                        .digitalCrownRotation($viewModel.player1, from: 0.0, through: 11.0, by: 0.01, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: false)
                    }
                    .frame(width: 85, height: 95, alignment: .center)
                    .background(.white.opacity(0.2))
                    .cornerRadius(10)
                    Button {
                        if viewModel.player1 > 0 {
                            viewModel.player1 -= 1
                        }
    //                    viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
    //                    WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(Buttons())
                }
                VStack {
                    Button {
                        if viewModel.player2 < 11 {
                            viewModel.player2 += 1
                        } else {
                            viewModel.set2 += 1
                            viewModel.player2 = 0
                            viewModel.session.sendMessage(["set2" : viewModel.set2], replyHandler: nil)
                        }
    //                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
    //                    WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(Buttons())
                    VStack {
                        Text("R")
                            .font(.system(size: 13).width(.condensed))
                            .padding(.top, 10)
                        Text("\(viewModel.player2)")
                            .font(.system(size: 70).width(.condensed))
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 85, height: 95, alignment: .center)
                    .background(.white.opacity(0.2))
                    .cornerRadius(10)
                    Button {
                        if viewModel.player2 > 0 {
                            viewModel.player2 -= 1
                        }
    //                    viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
    //                    WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(Buttons())

                }
            }
            .padding(.bottom, -10)
            .onChange(of: viewModel.player1) { newValue in
//                if abs(newValue - lastScore) >= 1 {
//                    lastScore = newValue
                viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                print("sessionTest : \(viewModel.player1)")
                    WKInterfaceDevice.current().play(.notification)
//                }
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

struct Buttons: ButtonStyle {
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
        ScoreView()
    }
}
