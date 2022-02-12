//
//  ViewController.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 12/10/2021.
//

import UIKit
import GoogleMobileAds

class AxieHelperViewController: UIViewController, AxieHelperViewDelegate, GADBannerViewDelegate {

    // MARK: - Properties
    private let axieHelperPresenter = AxieHelperPresenter(slpService: SlpService())
    
    weak var axieHelperResetPartsDelegate: AxieHelperResetPartsDelegate?
    
    // MARK: - @IBOutlet UILabels
    @IBOutlet weak var totalEnemyEnergyLabel: UILabel!
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var usdtBalance: UILabel!
    @IBOutlet weak var totalSLPLabel: UILabel!
    @IBOutlet weak var drawCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slpPrice: UILabel!
    
    // MARK: - @IBOutlet UIButtons
    @IBOutlet weak var endTurnButton: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    @IBOutlet weak var drawCount: UIButton!
    @IBOutlet weak var loseCount: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - @IBOutlet
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var slpCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var partsView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        axieHelperPresenter.setViewDelegate(axieHelperViewDelegate: self)
        
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        setNeedsStatusBarAppearanceUpdate()
        totalEnemyEnergyLabel.accessibilityIdentifier = "totalEnemyEnergyLabel"
        endTurnButton.accessibilityIdentifier = "endTurnButton"
        
        backgroundSetup()
        fontSetup()
        layerSetup()
        partsViewSetup()
        axieHelperPresenter.getRate()
    }
    
    @IBAction func deductEnergy(_ sender: Any) {
        axieHelperPresenter.totalEnemyEnergy -= 1
        totalEnemyEnergyLabel.text = String(axieHelperPresenter.totalEnemyEnergy)
    }
    
    @IBAction func addEnergy(_ sender: UIButton) {
        axieHelperPresenter.totalEnemyEnergy += 1
        totalEnemyEnergyLabel.text = String(axieHelperPresenter.totalEnemyEnergy)
    }
    
    @IBAction func endTurnButton(_ sender: Any) {
        handleEndTurn()
        
        DispatchQueue.main.async {
            self.totalEnemyEnergyLabel.text = String(self.axieHelperPresenter.totalEnemyEnergy)
            self.roundLabel.text = "Round \(self.axieHelperPresenter.roundCount)"
        }
    }
    
    @IBAction func clearAllButton(_ sender: Any) {
        resetEnergy()

        axieHelperPresenter.totalSLP = 0
        axieHelperPresenter.drawCountTotal = 0
        axieHelperPresenter.loseCountTotal = 0
        axieHelperPresenter.winCountTotal = 0
        
        usdtBalance.text = axieHelperPresenter.isUDSThidden ? "" : "≈ 0 USDT"
        
        loseCountLabel.text = "0"
        winCountLabel.text = "0"
        drawCountLabel.text = "0"
        totalSLPLabel.text = "0"
        roundLabel.text = AxieHelperConstants.round1
        
        
        axieHelperResetPartsDelegate?.setPartsReset()
    }
    
    @IBAction func winButton(_ sender: Any) {
        let alert = UIAlertController(title: AxieHelperConstants.pleaseSelectSLPWON, message: "", preferredStyle: .actionSheet)
        
        for winValues in WinValues.allCases {
            alert.addAction(UIAlertAction(title: winValues.rawValue, style: .default , handler:{ _ in
                self.handleSLPChange(winValues.getSLPValue(), mode: gameResult.win)
            }))
        }
        
        alert.addAction(UIAlertAction(title: AxieHelperConstants.dismiss, style: .cancel, handler: nil ))
        
        // This is to prevent crashes in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loseButton(_ sender: Any) {
        handleSLPChange(0, mode: gameResult.lose)
    }
    
    @IBAction func drawButton(_ sender: Any) {
        let alert = UIAlertController(title: AxieHelperConstants.pleaseSelectSLPWON, message: "", preferredStyle: .actionSheet)
        
        for drawValue in DrawValues.allCases {
            alert.addAction(UIAlertAction(title: drawValue.rawValue, style: .default , handler:{ _ in
                self.handleSLPChange(drawValue.getSLPValue(), mode: gameResult.draw)
            }))
        }
        
        // This is to prevent crashes in iPad
        alert.addAction(UIAlertAction(title: AxieHelperConstants.dismiss, style: .cancel, handler: nil ))
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleSLPChange(_ slp: Int, mode: gameResult) {
        
        switch mode {
        case .win:
            axieHelperPresenter.winCountTotal += 1
            winCountLabel.text = String(axieHelperPresenter.winCountTotal)
            
            axieHelperPresenter.totalSLP = slp + axieHelperPresenter.totalSLP
            totalSLPLabel.text = String(axieHelperPresenter.totalSLP)
            
            let usdtValue = String(format: "%.1f", axieHelperPresenter.updateUSDTBalance(axieHelperPresenter.totalSLP, slpRate: axieHelperPresenter.slpRate))
            usdtBalance.text = "≈ " + usdtValue + " usdt"
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        case .lose:
            axieHelperPresenter.loseCountTotal += 1
            loseCountLabel.text = String(axieHelperPresenter.loseCountTotal)
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        case .draw:

            axieHelperPresenter.drawCountTotal += 1
            drawCountLabel.text = String(axieHelperPresenter.drawCountTotal)
            
            axieHelperPresenter.totalSLP = slp + axieHelperPresenter.totalSLP
            totalSLPLabel.text = String(axieHelperPresenter.totalSLP)
            
            let usdtValue = String(format: "%.1f", axieHelperPresenter.updateUSDTBalance(axieHelperPresenter.totalSLP, slpRate: axieHelperPresenter.slpRate))
            usdtBalance.text = "≈ " + usdtValue + " usdt"
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        }
    }
    
    func handleEndTurn() {
        axieHelperPresenter.totalEnemyEnergy += 2
        axieHelperPresenter.roundCount += 1
    }
    
    internal func hiddeUSDTLabels() {
        axieHelperPresenter.isUDSThidden = true
        DispatchQueue.main.async {
            self.slpPrice.isHidden = true
            self.usdtBalance.isHidden = true
        }
    }
    
    internal func setSLPRate(_ slpRate: Double) {
        self.axieHelperPresenter.slpRate = slpRate
        axieHelperPresenter.isUDSThidden = false
        DispatchQueue.main.async {
            self.slpPrice.text = String(format: "%.3f", slpRate) + " SLP/USDT"
            self.slpCenterConstraint.constant = -15
            self.usdtBalance.text = "≈ 0 USDT"
        }
    }
    
    private func resetEnergy() {
        let alert = UIAlertController(title: "Do you want to reset?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default , handler:{ _ in
            self.axieHelperPresenter.totalEnemyEnergy = 3
            self.axieHelperPresenter.roundCount = 1
            self.totalEnemyEnergyLabel.text = "3"
        }))
    
        // This is to prevent crashes in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func backgroundSetup() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: UIDevice.current.userInterfaceIdiom == .phone ? "iphone-background" : "ipad-background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        UIGraphicsBeginImageContext(energyView.frame.size)
        UIImage(named: "energy")?.draw(in: energyView.bounds)
        let image2: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        energyView.backgroundColor = UIColor(patternImage: image2)
    }
    
    private func fontSetup() {
        endTurnButton.titleLabel?.font =  UIFont(name: AxieHelperConstants.monserratBold, size: 18)
        loseButton.titleLabel?.font =  UIFont(name: AxieHelperConstants.monserratBold, size: 16)
        winButton.titleLabel?.font =  UIFont(name: AxieHelperConstants.monserratBold, size: 16)
        drawButton.titleLabel?.font =  UIFont(name: AxieHelperConstants.monserratBold, size: 16)
        resetButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    private func layerSetup() {
        loseButton.layer.cornerRadius = 7
        winButton.layer.cornerRadius = 7
        drawButton.layer.cornerRadius = 7
        endTurnButton.layer.cornerRadius = 7
        resetButton.layer.cornerRadius = 7
    }
    
    private func partsViewSetup() {
        partsView.frame.size.height = 200
        partsView.isHidden = UIScreen.main.bounds.height < 730
    }
}


