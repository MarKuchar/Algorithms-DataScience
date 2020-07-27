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

func operatorFunction (_ leftValue: Int?, _ rightValue: Int?, _ oper: String?) -> Int? {
    if let rightValue = rightValue, let leftValue = leftValue, let oper = oper {
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
    } else if let leftValue = leftValue {
        return leftValue
    }
    return nil
}


//func evaluateExpression (_ expression: String) -> Int {
////    let operators = CharacterSet.init(charactersIn: "+-/*")
//    if expression.count == 0 {
//        return 0
//    } else if expression[0] == ")" {
//        return evaluateExpression(expression[1,expression.count])
//    } else if expression[0] == "(" {
//        if expression[1] == "(" {
//            return evaluateExpression(expression[1,expression.count])
//        } else if let valueRight = Int(expression[3]) {
//            let valueLeft = operatorFunction(Int(expression[1]), valueRight, expression[2])!
//            if let result = operatorFunction(valueLeft, evaluateExpression(expression[6,expression.count]), expression[5]) {
//                return result
//            }
//            return valueLeft
//        } else {
//            let valueLeft = evaluateExpression(expression[1])
//            let valueRight = evaluateExpression(expression[3, expression.count])
//            return operatorFunction(valueLeft, valueRight, expression[2])!
//        }
//    } else if let valueLeft = Int(expression[0]) {
//        return valueLeft
//    }
//
//    return 0
//}

