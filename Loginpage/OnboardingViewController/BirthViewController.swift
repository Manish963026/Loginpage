//
//  BirthViewController.swift
//  Loginpage
//
//  Created by IE13 on 30/11/23.
//

//import UIKit
//
//class BirthViewController: UIViewController {
//    @IBOutlet weak var datetextField: UITextField!
//    let datepicker = UIDatePicker()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        datetextField.addTarget(self, action: #selector(pickDateofBirth), for: .touchDown)
//    }
//    @objc func pickDateofBirth() {
//          let toolbar = UIToolbar()
//          toolbar.sizeToFit()
//          let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClicked))
//          toolbar.items = [donebtn]
//          datetextField.inputAccessoryView = toolbar
//          datetextField.inputView = datepicker
//          datepicker.datePickerMode = .date
//      }
//    @objc func doneButtonClicked() {
//          let formatter = DateFormatter()
//          formatter.dateStyle = .medium
//          formatter.timeStyle = .none
//          datetextField.text = formatter.string(from: datepicker.date)
//          self.view.endEditing(true)
//      }
//}
