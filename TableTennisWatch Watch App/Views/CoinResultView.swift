//
//  CoinResultView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct CoinResultView: View {
    @ObservedObject var viewModel: ScoreViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.servePlayer == 0 ? "First Server: \nYou" : "First Server: \nPartner")
                .font(.system(size: 17).weight(.semibold))
                .frame(width: 150, height: 50, alignment: .topLeading)
                .padding(.leading, -30)
            Image(viewModel.servePlayer == 0 ? "Coin_You" : "Coin_Partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {
                PageManager.shared.pageState = .scoreView
                // navigation
            } label: {
                Text("Set").bold()
            }
            .buttonStyle(TapSetButtonStyle()) // CoinTossView에 코드 있음
        }
    }
}

struct CoinResultView_Previews: PreviewProvider {
    static var previews: some View {
        CoinResultView(viewModel: ScoreViewModel())
    }
}
