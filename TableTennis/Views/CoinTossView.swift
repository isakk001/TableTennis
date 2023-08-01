//
//  CoinTossView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct CoinTossView: View {
    @ObservedObject var viewModel: ScoreViewModel
    @State private var animation3d = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    @State private var isFront = true
    @State private var maxRotations = 16
    private let duration = 3.0
    private let rotationAngle = 90.0

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text(isCoinTossed() == false ? "Let's decide the first server." : "")
                    .font(.system(size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                Image(isFront ? "Coin_You" : "Coin_Partner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotation3DEffect(.degrees(animation3d), axis: (x: 1.0, y: 0, z: 0))
                    .scaleEffect(scaleAmount)
                    .padding(.bottom, 10)
                Button {
                    guard isCoinTossed() == false else { return }
                    viewModel.session.sendMessage(["command": "CoinToss"], replyHandler: nil)
                    startAnimation()
                } label: {
                    if isCoinTossed() == false {
                        Text("Tap")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
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
                viewModel.shouldStartAnimation = false
            }
            .onReceive(viewModel.$shouldStartAnimation) { newValue in
                if newValue {
                    startAnimation()
                }
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

    private func isCoinTossed() -> Bool {
        return animation3d > 0.0
    }

    private func startAnimation() {
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

            withAnimation(.linear(duration: 0.2)) {
                PageManager.shared.pageState = .coinResultView
            }
            viewModel.session.sendMessage(["command": "CoinResultView"], replyHandler: nil)
        }
    }
}

struct TapSetButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 10, leading: 70, bottom: 10, trailing: 70))
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("Fills_Gradient_Start"),
                        Color("Fills_Gradient_Middle"),
                        Color("Fills_Gradient_End")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(30)
    }
}

struct CoinTossView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTossView(viewModel: ScoreViewModel())
    }
}
