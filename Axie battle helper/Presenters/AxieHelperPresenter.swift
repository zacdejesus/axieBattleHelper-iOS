//
//  AxieHelperPresenter.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 21/10/2021.
//

import Foundation

final class AxieHelperPresenter {
    
    private let slpService: SlpService
    weak private var axieHelperViewDelegate : AxieHelperViewDelegate?
    
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
