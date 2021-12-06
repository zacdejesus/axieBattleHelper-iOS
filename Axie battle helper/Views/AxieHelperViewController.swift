//
//  ViewController.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 12/10/2021.
//

import UIKit
import GoogleMobileAds

protocol AxieHelperViewDelegate: NSObjectProtocol {
    func setSLPRate(_ slpRate: Double)
    func hiddeUSDTLabels()
}

final class AxieHelperViewController: UIViewController, AxieHelperViewDelegate, GADBannerViewDelegate {

    var slpRate = 0.0
    var totalEnemyEnergy = 3
    var totalSLP = 0
    var drawCountTotal = 0
    var loseCountTotal = 0
    var winCountTotal = 0
    var roundCount = 1
    var isUDSThidden = true
    
    private let axieHelperPresenter = AxieHelperPresenter(slpService: SlpService())
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var energyStepper: UIStepper!
    @IBOutlet weak var totalEnemyEnergyLabel: UILabel!
    @IBOutlet weak var slpPrice: UILabel!
    @IBOutlet weak var endTurnButton: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    @IBOutlet weak var drawCount: UIButton!
    @IBOutlet weak var loseCount: UIButton!
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var usdtBalance: UILabel!
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var totalSLPLabel: UILabel!
    @IBOutlet weak var slpCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var drawCountLabel: UILabel!
    @IBOutlet weak var loseCountLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        axieHelperPresenter.setViewDelegate(axieHelperViewDelegate: self)
        
        setNeedsStatusBarAppearanceUpdate()
        energyStepper.accessibilityIdentifier = "energyStepper"
        totalEnemyEnergyLabel.accessibilityIdentifier = "totalEnemyEnergyLabel"
        endTurnButton.accessibilityIdentifier = "endTurnButton"
        
        backgroundSetup()
        fontSetup()
        layerSetup()
        bannerSetup()
        axieHelperPresenter.getRate()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        totalEnemyEnergyLabel.text = Int(sender.value).description
        totalEnemyEnergy = Int(sender.value)
    }
    
    @IBAction func endTurnButton(_ sender: Any) {
        handleEndTurn()
        
        DispatchQueue.main.async {
            self.totalEnemyEnergyLabel.text = String(self.totalEnemyEnergy)
            self.energyStepper.value = Double(self.totalEnemyEnergy)
            self.roundLabel.text = "Round \(self.roundCount)"
        }
    }
    
    @IBAction func clearAllButton(_ sender: Any) {
        resetEnergy()

        totalSLP = 0
        drawCountTotal = 0
        loseCountTotal = 0
        winCountTotal = 0
        
        usdtBalance.text = isUDSThidden ? "" : "≈ 0 USDT"
        
        loseCountLabel.text = "0"
        winCountLabel.text = "0"
        drawCountLabel.text = "0"
        totalSLPLabel.text = "0"
        roundLabel.text = AxieHelperConstants.round1
    }
    
    @IBAction func winButton(_ sender: Any) {
        let alert = UIAlertController(title: AxieHelperConstants.pleaseSelectSLPWON, message: "", preferredStyle: .actionSheet)
        
        for winValues in WinValues.allCases {
            alert.addAction(UIAlertAction(title: winValues.rawValue, style: .default , handler:{ (UIAlertAction) in
                self.handleSLPChange(winValues.getSLPValue(), mode: gameResult.win)
            }))
        }
        
        alert.addAction(UIAlertAction(title: AxieHelperConstants.dismiss, style: .cancel, handler: nil ))
        
        // This is prevent  crashes in iPad
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
            alert.addAction(UIAlertAction(title: drawValue.rawValue, style: .default , handler:{ (UIAlertAction) in
                self.handleSLPChange(drawValue.getSLPValue(), mode: gameResult.draw)
            }))
        }
        
        alert.addAction(UIAlertAction(title: AxieHelperConstants.dismiss, style: .cancel, handler: nil ))
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleSLPChange(_ slp: Int, mode: gameResult) {
        
        switch mode {
        case .win:
            winCountTotal += 1
            winCountLabel.text = String(winCountTotal)
            
            totalSLP = slp + totalSLP
            totalSLPLabel.text = String(totalSLP)
            
            let usdtValue = String(format: "%.1f", axieHelperPresenter.updateUSDTBalance(totalSLP, slpRate: slpRate))
            usdtBalance.text = "≈ " + usdtValue + " usdt"
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        case .lose:
            loseCountTotal += 1
            loseCountLabel.text = String(loseCountTotal)
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        case .draw:

            drawCountTotal += 1
            drawCountLabel.text = String(drawCountTotal)
            
            totalSLP = slp + totalSLP
            totalSLPLabel.text = String(totalSLP)
            
            let usdtValue = String(format: "%.1f", axieHelperPresenter.updateUSDTBalance(totalSLP, slpRate: slpRate))
            usdtBalance.text = "≈ " + usdtValue + " usdt"
            
            roundLabel.text = AxieHelperConstants.round1
            
            resetEnergy()
        }
    }
    
    func handleEndTurn() {
        totalEnemyEnergy += 2
        roundCount += 1

        if totalEnemyEnergy > 10 {
            totalEnemyEnergy = 10
        }
    }
    
    internal func hiddeUSDTLabels() {
        isUDSThidden = true
        DispatchQueue.main.async {
            self.slpPrice.isHidden = true
            self.usdtBalance.isHidden = true
        }
    }
    
    internal func setSLPRate(_ slpRate: Double) {
        self.slpRate = slpRate
        isUDSThidden = false
        DispatchQueue.main.async {
            self.slpPrice.text = String(format: "%.3f", slpRate) + " SLP/USDT"
            self.slpCenterConstraint.constant = -15
            self.usdtBalance.text = "≈ 0 USDT"
        }
    }
    
    private func resetEnergy() {
        energyStepper.value = 3.0
        totalEnemyEnergy = 3
        roundCount = 1
        totalEnemyEnergyLabel.text = "3"
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
        energyStepper.layer.cornerRadius = 7
        resetButton.layer.cornerRadius = 7
        energyStepper.maximumValue = 10
        energyStepper.minimumValue = 0
        energyStepper.value = 3.0
    }
    
    private func bannerSetup() {
        bannerView.adUnitID = Bundle.main.infoDictionary?["BANNER_KEY"] as? String
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
}


