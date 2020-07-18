//
//  TreeQuiz.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-18.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


func printParent() {
    let numberOfNodes = Int(readLine()!)!
    var hasParent = [Bool](repeating: false, count: numberOfNodes)
    hasParent[0] = true
    var parents = [Int](repeating: 0, count: numberOfNodes+1)
    for _ in 0..<numberOfNodes-1 {
        let edge = readLine()!.split(separator: " ")
        let nodeA = Int(edge[0])!
        let nodeB = Int(edge[1])!
        if hasParent[nodeA-1] {
            parents[nodeB] = nodeA
            hasParent[nodeB-1] = true
        } else {
            parents[nodeA] = nodeB
            hasParent[nodeA-1] = true
        }
    }
    for i in 2...numberOfNodes {
        print(parents[i])
    }
}


func diameter() {
    let numberOfNodes = Int(readLine()!)!
    var nodes = [[(Int, Int)]](repeating: [], count: numberOfNodes)
    
    for _ in 0...numberOfNodes-1 {
        let edges = readLine()!.split(separator: " ")
        let nodeA = Int(edges[0])!
        var i = 1
        var j = 0
        while Int(edges[i])! != -1 {
            let nodeB = Int(edges[i])!
            let distance = Int(edges[i+1])!
            let pair: (Int, Int) = (nodeB, distance)
            nodes[nodeA-1].append(pair)
            j += 1
            i += 2
        }
    }
    print(nodes)
}
