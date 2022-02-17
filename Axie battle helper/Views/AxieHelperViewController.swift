//
//  ViewController.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 12/10/2021.
//

import UIKit
import GoogleMobileAds

class AxieHelperViewController: UIViewController, AxieHelperViewDelegate {
    
    // MARK: - Properties
    private let axieHelperPresenter = AxieHelperPresenter(slpService: SlpService())
    
    var axieHelperResetPartsDelegate: AxieHelperResetPartsDelegate?
    
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
    @IBOutlet weak var partsViewContainer: UIView!
    
    // MARK: - @IBOutlet TO BE move in the next release
    
    @IBOutlet weak var partsView: UIView!
    @IBOutlet weak var partsView2: UIView!
    @IBOutlet weak var partsView3: UIView!
    
    @IBOutlet weak var firstAxiePartOneLabel: UILabel!
    @IBOutlet weak var firstAxiePartTwoLabel: UILabel!
    @IBOutlet weak var firstAxiePartThreeLabel: UILabel!
    @IBOutlet weak var firstAxiePartFourLabel: UILabel!
    
    @IBOutlet weak var secondAxiePartOneLabel: UILabel!
    @IBOutlet weak var secondAxiePartTwoLabel: UILabel!
    @IBOutlet weak var secondAxiePartThreeLabel: UILabel!
    @IBOutlet weak var secondtAxiePartFourLabel: UILabel!
    
    @IBOutlet weak var thirdAxiePartOneLabel: UILabel!
    @IBOutlet weak var thirdAxiePartTwoLabel: UILabel!
    @IBOutlet weak var thirdAxiePartThreeLabel: UILabel!
    @IBOutlet weak var thirdAxiePartFourLabel: UILabel!
    
    @IBAction func firstAxiePartOne(_ sender: UIButton) {
        handlePartTapped(firstAxiePartOneLabel)
    }
    
    @IBAction func firstAxiePartTwo(_ sender: UIButton) {
        handlePartTapped(firstAxiePartTwoLabel)
    }
    
    @IBAction func firstAxiePartThree(_ sender: UIButton) {
        handlePartTapped(firstAxiePartThreeLabel)
    }
    
    @IBAction func firstAxiePartFour(_ sender: UIButton) {
        handlePartTapped(firstAxiePartFourLabel)
    }
    
    @IBAction func secondAxiePartOne(_ sender: UIButton) {
        handlePartTapped(secondAxiePartOneLabel)
    }
    
    @IBAction func secondAxiePartTwo(_ sender: UIButton) {
        handlePartTapped(secondAxiePartTwoLabel)
    }
    
    @IBAction func secondAxiePartThree(_ sender: UIButton) {
        handlePartTapped(secondAxiePartThreeLabel)
    }
    
    @IBAction func secondAxiePartFour(_ sender: UIButton) {
        handlePartTapped(secondtAxiePartFourLabel)
    }
    
    @IBAction func thirdAxiePartOne(_ sender: UIButton) {
        handlePartTapped(thirdAxiePartOneLabel)
    }
    
    @IBAction func thirdAxiePartTwoLabel(_ sender: UIButton) {
        handlePartTapped(thirdAxiePartTwoLabel)
    }
    
    @IBAction func thirdAxiePartThree(_ sender: UIButton) {
        handlePartTapped(thirdAxiePartThreeLabel)
    }
    
    @IBAction func thirdAxiePartFour(_ sender: UIButton) {
        handlePartTapped(thirdAxiePartFourLabel)
    }
    
    @IBAction func resetThirdAxieParts(_ sender: UIButton) {
        resetThirdAxieParts()
    }
    
    @IBAction func resetSecondAxieParts(_ sender: UIButton) {
        resetSecondAxieParts()
    }
    
    @IBAction func resetFirstAxieParts(_ sender: UIButton) {
        resetFirstAxieParts()
    }
    
    func resetAllParts() {
        resetFirstAxieParts()
        resetSecondAxieParts()
        resetThirdAxieParts()
    }
    
    private func resetFirstAxieParts() {
        firstAxiePartOneLabel.text = "0"
        firstAxiePartTwoLabel.text = "0"
        firstAxiePartThreeLabel.text = "0"
        firstAxiePartFourLabel.text = "0"
    }
    
    private func resetSecondAxieParts() {
        secondAxiePartOneLabel.text = "0"
        secondAxiePartTwoLabel.text = "0"
        secondAxiePartThreeLabel.text = "0"
        secondtAxiePartFourLabel.text = "0"
    }
    
    private func resetThirdAxieParts() {
        thirdAxiePartOneLabel.text = "0"
        thirdAxiePartTwoLabel.text = "0"
        thirdAxiePartThreeLabel.text = "0"
        thirdAxiePartFourLabel.text = "0"
    }
    
    private func handlePartTapped(_ labelToChange: UILabel) {
        guard var number = Int(labelToChange.text ?? "") else { return }
        
        if number < 2 {
            number += 1
            labelToChange.text = String(number)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        axieHelperPresenter.setViewDelegate(axieHelperViewDelegate: self)
        
        //bannerView.delegate = self
       // bannerView.adUnitID = Bundle.main.infoDictionary?["BANNER_KEY"] as? String
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
        let alert = UIAlertController(title: "Do you want to reset?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default , handler:{ _ in
            
            self.resetEnergy()
            
            self.resetAllParts()
            
            self.axieHelperPresenter.totalSLP = 0
            self.axieHelperPresenter.drawCountTotal = 0
            self.axieHelperPresenter.loseCountTotal = 0
            self.axieHelperPresenter.winCountTotal = 0
            
            self.usdtBalance.text = self.axieHelperPresenter.isUDSThidden ? "" : "≈ 0 USDT"
            
            self.loseCountLabel.text = "0"
            self.winCountLabel.text = "0"
            self.drawCountLabel.text = "0"
            self.totalSLPLabel.text = "0"
            self.roundLabel.text = AxieHelperConstants.round1
        }))
        
        // This is to prevent crashes in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        self.present(alert, animated: true, completion: nil)
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
        
        resetAllParts()
        
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
        self.axieHelperPresenter.totalEnemyEnergy = 3
        self.axieHelperPresenter.roundCount = 1
        self.totalEnemyEnergyLabel.text = "3"
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
        
        // TODO: to be delete in the future
        partsView.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
        partsView2.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
        partsView3.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
    }
    
    private func partsViewSetup() {
        partsViewContainer.frame.size.height = 200
        partsViewContainer.isHidden = UIScreen.main.bounds.height < 730
    }
}
