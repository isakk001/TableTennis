//
//  TableTennisWatchApp.swift
//  TableTennisWatch Watch App
//
//  Created by Yisak on 2023/07/23.
//

import SwiftUI

@main
struct TableTennisWatch_Watch_AppApp: App {
    @State var selectedTab = 1
    
    var body: some Scene {
        WindowGroup {
            StartView()
//            TabView(selection: $selectedTab) {
//                EndView(selectedTab: $selectedTab)
//                    .tag(0)
//                ContentView()
//                    .tag(1)
//            }
//            .tabViewStyle(PageTabViewStyle())
        }
    }
}
