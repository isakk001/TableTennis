//
//  CoinTossView.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/28.
//

import SwiftUI

struct CoinTossView: View {
    @ObservedObject var viewModel: ScoreViewModel
    @State private var animation3d = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    @State private var isFront = true
    @State private var isTapped = true
    @State private var maxRotations = 16
    private let duration = 3.0
    private let rotationAngle = 90.0

    var body: some View {
        
                
        VStack {
            Text(isTapped ? "Let's decide \nthe first server." : "")
                .font(.system(size: 17).weight(.semibold))
                .frame(width: 150, height: 50, alignment: .topLeading)
                .padding(.leading, -30)
            Image(isFront ? "Coin_You" : "Coin_Partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .padding(50)
                .rotation3DEffect(.degrees(animation3d), axis: (x: 1.0, y: 0, z: 0))
                .scaleEffect(scaleAmount)
//                .onTapGesture {
//                    if isCoinTossing() { return }
//                    withAnimation(.linear(duration: duration / 2)) {
//                        self.scaleAmount = 3.0
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + duration / 2) {
//                        withAnimation(.linear(duration: duration / 2)) {
//                            self.scaleAmount = 1.0
//                        }
//                    }
//                    animateRotation()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//                        self.animation3d = 0.0
//                    }
//            }
            Button {
                isTapped.toggle()
                if isTapped {} else {
                    if isCoinTossing() { return }
                    withAnimation(.linear(duration: duration / 2)) {
                        self.scaleAmount = 3.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration / 2) {
                        withAnimation(.linear(duration: duration / 2)) {
                            self.scaleAmount = 1.0
                        }
                    }
                    animateRotation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        self.animation3d = 0.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            PageManager.shared.pageState = .coinResultView
                        }
                    }
                }
            } label: {
                if isTapped {
                    Text("Tap").bold()
                }
            }
            .buttonStyle(TapSetButtonStyle())
        }
        .onAppear {
            viewModel.setServePlayer()
            if viewModel.servePlayer == 0 {
                self.maxRotations = 16
            } else {
                self.maxRotations = 18
            }
        }
    }

    private func animateRotation() {
        for i in 0..<maxRotations {
            let delay = duration / Double(maxRotations) * Double(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(Animation.linear(duration: self.duration / Double(self.maxRotations))) {
                    self.animation3d = self.rotationAngle * Double(i + 1)
                    if i % 2 == 1 {
                        self.isFront.toggle()
                    }
                }
            }
        }
    }

    private func isCoinTossing() -> Bool {
        return animation3d > 0.0
    }
}

struct TapSetButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 32)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.12, green: 0.89, blue: 0.85), location: 0.00),Gradient.Stop(color: Color(red: 0.34, green: 0.52, blue: 0.91), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
            )
            .cornerRadius(30)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: -20, trailing: 0))
    }
}

struct CoinTossView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTossView(viewModel: ScoreViewModel())
    }
}
