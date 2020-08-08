//
//  RepeatingSequence.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-21.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation
//
//func findRepeatingSequence() {
//    let input = readLine()!.split(separator: " ").map { String($0)}
//    var digit = input[0]
//    let power = input[1]
//    var sequence = [Int]()
//    sequence.append(Int(digit)!)
//    var numOfInSequenceE = 0
//    for _ in 0..<Int(digit)! {
//        var sum = 0
//        for i in 0..<digit.count {
//            let num = Int(pow(Double(digit[i])!, Double(power)!))
//            sum += num
//        }
//        if let start = sequence.firstIndex(of: sum) {
//            numOfInSequenceE = sequence.count - start 
//            break
//        }
//        sequence.append(sum)
//        digit = String(sum)
//    }
//    print(sequence)
//    print(sequence.count - numOfInSequenceE)
//}
