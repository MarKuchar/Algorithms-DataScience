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

    for _ in 0..<numberOfTests {
        let permutationSize = Int(readLine()!)!
        let permutationSet = readLine()!.split(separator: " ").map { Int($0)! }
        var adjList = [[Int]](repeating: [], count: permutationSize+1)
        for i in 1...permutationSize {
            adjList[i].append(permutationSet[i-1])
        }
        
        // DFS
        var counter = 0
        func dfs(_ currentVertex: Int, _ isVisited: inout [Bool], _ adjList: inout [[Int]], _ counter: inout Int, _ inLoopTrack: inout [Bool]) {
            isVisited[currentVertex] = true
            inLoopTrack[currentVertex] = true
            for v in adjList[currentVertex] {
                if inLoopTrack[v] {
                    counter += 1
                }
                if !isVisited[v] {
                    dfs(v, &isVisited, &adjList, &counter, &inLoopTrack)
                }
            }
        }
        
        // Find loops
        var isVisited = [Bool](repeating: false, count: permutationSize+1)
        var inLoopTrack = [Bool](repeating: false, count: permutationSize+1)
        
        for i in 1...permutationSize {
            if !isVisited[i] {
                dfs(i, &isVisited, &adjList, &counter, &inLoopTrack)
            }
        }
        print(counter)
    }
}
