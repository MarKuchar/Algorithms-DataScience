//
//  DAG+TopologicalSort.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-28.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var inDegreeList = [Int](repeating: 0, count: numCourses)
    var coursePassed = [Bool](repeating: false, count: numCourses)
    var adjList = [[Int]](repeating: [], count: numCourses)
    
    for i in prerequisites {
        adjList[i[1]].append(i[0])
        inDegreeList[i[0]] += 1
    }
    
    var queue = [Int]()
    for i in 0..<inDegreeList.count {
        if inDegreeList[i] == 0 {
            queue.append(i)
        }
    }
    
    while !queue.isEmpty {
        let p = queue.removeFirst()
        coursePassed[p] = true
        for i in adjList[p] {
            if inDegreeList[i] == 1 {
               queue.append(i)
            }
            if inDegreeList[i] >= 1 {
                inDegreeList[i] -= 1
            }
        }
    }
    for passed in coursePassed {
        if !passed {
            return false
        }
    }
    return true
}

