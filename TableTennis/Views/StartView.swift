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
    @State private var showCoinView = false
    @ObservedObject var pageManager: PageManager
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                TitleView()
                Button(action: {
                    self.showCoinView = true
                    pageManager.pageState = .coinTossView
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
    var body: some View {
        VStack {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 200, bottom: -5, trailing: 200))
            Text("Let's play Table Tennis!")
                .font(.system(size: 25).weight(.semibold))
                .foregroundColor(Color(.gray))
        }
        .padding(.vertical, 45)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(pageManager: PageManager.shared)
    }
}
