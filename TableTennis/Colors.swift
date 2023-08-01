//
//  Colors.swift
//  TableTennis
//
//  Created by Nayeon Kim on 2023/08/01.
//

import Foundation

enum Colors {
    case backgroundPrimary
    case fillsPrimary
    case gradientStart
    case gradientMiddle
    case gradientEnd
    
    var name: String {
        switch self {
        case .backgroundPrimary:
            return "BG_Primary"
        case .fillsPrimary:
            return "Fills_Primary"
        case .gradientStart:
            return "Fills_Gradient_Start"
        case .gradientMiddle:
            return "Fills_Gradient_Middle"
        case .gradientEnd:
            return "Fills_Gradient_End"
        }
    }
}
