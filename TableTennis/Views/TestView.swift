//
//  TestView.swift
//  TableTennis
//
//  Created by 허준혁 on 2023/07/29.
//

import SwiftUI

struct AvailableFontsView: View {
    var body: some View {
        List(UIFont.familyNames.sorted(), id: \.self) { familyName in
            VStack(alignment: .leading) {
                Text(familyName)
                    .font(.headline)
                ForEach(UIFont.fontNames(forFamilyName: familyName), id: \.self) { fontName in
                    Text(fontName)
                        .font(Font.custom(fontName, size: 17))
                }
            }
        }
    }
}

struct AvailableFontsView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableFontsView()
    }
}
