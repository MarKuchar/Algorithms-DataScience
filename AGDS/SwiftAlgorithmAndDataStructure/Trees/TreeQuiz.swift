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
    var parents = [Int](repeating: 0, count: numberOfNodes+1)
    for _ in 0..<numberOfNodes-1 {
        let edge = readLine()!.split(separator: " ")
        let nodeA = Int(edge[0])!
        let nodeB = Int(edge[1])!
        
        parents[nodeB] = nodeA
    }
    for i in 2...numberOfNodes {
        print(parents[i])
    }
}
