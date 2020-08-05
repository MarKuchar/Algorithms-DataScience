//
//  MinimumCostFlow.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-08-04.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

struct Pipe: Comparable, Hashable {
    let to: Int
    let cost: Int
    var isActive = false
    
    static func < (lhs: Pipe, rhs: Pipe) -> Bool {
        if lhs.cost == rhs.cost {
            if lhs.isActive {
                return true
            } else {
                return false
            }
        }
        return lhs.cost < rhs.cost
    }
}

func minimumCostFlow(_ testInput: [String]) -> Int {
    
    /// Test cases
    let header = testInput[0].split(separator: " ").map( { Int($0)! })
    let n = header[0]
    let m = header[1]
    let d = header[2]


    /// StdIn
//    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
//    let n = firstLine[0]
//    let m = firstLine[1]
//    let d = firstLine[2]

    var pipeArr = [[Pipe]](repeating: [], count: n + 1)
    var pipeQueue = IndexPriorityQueue<Pipe>(>)

    /// Test cases
    for i in 1..<testInput.count {
           let line = testInput[i].split(separator: " ").map( { Int($0)! })
           
           var pipe = Pipe(to: line[1], cost: line[2])
           var pipeB = Pipe(to: line[0], cost: line[2])
           if i < n {
               pipe.isActive = true
               pipeB.isActive = true
           }
           pipeArr[line[0]].append(pipe)
          pipeArr[line[1]].append(pipeB)

       }
    
    /// StdIn
//    for i in 0..<m {
//        let line = readLine()!.split(separator: " ").map { Int($0)! }
//        var pipe = Pipe(to: line[1], cost: line[2])
//        var pipeB = Pipe(to: line[0], cost: line[2])
//        if i < n - 1 {
//            pipe.isActive = true
//            pipeB.isActive = true
//        }
//        pipeArr[line[0]].append(pipe)
//        pipeArr[line[1]].append(pipeB)
//    }
    
    var isConnected = [Bool](repeating: false, count: n + 1)
    pipeQueue.enqueue(Pipe(to: 1, cost: 0, isActive: true))
    var days = 0
    var connected = 0
    var totalCost = 0
    
    while !pipeQueue.isEmpty {
        let b = pipeQueue.dequeue()!
        if !isConnected[b.to] {
            if !b.isActive {
                days += 1
            }
            totalCost += b.cost
            connected += 1
            isConnected[b.to] = true
            for i in pipeArr[b.to] {
                pipeQueue.enqueue(i)
            }
        }
    }
    print(days)
    return days
}

func testCases(inFile: String, outFile: String? = nil) -> Int {
    func readFile(_ path: String) -> [String] {
        var lines = [String]()
        errno = 0
        if freopen(path, "r", stdin) == nil {
            perror(path)
            return []
        }
        while let line = readLine() {
            lines.append(line)
        }
        return lines
    }
    
    let input = readFile(inFile)
    let result = minimumCostFlow(input)
    let output = readFile(outFile!)
    let answer = Int(output[0])!
    if result == answer {
        print("Success\n")
    } else {
        print("Fail (expected:\(answer) - result:\(result))\n")
    }
    return result
}
