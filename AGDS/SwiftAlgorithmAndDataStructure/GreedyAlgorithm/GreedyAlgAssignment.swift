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

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var starts = [Int]()
    var arr = [Int]()
    for i in 0..<gas.count {
        arr.append(gas[i] - cost[i])
        if gas[i] - cost[i] >= 0 {
            starts.append(i)
        }
    }

    while !starts.isEmpty {
        var fuel = 0
        let possibleStart = starts.removeFirst()
        fuel += arr[possibleStart]
        for i in 1...gas.count {
            if (i + possibleStart) % gas.count == possibleStart {
                return possibleStart
            }
            fuel += arr[((i + possibleStart) % gas.count)]
            if fuel < 0 {
                break
            }
        }
    }
    return -1
}

func partitionLabels(_ S: String) -> [Int] {
    let charArr = Array(S)
    var stringParts = [Int]()
    var index = 0
    
    while index < charArr.count {
        var set = Set<Character>()
        set.insert(charArr[index])
        for i in index..<charArr.count {
            if set.contains(charArr[i]) {
                for j in index...i {
                    set.insert(charArr[j])
                }
                index = i + 1
            }
        }
        stringParts.append(index)
    }

    for i in (1..<stringParts.count).reversed() {
        stringParts[i] = stringParts[i] - stringParts[i - 1]
    }
    return stringParts
}
