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

func operatorFunction (_ leftValue: Int, _ rightValue: Int, _ oper: String) -> Int? {
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

func indexHelper(_ expression: String) -> String {
    return "None"
}

func evaluateExpression (_ expression: String) -> Int {
//    let operators = CharacterSet.init(charactersIn: "+-/*")
    if let value = Int(expression) {
        return value
    } else if expression[0] == "(" {
        if let indexOpenning = expression[2, expression.count].firstIndex(of: "("), let indexClosing = expression.firstIndex(of: ")") {
            if indexOpenning < indexClosing {
                
                let substringInner = expression[indexOpenning...indexClosing]
                let evalStringInner = String(substringInner)
                
                let substringOuter = expression[...indexOpenning]
                let evalStringOuter = String(substringOuter)
                
                let partRight = evaluateExpression(evalStringInner[0, evalStringInner.count-1])
                let partLeft = evaluateExpression(evalStringOuter[1, evalStringOuter.count])
                print(evalStringInner[1, evalStringInner.count-1])
                print(expression[evalStringOuter.count])
                if let value = operatorFunction(partLeft, partRight, expression[evalStringOuter.count]) {
                    print(value)
                    return value
                }
            }
        } else if let indexClosing = expression.firstIndex(of: ")") {
            let substring = expression[...indexClosing]
            let evalString = String(substring)
            print(evalString[1, evalString.count-1])
            print(expression[evalString.count+1, expression.count])
            print(expression[evalString.count])
            let part = evaluateExpression(evalString[1, evalString.count-1])
            if let value = operatorFunction(part, evaluateExpression(expression[evalString.count+1, expression.count]), expression[evalString.count]) {
                return value
            }
        }
        return evaluateExpression(expression[1, expression.count])
    } else if let valueLeft = Int(expression[0]) {
        if let result = operatorFunction(valueLeft, evaluateExpression(expression[2, expression.count]), expression[1]) {
            return result
        }
    }

    return 0
}

