//
//  CoinTossView.swift
//  TableTennis
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct CoinTossView: View {
    @State private var animation3d = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    @State private var isFront = true
    @State private var maxRotations = 16
    private let duration = 3.0
    private let rotationAngle = 90.0
    
    let colors = Colors.self
    let buttonText = Constants.tossButton
    
    enum Description {
        case beforeToss
        case afterToss
        
        var text: (String, String) {
            switch self {
            case .beforeToss:
                return (Constants.tossPhrase_iOS, "")
            case .afterToss:
                return (Constants.coinYou, Constants.coinPartner)
            }
        }
    }

    var body: some View {
        ZStack {
            Color(colors.backgroundPrimary.name)
                .ignoresSafeArea()
            
            VStack {
                Text(showDescriptionBefore(isCoinTossed()))
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                Image(showDescriptionAfter(isFront))
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(.degrees(animation3d), axis: (x: 1.0, y: 0, z: 0))
                    .scaleEffect(scaleAmount)
                    .padding(.bottom, 8)
                
                Button {
                    guard isCoinTossed() == false else { return }
                    ScoreViewModel.shared.session.sendMessage([Constants.command: Constants.coinToss], replyHandler: nil)
                    startAnimation()
                } label: {
                    if isCoinTossed() == false {
                        Text(buttonText)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .buttonStyle(CustomButtonStyle())
            }
            .onAppear {
                ScoreViewModel.shared.setServePlayer()
                if ScoreViewModel.shared.servePlayer == 0 {
                    self.maxRotations = 16
                } else {
                    self.maxRotations = 18
                }
                ScoreViewModel.shared.shouldStartAnimation = false
            }
            .onReceive(ScoreViewModel.shared.$shouldStartAnimation) { newValue in
                if newValue {
                    startAnimation()
                }
            }
        }
    }

    private func isCoinTossed() -> Bool {
        return animation3d > 0.0
    }
    
    func showDescriptionBefore(_ isCoinTossed: Bool) -> String {
        if isCoinTossed {
            return Description.beforeToss.text.1
        } else {
            return Description.beforeToss.text.0
        }
    }
    
    func showDescriptionAfter(_ isFront: Bool) -> String {
        if isFront {
            return Description.afterToss.text.0
        } else {
            return Description.afterToss.text.1
        }
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
            ScoreViewModel.shared.session.sendMessage([Constants.command: Constants.coinResultView], replyHandler: nil)
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
}

struct CoinTossView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTossView()
    }
}
