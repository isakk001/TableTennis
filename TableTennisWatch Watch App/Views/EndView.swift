//
//  EndView.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/26.
//

import SwiftUI

struct EndView: View {
    
    @State private var isEnding = false
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Button {
                selectedTab = 1
            } label: {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 23, height: 23, alignment: .center)
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            }
            .background(Color.red.opacity(0.15))
            .cornerRadius(25)
            .frame(width: 72, height: 50)
            Text("End")
                .multilineTextAlignment(.center)
                .font(.system(size: 19).weight(.medium))
        }
    }
}



struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView(selectedTab: .constant(1))
    }
}
