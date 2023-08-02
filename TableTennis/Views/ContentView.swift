//
//  ContentView.swift
//  TableTennis
//
//  Created by apple on 2023/07/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pageManager = PageManager.shared
    @StateObject var viewModel = ScoreViewModel.shared
    
    var body: some View {
        switch pageManager.pageState {
        case .startView:
            StartView()
        case .coinTossView:
            CoinTossView()
        case .coinResultView:
            CoinResultView()
        case .scoreView:
            ScoreView()
        case .resultView:
            PlayResultView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
