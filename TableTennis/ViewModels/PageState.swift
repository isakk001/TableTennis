//
//  PageState.swift
//  TableTennis
//
//  Created by apple on 2023/07/31.
//

import Foundation

enum PageState {
    case startView
    case coinTossView
    case coinResultView
    case scoreView
    case resultView
}

class PageManager : ObservableObject {
    static let shared = PageManager()
    private init() {}
    
    @Published var pageState: PageState = .startView
}
