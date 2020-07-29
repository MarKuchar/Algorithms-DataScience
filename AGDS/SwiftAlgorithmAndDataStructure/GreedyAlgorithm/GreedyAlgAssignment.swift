//
//  GreedyAlgAssignment.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-29.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func twoCitySchedCost(_ costs: [[Int]]) -> Int {
    var totalCost = 0
    var difference = [Int]()
    for i in costs {
        totalCost += i[0]
        difference.append(i[1] - i[0])
    }
    difference.sort()
    for i in 0..<costs.count / 2 {
        totalCost += difference[i]
    }
    return totalCost
}


func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    var maxFreq = 0
    var maxFreqTasks = 0
    var tasksAppearance = [Int](repeating: 0, count: 26)
    for task in tasks {
        tasksAppearance[Int(task.asciiValue!) - 65] += 1
    }
    
    for task in tasksAppearance {
        if task > maxFreq {
            maxFreq = task
        }
    }
    
    for task in tasksAppearance {
        if task == maxFreq {
            maxFreqTasks += 1
        }
    }
    if (1 + n) * (maxFreq - 1) + maxFreqTasks > tasks.count {
        return (1 + n) * (maxFreq - 1) + maxFreqTasks
    } else {
        return tasks.count
    }
}
