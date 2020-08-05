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
        return lhs.cost < rhs.cost
    }
}

func minimumCostFlow() {
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let n = firstLine[0]
    let m = firstLine[1]
    let d = firstLine[2]
    
    var pipeArr = [[Pipe]](repeating: [], count: n + 1)
    var pipeQueue = IndexPriorityQueue<Pipe>(>)
    
    for i in 0..<m {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        var pipe = Pipe(to: line[1], cost: line[2])
        var pipeB = Pipe(to: line[0], cost: line[2])
        if i < n - 1 {
            pipe.isActive = true
            pipeB.isActive = true
        }
        pipeArr[line[0]].append(pipe)
        pipeArr[line[1]].append(pipeB)
    }
    
    var isConnected = [Bool](repeating: false, count: n + 1)
    pipeQueue.enqueue(Pipe(to: 1, cost: 0, isActive: true))
    var days = 0
    var connected = 0
    var totalCost = 0
    
    while connected < n {
        let b = pipeQueue.dequeue()!
        if !b.isActive {
            days += 1
        }
        totalCost += b.cost
        connected += 1
        isConnected[b.to] = true
        for i in pipeArr[b.to] {
            if !isConnected[i.to] {
                pipeQueue.enqueue(i)
            }
        }
    }
    print(totalCost)
    print(days)
}
