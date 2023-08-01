//  StartView.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI
import WatchConnectivity

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 95, bottom: 15, trailing: 95))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("Fills_Gradient_Start"), Color("Fills_Gradient_End")]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(30)
    }
}

struct StartView: View {
    @State private var showScoreView = false
    @ObservedObject var viewModel: ScoreViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                TitleView()
                
                Button(action: {
                    self.showScoreView = true
                    PageManager.shared.pageState = .coinTossView
                    viewModel.session.sendMessage(["command": "CoinTossView"], replyHandler: nil)
                }) {
                    Text("Play")
                        .font(.system(size: 17).weight(.semibold))
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
    }
}

struct TitleView: View {
    let logo = "AppLogo"
    let phrase = "Let's play Table Tennis!"
    
    var body: some View {
        VStack {
            Image(logo)
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 200, bottom: -5, trailing: 200))
            
            Text(phrase)
                .font(.system(size: 25).weight(.semibold))
                .foregroundColor(Color(.gray))
        }
        .padding(.vertical, 45)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: ScoreViewModel())
    }
}
