//
//  CoinResultView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct CoinResultView: View {
    let namespace: Namespace.ID
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
                .matchedGeometryEffect(id: "img", in: namespace)
            Button {
                PageManager.shared.pageState = .scoreView
            } label: {
                Text("Set")
                    .fontWeight(.semibold)
            }
            .buttonStyle(TapSetButtonStyle())
        }
    }
}
//
//struct CoinResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinResultView(viewModel: ScoreViewModel())
//    }
//}
