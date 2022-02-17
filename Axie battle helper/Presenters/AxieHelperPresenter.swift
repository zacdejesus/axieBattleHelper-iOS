//
//  AxieHelperPresenter.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 21/10/2021.
//

import Foundation

final class AxieHelperPresenter {
    
    // MARK: - Properties
    private let slpService: SlpService
    weak private var axieHelperViewDelegate : AxieHelperViewDelegate?
    
    var slpRate = 0.0
    var totalSLP = 0
    var drawCountTotal = 0
    var loseCountTotal = 0
    var winCountTotal = 0
    var roundCount = 1
    var isUDSThidden = true
    internal var _totalEnemyEnergy = 3
    
    var totalEnemyEnergy: Int {
        get { return _totalEnemyEnergy }
        set (newVal) {
            if newVal < 11 && newVal >= 0 {
                _totalEnemyEnergy = newVal
            } else if newVal == 11 {
                _totalEnemyEnergy = 10
            }
        }
    }
    
    init(slpService: SlpService){
        self.slpService = slpService
    }
    
    func setViewDelegate(axieHelperViewDelegate: AxieHelperViewDelegate?){
        self.axieHelperViewDelegate = axieHelperViewDelegate
    }
    
    func updateUSDTBalance(_ slp: Int, slpRate: Double) -> Double {
        let usdt = slpRate * Double(slp)
        return usdt
    }
    
    func getRate() {
        slpService.fetchSlpData(success: { [weak self] (result) in
            self?.axieHelperViewDelegate?.setSLPRate(Double(result.rate))
        })
        { [weak self] () in
            self?.axieHelperViewDelegate?.hiddeUSDTLabels()
        }
    }
}
