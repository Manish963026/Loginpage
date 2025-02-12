//
//  secondViewController.swift
//  EMI Calculator
//
//  Created by IE13 on 31/10/23.
//

import UIKit

class EMICalculatorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var textFieldAmount: UITextField!
    @IBOutlet private var sliderAmount: UISlider!
    @IBOutlet private var stepperAmount: UIStepper!
    @IBOutlet private var textFieldInterest: UITextField!
    @IBOutlet private var sliderInterest: UISlider!
    @IBOutlet private var stepperInterest: UIStepper!
    @IBOutlet private var textFieldTenure: UITextField!
    @IBOutlet private var sliderTenure: UISlider!
    @IBOutlet private var stepperTenure: UIStepper!
    @IBOutlet private var labelExpectedResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldAmount.delegate = self
        let doneToolbar: UIToolbar =
        UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem =
        UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        textFieldAmount.inputAccessoryView = doneToolbar
        textFieldInterest.inputAccessoryView = doneToolbar
        textFieldTenure.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction() {
        textFieldAmount.resignFirstResponder()
        textFieldInterest.resignFirstResponder()
        textFieldTenure.resignFirstResponder()
    }
    @IBAction func sliderAmount(_ sender: UISlider) {
        textFieldAmount.text = String(Int(sender.value))
        stepperAmount.value = Double(sender.value)
        calculate()
    }
    @IBAction func stepperAmount(_ sender: UIStepper) {
        textFieldAmount.text = String(Int(sender.value))
        sliderAmount.value = Float(sender.value)
        calculate()
    }
    @IBAction func sliderInterestAction(_ sender: UISlider) {
        let value = Float(Int(sender.value * 100))/100
        textFieldInterest.text = String(value)
        stepperInterest.value = Double(value)
        calculate()
    }
    @IBAction func stepperInterestAmount(_ sender: UIStepper) {
        let value = Double(Int(sender.value * 100))/100
        textFieldInterest.text = String(value)
        sliderInterest.value = Float(value)
        calculate()
    }
    @IBAction func stepperTenure(_ sender: UIStepper) {
        textFieldTenure.text = String(Int(sender.value))
        sliderTenure.value = Float(sender.value)
        calculate()
    }
    @IBAction func sliderTenureAction(_ sender: UISlider) {
        textFieldTenure.text = String(Int(sender.value))
        stepperTenure.value = Double(sender.value)
        calculate()
    }
    @IBAction func textFieldAmountFun(_ sender: UITextField) {
        if let value = sender.text {
            let temp: Int = Int(value) ?? 0
            if temp > 100000 {
                textFieldAmount.text = "100000"
            } else if temp < 10000 {
                textFieldAmount.text = "1000"
            } else {
                textFieldAmount.text = String(temp)
            }
            sliderAmount.value = Float(value) ?? 0
            stepperAmount.value = Double(value) ?? 0
            calculate()
        }
    }
    @IBAction func textFieldInterestFun(_ sender: UITextField) {
        if let value = sender.text {
            let temp: Int = Int(value) ?? 0
            if temp > 18 {
                textFieldInterest.text = "18"
            } else if temp < 6 {
                textFieldInterest.text = "06"
            }
            sliderInterest.value = Float(value) ?? 0
            stepperInterest.value = Double(value) ?? 0
            calculate()
        }
    }
    @IBAction func textFieldTenureFun(_ sender: UITextField) {
        if let value = sender.text {
            let temp: Int = Int(value) ?? 0
            if temp > 6 {
                textFieldTenure.text = "06"
            } else if temp < 1 {
                textFieldTenure.text = "01"
            }
            sliderTenure.value = Float(value) ?? 0
            stepperTenure.value = Double(value) ?? 0
            calculate()
        }
    }
    func calculate() {
        let amount = textFieldAmount.text ?? "0"
        let interest = textFieldInterest.text ?? "0"
        let tenure = textFieldTenure.text ?? "0"
        let updatedAmount: Double = Double(amount)!
        let updatedInterest: Double = Double(interest)!
        let updatedTenure: Double = Double(tenure)!
        let sum =  Int(updatedAmount * updatedInterest * updatedTenure) / 100
        labelExpectedResult.text = String(sum)
    }
}
