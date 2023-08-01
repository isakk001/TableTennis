//
//  Symbols.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/08/01.
//

import Foundation

enum Symbols {
    case person
    case plus
    case minus
    case end
    case restart
    
    var name: String {
        switch self {
        case .person:
            return "person.circle.fill"
        case .plus:
            return "plus.circle.fill"
        case .minus:
            return "minus.circle.fill"
        case .end:
            return "xmark"
        case .restart:
            return "arrow.counterclockwise"
        }
    }
}
