//
//  main.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-06-23.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


var myQueue = Queue<Int>()
myQueue.enqueue(item: 8)
myQueue.enqueue(item: 3)
myQueue.enqueue(item: 5)
myQueue.enqueue(item: 6)
myQueue.enqueue(item: 7)

print(myQueue.dequeue()!)






/// Evaluate expression lab
//print(evaluateExpression("((8+3)*(1+2))"))
//
/// *** Print decimal ***
//func printDecimal(_ n: Int, _ prefix: String) {
//    if n == 0 {
//        print(prefix)
//    } else {
//        for i in 0...9 {
//            printDecimal(n-1, prefix + "\(i)")
//        }
//    }
//}
//
/// *** Roll dice lab ***
//func rollDiceSum(n: Int, sum: Int) {
//    var choice = [Int]()
//}

//func rollDiceSumHelper(_ n: Int, _ sum: Int, _ choice: inout [Int]) {
//    if choice.count == n {
//
//    }
//}

