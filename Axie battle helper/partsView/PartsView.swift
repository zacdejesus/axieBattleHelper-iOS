//
//  ParstView.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 30/12/2021.
//

import UIKit

class PartsView: UIView, AxieHelperResetPartsDelegate {
    
    // MARK: - Properties
    
    
    // MARK: - @IBOutlet
    @IBOutlet var contentView: UIView!
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
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required
    init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
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
    
    
    func handlePartTapped(_ labelToChange: UILabel) {
        guard var number = Int(labelToChange.text ?? "") else { return }
        
        if number < 2 {
            number += 1
            labelToChange.text = String(number)
        }
    }
    
    private func resetThirdAxieParts() {
        thirdAxiePartOneLabel.text = "0"
        thirdAxiePartTwoLabel.text = "0"
        thirdAxiePartThreeLabel.text = "0"
        thirdAxiePartFourLabel.text = "0"
    }
    
    func setPartsReset() {
        
        DispatchQueue.main.async {
            self.resetThirdAxieParts()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.resetThirdAxieParts()
        }
        
        
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PartsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.frame.size.height = 210
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        partsViewSetup()
    }
    
    private func partsViewSetup() {
        partsView.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
        partsView2.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
        partsView3.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.75).cgColor
    }
}
