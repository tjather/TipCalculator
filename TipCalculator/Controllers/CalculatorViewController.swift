//
//  ViewController.swift
//  TipCalculator
//
//  Created by Talha on 1/17/22.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipPercent = 0.10
    var numPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let tipNumber = Double(String(buttonTitle.dropLast()))
        tipPercent = tipNumber! / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%0.0f", sender.value)
        numPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
            billTotal = Double(bill)!
            
            let result = billTotal * (1 + tipPercent) / (Double(numPeople))
            finalResult = String(format: "%0.2f", result)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tipPercent * 100)
            destinationVC.split = numPeople
        }
    }
}

