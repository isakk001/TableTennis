//
//  ContentView.swift
//  TableTennis
//
//  Created by apple on 2023/07/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pageManager = PageManager.shared
    @StateObject var viewModel = ScoreViewModel()
    
    var body: some View {
        switch pageManager.pageState {
        case .startView:
            StartView(pageManager: pageManager)
        case .boardView:
            ScoreView(viewModel: viewModel, pageManager: pageManager)
        case .resultView:
            PlayResultView(pageManager: pageManager, isWin: viewModel.isWin)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
