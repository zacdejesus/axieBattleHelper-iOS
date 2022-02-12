//
//  AxieHelperViewDelegate.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 10/02/2022.
//

import Foundation

protocol AxieHelperViewDelegate: NSObjectProtocol {
    func setSLPRate(_ slpRate: Double)
    func hiddeUSDTLabels()
}

protocol AxieHelperResetPartsDelegate: NSObjectProtocol {
    func setPartsReset()
}
