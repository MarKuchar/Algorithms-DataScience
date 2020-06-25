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

func indexHelper(_ expression: String) -> String {
    return "None"
}

var i = 1;

func evaluateExpression (_ expression: String, _ padding: String = "") -> Int {
//    let operators = CharacterSet.init(charactersIn: "+-/*")
    print(padding, #function)

    if expression.count == 0 {
        return 0
    } else if expression[0] == ")", expression.count == 1 {
        return 0
    } else if expression[0] == "(" {
        let valueLeft = evaluateExpression(expression[1, 2], padding + " ")
        print("Left Value:",valueLeft)
        print("Right Value:", expression[3, expression.count])
        let valueRight = evaluateExpression(expression[3, expression.count], padding + " ")
        print("Right Value:", valueRight)
        let funcOperator = expression[2]
        return operatorFunction(valueLeft, valueRight, funcOperator)!
        
    } else if let valueLeft = Int(expression[0]) {
        print(valueLeft)
        if expression.count > 1, expression[1] != ")" {
            print(valueLeft, " ", expression[1], " ", expression[2, expression.count])
            i += 2
            if let result = operatorFunction(valueLeft, evaluateExpression(expression[i-1, expression.count], padding + " "), expression[i-2]) {
                print("= ", result)
                return result
            }
        } else  {
            i += 2
            return valueLeft
        }
    }

    return 0
}

