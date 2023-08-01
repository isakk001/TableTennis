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
    
    let id = "img"
    let buttonText = "Set"
    
    enum Server {
        case you
        case partner
        
        var result: (String, String) {
            switch self {
            case .you:
                return ("First Server: You", "Coin_You")
            case .partner:
                return ("First Server: Partner", "Coin_Partner")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(checkServer(viewModel.servePlayer).0)
                .fontWeight(.semibold)
                .padding(.leading, -56)
            
            Image(checkServer(viewModel.servePlayer).1)
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: id, in: namespace)
                .padding(.vertical, 8)
            
            Button {
                PageManager.shared.pageState = .scoreView
                viewModel.session.sendMessage(["command": "ScoreView"], replyHandler: nil)
            } label: {
                Text(buttonText)
                    .fontWeight(.semibold)
            }
            .buttonStyle(CustomButtonStyle())
        }
    }
    
    func checkServer(_ server: Int) -> (String, String) {
        if server == 0 {
            return Server.you.result
        } else {
            return Server.partner.result
        }
    }
}
//
//struct CoinResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinResultView(viewModel: ScoreViewModel())
//    }
//}
