//
//  ScoreView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

struct ScoreView: View {
    
    @ObservedObject var viewModel = ScoreViewModel()

    var body: some View {
        ZStack {
            Color("BG_Primary")
                .ignoresSafeArea()
            
            VStack {                
//                Button {
//                    print("End")
//                } label: {
//                    HStack {
//                        Spacer()
//
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(Color.red.opacity(0.3))
//                            .overlay (
//                            Image(systemName: "xmark")
//                                .foregroundColor(Color.red)
//                            )
//                            .frame(width: 60, height: 40)
//                    }
//                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Fills_Primary"))
                        .overlay (
                            VStack {
                                Button {
                                    if viewModel.player1 < 11 {
                                        viewModel.player1 += 1
                                        viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                                    } else {
                                        viewModel.set1 += 1
                                        viewModel.player1 = 0
                                        viewModel.session.sendMessage(["set1" : viewModel.set1], replyHandler: nil)
                                    }
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(Color("Fills_Secondary").opacity(0.5))
                                        .padding()
                                }
                                
                                Spacer()
                                
                                Text(viewModel.player1.description)
                                    .font(.largeTitle)
                                
                                Spacer()
                                
                                Button {
                                    if viewModel.player1 > 0 {
                                        viewModel.player1 -= 1
                                        viewModel.session.sendMessage(["player1" : viewModel.player1], replyHandler: nil)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(Color("Fills_Secondary").opacity(0.5))
                                        .padding()
                                }
                                
                            }
                        )
                        .frame(width: 240, height: 280)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Fills_Primary"))
                        .overlay (
                            Text("\(viewModel.set1)")
                        )
                        .frame(width: 72, height: 280)
                    
                    Text(":")
                        .font(.system(size: 100))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Fills_Primary"))
                        .overlay (
                            Text("\(viewModel.set2)")
                        )
                        .frame(width: 72, height: 280)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Fills_Primary"))
                        .overlay (
                            VStack {
                                Button {
                                    if viewModel.player2 < 11 {
                                        viewModel.player2 += 1
                                        viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                                    } else {
                                        viewModel.set2 += 1
                                        viewModel.player2 = 0
                                        viewModel.session.sendMessage(["set2" : viewModel.set2], replyHandler: nil)
                                    }
                                    
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(Color("Fills_Secondary").opacity(0.5))
                                        .padding()
                                }
                                
                                Spacer()
                                
                                Text(viewModel.player2.description)
                                    .font(.largeTitle)
                                
                                Spacer()
                                
                                Button {
                                    if viewModel.player2 > 0 {
                                        viewModel.player2 -= 1
                                        viewModel.session.sendMessage(["player2" : viewModel.player2], replyHandler: nil)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(Color("Fills_Secondary").opacity(0.5))
                                        .padding()
                                }
                                
                            }
                        )
                        .frame(width: 240, height: 280)
                }
                
                Text("Page Controllers")
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
