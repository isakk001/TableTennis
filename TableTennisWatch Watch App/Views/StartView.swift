//
//  StartView.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 75, bottom: 15, trailing: 75))
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.33725490196078434, green: 0.5215686274509804, blue: 0.9058823529411765), Color(red: 0.12156862745098039, green: 0.8862745098039215, blue: 0.8549019607843137)]), startPoint: .topTrailing, endPoint: .bottomLeading))
            .cornerRadius(30)
    }
}

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack {
                TitleView()

                NavigationLink(destination: ScoreView()) {
                    Text("Play")
                        .font(.custom("SFProText-Semibold", size: 17))
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Let's Play")
                .font(.system(size: 17))
                .foregroundColor(Color(red: 0.5568627715110779, green: 0.5568627715110779, blue: 0.5764706134796143))
            Text("Table Tennis")
                .font(.custom("SFCompactRounded-Semibold", size: 32))
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
