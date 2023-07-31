//
//  CoinResultView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct CoinResultView: View {
    @ObservedObject var viewModel: ScoreViewModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text(viewModel.servePlayer == 0 ? "First Server: You" : "First Server: Partner")
                    .font(.system(size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                Image(viewModel.servePlayer == 0 ? "Coin_You" : "Coin_Partner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 10)
                Button {
               	    PageManager.shared.pageState = .scoreView
                    viewModel.session.sendMessage(["command": "ScoreView"], replyHandler: nil)
                } label: {
                    Text("Set")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .buttonStyle(TapSetButtonStyle())
            }
        }
    }
}

struct CoinResultView_Previews: PreviewProvider {
    static var previews: some View {
        CoinResultView(viewModel: ScoreViewModel())
    }
}
