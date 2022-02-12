//
//  ParstView.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 30/12/2021.
//

import UIKit

class PartsView: UIView, AxieHelperResetPartsDelegate {

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
    
    var mainViewController: AxieHelperViewController?
    
    
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
    
    func setPartsReset() {
        firstAxiePartOneLabel.text = "0"
        firstAxiePartTwoLabel.text = "0"
        firstAxiePartThreeLabel.text = "0"
        firstAxiePartFourLabel.text = "0"
        
        secondAxiePartOneLabel.text = "0"
        secondAxiePartTwoLabel.text = "0"
        secondAxiePartThreeLabel.text = "0"
        secondtAxiePartFourLabel.text = "0"
        
        thirdAxiePartOneLabel.text = "0"
        thirdAxiePartTwoLabel.text = "0"
        thirdAxiePartThreeLabel.text = "0"
        thirdAxiePartFourLabel.text = "0"
    }
    
    func setPartsReset2() {
        firstAxiePartOneLabel.text = "0"
        firstAxiePartTwoLabel.text = "0"
        firstAxiePartThreeLabel.text = "0"
        firstAxiePartFourLabel.text = "0"
        
        secondAxiePartOneLabel.text = "0"
        secondAxiePartTwoLabel.text = "0"
        secondAxiePartThreeLabel.text = "0"
        secondtAxiePartFourLabel.text = "0"
        
        thirdAxiePartOneLabel.text = "0"
        thirdAxiePartTwoLabel.text = "0"
        thirdAxiePartThreeLabel.text = "0"
        thirdAxiePartFourLabel.text = "0"
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
