//
//  Extensions.swift
//  Сalculator
//
//  Created by Dmitry on 24.09.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func isCorrect() -> Bool {
        
        var operands = 2
        var brackets = 0
        var operators = 0
        var checkedOperator = true
        var hasOperators = false
        var operandTemp = ""
        
        if self == "" {
            MessageBox.showMessage(message: "Нет входных данных")
            return false
        }
        
        for i in 0..<self.characters.count {
            
            if i > 0 {
                operandTemp = self[i - 1]
            }
            
            // Проверка скобок
            if self[i] == "(" {
                brackets += 1
            }
            if self[i] == ")" {
                brackets -= 1                
            }
            
            // Проверка операторов
            if self[i].isOperator() {
                if self[i] != "(" && self[i] != ")" {
                    hasOperators = true
                    operators += 1
                    checkedOperator = false
                }
            }
            
            if !self[i].isOperator() && !self[i].isDelimeter() {
                if !checkedOperator {
                    operators -= 1
                    checkedOperator = true
                }
            }
            
            // Проверка операндов
            if self[i].isDigit() {
                if operands != 0 {
                    if !operandTemp.isDigit(){
                        operands -= 1
                    }
                }
            }
            
            if !self[i].isDigit() && !self[i].isOperator() && !self[i].isDelimeter() {
                
                if self[i] != "." && self[i] != "," {
                    MessageBox.showMessage(message: "Недопустимые символы в выражении")
                    return false
                }
            }
            
            // Проверка написания дробных чисел
            if self[i] == "." || self[i] == "," {
                
                if i + 1 <= self.characters.count - 1 {
                    
                    if self[i + 1] == "." || self[i + 1] == "," {
                        MessageBox.showMessage(message: "Проверьте написание дробных чисел")
                        return false
                    }
                } else {
                    MessageBox.showMessage(message: "Проверьте написание дробных чисел")
                    return false
                }
            }
        }
        
        if brackets != 0 {
            MessageBox.showMessage(message: "Проверьте скобки")
            return false
        }
        
        if operators != 0 {
            MessageBox.showMessage(message: "Проверьте операторы")
            return false
        }
        
        if operands != 0 {
            MessageBox.showMessage(message: "Не хватает данных для вычисления")
            return false
        }
        
        if !hasOperators {
            MessageBox.showMessage(message: "Введите оператор")
            return false
        }
        
        return true
    }
    
    // Сабскрипт для получения конкретного символа строки по указанному индексу
    subscript (i: Int) -> String {
        
        if characters.count > i && i >= 0 {
            return String(Array(self.characters)[i])
        }
        return ""
    }
    
    // Сабскрипт для получения подстроки в указанном диапазоне
    subscript (r: Range<Int>) -> String {
        
        guard r.lowerBound >= 0 && r.upperBound <= self.characters.count && r.upperBound >= r.lowerBound else
        { return "" }
        let start = self.index(startIndex, offsetBy: r.lowerBound)
        let end = self.index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }    
}

extension String {
    
    func isDigit() -> Bool {
        
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func getPriority() -> Int {
        
        switch self {
        case "+", "-": return 1
        case "*", "/": return 2
        default: return 0
        }
    }
    
    func isDelimeter() -> Bool {
        
        let delimeters = " ="
        if delimeters.contains(self) {
            return true
        }
        return false
    }
    
    func isOperator() -> Bool {
        
        let operators = "+-/*()"
        if operators.contains(self) {
            return true
        }
        return false
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
