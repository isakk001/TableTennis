//
//  SwiftUIView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/31.
//

import SwiftUI

struct PlayResultView: View {
    
    @State private var isWin = true
    
    var body: some View {
        VStack {
            Image(isWin ? "win" : "lose")
                .padding()
            Text(isWin ? "YOU WIN!" : "YOU LOSE!")
                .font(
                Font.custom("SF Pro", size: 24)
                .weight(.bold)
                )
        }
    }
}

struct PlayResultView_Previews: PreviewProvider {
    static var previews: some View {
        PlayResultView()
    }
}
