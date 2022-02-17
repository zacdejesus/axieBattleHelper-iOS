//
//  AxiePartsViewController.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 12/02/2022.
//

import UIKit

class AxiePartsViewController: UIViewController {

    
    // MARK: - Properties
    
    
    // MARK: - @IBOutlet
    @IBOutlet weak var partsView: UIView!
    @IBOutlet weak var partsView2: UIView!
    @IBOutlet weak var partsView3: UIView!
    
    @IBOutlet weak var prueba2: UILabel!
    @IBOutlet weak var prueba: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func firstAxiePartOne(_ sender: UIButton) {
        firstAxiePartOneLabel.text = "holis"
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
    
    @IBAction func resetFirstAxieParts(_ sender: UIButton) {
        resetFirstAxieParts()
    }
    
    @IBAction func resetSecondAxieParts(_ sender: UIButton) {
        resetSecondAxieParts()
    }
    
    @IBAction func resetThirdAxieParts(_ sender: UIButton) {
        resetThirdAxieParts()
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
}
