//
//  Stack.swift
//  Сalculator
//
//  Created by Dmitry on 24.09.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation

struct Stack<Element> {
    private var array: [Element] = []
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element {
        return array.popLast()!
    }
    
    func peek() -> Element {
        return array.last!
    }
}
