//
//  CalculatorViewController.swift
//  Loginpage
//
//  Created by IE13 on 08/11/23.
//

import UIKit

final class CalculatorViewController: UIViewController {
    @IBOutlet private var resultLabel: UILabel!
    private var numberOnScreen: Double = 0
    private var previousNumber: Double = 0
    private var operation: String = "0"
    private var isPerformingOperation = false
    private var secondValueCheck = false
    private var secondValue: Double = 0
    private var dotChecked = false
    private var zeroChecked = true
    private var cancelChecked = true
    private var doublePlusChecked = true
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //    }
    @IBAction func cancelButton(_ sender: UIButton) {
        resultLabel.text = ""
        dotChecked = false
    }
    @IBAction func numberAction(_ sender: UIButton) {
        if sender.tag == 0 && resultLabel.text! == "0"{
            return
        }
        secondValueCheck = true
        if isPerformingOperation {
            isPerformingOperation = false
            resultLabel.text = String(sender.tag)
            numberOnScreen = Double(resultLabel.text!)!
        } else {
            resultLabel.text = resultLabel.text! + String(sender.tag)
            numberOnScreen = Double(resultLabel.text!)!
        }
    }
    @IBAction func plusAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        isPerformingOperation = true
        previousNumber = Double(resultLabel.text!)!
        operation = "+"
    }
    @IBAction func minusAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        isPerformingOperation = true
        previousNumber = Double(resultLabel.text!)!
        operation = "-"
    }
    @IBAction func multiplyAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        isPerformingOperation = true
        previousNumber = Double(resultLabel.text!)!
        operation = "*"
    }
    @IBAction func divideAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        isPerformingOperation = true
        previousNumber = Double(resultLabel.text!)!
        operation = "/"
    }
    @IBAction func equalToAction(_ sender: UIButton) {
        var resultValue: String = ""
        if resultLabel.text == "" {
            return
        }
        if secondValueCheck {
            secondValue = numberOnScreen
            secondValueCheck = false
        }
        if operation == "+" {
            if dotChecked {
                resultValue = String(previousNumber + secondValue)
            } else {
                resultValue = String(Int(previousNumber) + Int(secondValue))
            }
        } else if operation == "-"{
            if dotChecked {
                resultValue = String(previousNumber - secondValue)
            } else {
                // resultLabel.text = String(Int(previousNumber) - Int(secondValue))
                resultValue = String(Int(previousNumber) - Int(secondValue))
            }
        } else if operation == "*"{
            if dotChecked {
                resultValue = String(previousNumber * secondValue)
            } else {
                resultValue = String(Int(previousNumber) * Int(secondValue))
            }
        } else if operation == "/"{
            if dotChecked {
                resultValue = String(previousNumber / secondValue)
            } else {
                if  Int(previousNumber) % 2 == 1 && Int(secondValue) % 2 == 1 {
                    resultValue = String(Int(previousNumber / secondValue))
                } else if Int(previousNumber) % 2 == 1 || Int(secondValue) % 2 == 1 {
                    resultValue = String(previousNumber / secondValue)
                }
                if  Int(previousNumber) % 2 == 1 && Int(secondValue) % 2 == 1 {
                    resultValue = String(Int(previousNumber / secondValue))
                } else {
                    resultValue = String(Int(previousNumber) / Int(secondValue))
                }
            }
        }
        previousNumber = Double(resultValue)!
        if resultValue.contains(".") {
            resultLabel.text = String(floor((Double(resultValue) ?? 0.0)! * 100)/100)
        } else {
            resultLabel.text = resultValue
        }
    }
    @IBAction func plusMinusButtonAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        if dotChecked {
            resultLabel.text = String(Double(resultLabel.text ?? "")! * -1)
        } else {
            resultLabel.text = String(Int(resultLabel.text ?? "")! * -1)
        }
    }
    @IBAction func dotButtonAction(_ sender: UIButton) {
        let value = resultLabel.text ?? ""
        if !value.contains(".") {
            resultLabel.text = value + "."
            dotChecked = true
        }
    }
    @IBAction func persentageButtonAction(_ sender: UIButton) {
        if resultLabel.text == ""{
            return
        }
        resultLabel.text = String(Double(resultLabel.text!)! / 100)
    }
}
