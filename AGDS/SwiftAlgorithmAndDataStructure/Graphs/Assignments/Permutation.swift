//
//  Permutation.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-21.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


func findCycle() {
    let numberOfTests = Int(readLine()!)!
    let permutationSize = Int(readLine()!)!
    let permutationSet = readLine()!.split(separator: " ").map { Int($0)! }
    var adjList = [[Int]](repeating: [], count: permutationSize+1)
    
    for i in 1...numberOfTests {
        adjList[i].append(permutationSet[i-1])
        
    }
    
}
