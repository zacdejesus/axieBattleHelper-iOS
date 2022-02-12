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
    case five = "5"
    case six = "6"
    case eight = "8"
    case ten = "10"
    case twelve = "12"
    
    func getSLPValue() -> Int {
        switch self {
        case .one:
            return 1
        case .three:
            return 3
        case .five:
            return 5
        case .six:
            return 6
        case .eight:
            return 8
        case .ten:
            return 10
        case .twelve:
            return 12
        }
    }
}

enum DrawValues : String , CaseIterable {
    
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    
    func getSLPValue() -> Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        }
    }
}

enum gameResult : String {
    case win
    case lose
    case draw
}
