//
//  EndView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/26.
//

import SwiftUI
import WatchKit

struct RestartView: View {
    @StateObject var pageManager = PageManager.shared
    @State private var isEnding = false
    
    var body: some View {
        HStack {
            if !pageManager.isGameEnd {
                VStack {
                    Button {
                        PageManager.shared.isGameEnd = true
                        PageManager.shared.tabState = 1
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16, alignment: .center)
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 80, height: 45)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(25)
                    Text("End")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17).weight(.medium))
                }
            }
            VStack {
                Button {
                    PageManager.shared.isGameEnd = false
                    PageManager.shared.pageState = .progressBarView
                    //PageManager.shared.tabState = 1
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                .frame(width: 80, height: 45)
                .background(Color.white.opacity(0.2))
                .cornerRadius(25)
                Text("Restart")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17).weight(.medium))
            }
        }
    }
}



struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        RestartView()
    }
}
