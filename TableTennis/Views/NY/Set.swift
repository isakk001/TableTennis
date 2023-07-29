//
//  SetView.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/07/27.
//

import SwiftUI

struct Set: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Fill_Primary"))
            .overlay(
                ZStack {
                    Text("0")
                        .fontWeight(.bold)
                    
                    Color.black
                        .frame(height: 3)
                }
            )
    }
}
