//
//  CoinTossView.swift
//  TableTennisWatch Watch App
//
//  Created by 허준혁 on 2023/07/28.
//

import SwiftUI

struct CoinTossView: View {
    @State private var animation3d = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    @State private var isFront = true
    private let duration = 3.0
    private let maxRotations = 16
    private let rotationAngle = 90.0

    var body: some View {
        Image(isFront ? "coin_front" : "coin_back")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(50)
            .rotation3DEffect(.degrees(animation3d), axis: (x: 1.0, y: 0, z: 0))
            .scaleEffect(scaleAmount)
            .onTapGesture {
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

struct CoinTossView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTossView()
    }
}
