//  StartView.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI
import WatchConnectivity

struct CustomButtonStyle: ButtonStyle {
    let colors = Colors.self
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 95, bottom: 15, trailing: 95))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(colors.gradientStart.name), Color(colors.gradientEnd.name)]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(30)
    }
}

struct StartView: View {
    @State private var showScoreView = false
    @ObservedObject var viewModel: ScoreViewModel
    
    let colors = Colors.self
    let buttonText = "Play"
    
    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack {
                TitleView()
                
                Button(action: {
                    self.showScoreView = true
                    PageManager.shared.pageState = .coinTossView
                    viewModel.session.sendMessage(["command": "CoinTossView"], replyHandler: nil)
                }) {
                    Text(buttonText)
                        .fontWeight(.semibold)
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
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 44)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: ScoreViewModel())
    }
}
