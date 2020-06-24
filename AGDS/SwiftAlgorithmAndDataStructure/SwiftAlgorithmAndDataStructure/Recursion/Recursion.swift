//
//  Recursion.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-06-23.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func reverseLines (_ line: Int) {
    let contents = try! String(contentsOfFile: "/Users/martin.kuchar/Development/AlgorithmsAndDataStructures/Classes/Swift-AGDS/SwiftAGDS/Recursion/story.txt")
    let lines = contents.split(separator: "\n")
    if line == lines.count {
        return
    }
    reverseLines(line + 1)
    print("\(lines[line])")
}

func operatorFunction (_ leftValue: Int?, _ rightValue: Int?, _ oper: String) -> Int? {
    if let rightValue = rightValue, let leftValue = leftValue {
        if oper == "+" {
            return leftValue + rightValue
        } else if oper == "-" {
            return leftValue - rightValue
        } else if oper == "/" {
            return leftValue / rightValue
        } else if oper == "*" {
            return leftValue * rightValue
        } else {
            return nil
        }
    }
    return nil
}

func indexHelper(_ expression: String) -> String {
    return "None"
}

func evaluateExpression (_ expression: String) -> Int {
//    let operators = CharacterSet.init(charactersIn: "+-/*")
    if expression.count == 0 {
        return 0
    }
    if let value = Int(expression) {
        return value
    } else if expression[0] == "(" {
        if let indexOpenning = expression[1, expression.count].firstIndex(of: "("), let indexClosing = expression.firstIndex(of: ")") {
            if indexOpenning < indexClosing {
                
                let substringOuter = expression[...indexOpenning]
                let evalStringOuter = String(substringOuter)
                
                let partLeft = evaluateExpression(evalStringOuter[1, evalStringOuter.count])
                if let value = operatorFunction(partLeft, evaluateExpression(expression[1, expression.count]), expression[2]) {
                    return value
                }
            }
        } else if let value = operatorFunction(evaluateExpression(expression[1, 4]), evaluateExpression(expression[6, expression.count]), expression[5]) {
            return value
        }
        return evaluateExpression(expression[1, expression.count])
    } else if let valueLeft = Int(expression[0]) {
        if let result = operatorFunction(valueLeft, evaluateExpression(expression[2, expression.count]), expression[1]) {
            return result
        }
    }

    return 0
}

