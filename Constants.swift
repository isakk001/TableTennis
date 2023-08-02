//
//  Constants.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/08/02.
//

import Foundation

enum Constants {
    // Component - Button
    static let playButton = "Play"
    static let tossButton = "Toss"
    static let restartButton = "Restart"
    static let setButton = "Set"
    static let endButton = "End"

    // Component - Text
    static let youWin = "You WIN!"
    static let youLose = "YOU LOSE!"
    static let partnerWin = "Partner WIN!"
    static let titlePhrase = "Let's play Table Tennis!"
    static let firstServerYou = "First Server: You"
    static let firstServerPartner = "First Server: Partner"
    static let tossPhrase_iOS = "Let's decide the first server."
    static let tossPhrase_watchOS = "Let's decide \nthe first server."

    // Game Header
    static let you_iOS = "You"
    static let partner_iOS = "Partner"
    static let you_watchOS = "YOU"
    static let partner_watchOS = "PTR"

    // iOS <-> watchOS command
    static let command = "Command"
    static let startView = "StartView"
    static let coinTossView = "CoinTossView"
    static let coinResultView = "CoinResultView"
    static let scoreView = "ScoreView"
    static let resultView = "ResultView"
    static let coinToss = "CoinToss"
    static let player1 = "player1"
    static let player2 = "player2"
    static let servePlayer = "servePlayer"
    static let set1 = "set1"
    static let set2 = "set2"

    // Asset
    static let appLogo = "AppLogo"
    static let resultWin = "Result_Win"
    static let resultLose = "Result_Lose"
    static let coinYou = "Coin_You"
    static let coinPartner = "Coin_Partner"
    static let iconPhone = "Icon_Phone"
    static let iconWatch = "Icon_Watch"
}
