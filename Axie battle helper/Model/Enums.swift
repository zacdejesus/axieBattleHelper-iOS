//
//  Enums.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 20/10/2021.
//

import Foundation

enum WinValues : String , CaseIterable {
    
    case one = "1"
    case three = "3"
    case six = "6"
    case nine = "9"
    case twelve = "12"
    case fifteen = "15"
    
    func getSLPValue()-> Int {
        switch self {
        case .one:
            return 1
        case .three:
            return 3
        case .six:
            return 6
        case .nine:
            return 9
        case .twelve:
            return 12
        case .fifteen:
            return 15
        }
    }
}

enum DrawValues : String , CaseIterable {
    
    case one = "1"
    case three = "3"
    case four = "4"
    case six = "6"
    case seven = "7"
    case nine = "9"
    
    func getSLPValue()-> Int {
        switch self {
        case .one:
            return 1
        case .three:
            return 3
        case .six:
            return 6
        case .four:
            return 4
        case .seven:
            return 7
        case .nine:
            return 9
        }
    }
}

enum gameResult : String {
    case win
    case lose
    case draw
}
