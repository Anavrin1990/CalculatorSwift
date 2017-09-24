//
//  ViewController.swift
//  Сalculator
//
//  Created by Dmitry on 24.09.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var result: UILabel!

    @IBAction func calculate(_ sender: Any) {
        guard let text = textField.text else {return}
        if text.isCorrect() {
            result.text = Calculator.calculate(input: text)
        }
    }
}




