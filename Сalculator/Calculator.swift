//
//  Calculator.swift
//  Сalculator
//
//  Created by Dmitry on 24.09.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation
import UIKit

class Calculator {
    
    static func calculate(input: String) -> String {
        let rpnExpression = toRPN(input: input)
        return fromRPN(input: rpnExpression)
    }
    
    private static func toRPN(input: String) -> String {
        var input = input.replacingOccurrences(of: ",", with: ".")
        var output = ""
        var stack = Stack<String>()
        
        var i = 0
        while i < input.characters.count {
            
            if input[i].isDelimeter() {i += 1}
            
            if input[i].isDigit() {
                while !input[i].isDelimeter() && !input[i].isOperator() {
                    output += input[i]
                    i += 1
                    if i == input.characters.count {break}
                }
                output += " "
                i -= 1
            }
            
            if input[i].isOperator() {
                
                if input[i] == "(" {
                    stack.push(input[i])
                } else if input[i] == ")" {
                    var oper = stack.pop()
                    
                    while oper != "(" {
                        output += oper + " "
                        oper = stack.pop()
                    }
                } else {
                    if stack.count > 0 {
                        
                        if input[i].getPriority() <= stack.peek().getPriority() {
                            output += stack.pop() + " "
                        }
                    }
                    stack.push(input[i])
                }
            }
            i += 1
        }
        while stack.count > 0 {
            output += stack.pop() + " "
        }
        return output
    }
    
    private static func fromRPN(input: String) -> String {
        var stack = Stack<Double>()
        
        var i = 0
        while i < input.characters.count {
            
            if input[i].isDigit() {
                var number = ""
                while !input[i].isDelimeter() && !input[i].isOperator() {
                    number += input[i]
                    i += 1
                    if i == input.count {break}
                }
                
                stack.push(Double(number)!)
                i -= 1
            }
            
            if input[i].isOperator() {
                
                var result: Double = 0
                let a = stack.pop()
                let b = stack.pop()
                
                switch input[i] {
                case "+": result = b + a
                case "-": result = b - a
                case "*": result = b * a
                case "/":
                    if a != 0 {
                        result = b / a
                    } else {
                        MessageBox.showMessage(message: "Во время вычисления произошло деление на ноль")
                        return ""
                    }
                default: break
                }
                
                stack.push(result)
            }
            i += 1
        }
        return String(stack.peek())
    }
}

