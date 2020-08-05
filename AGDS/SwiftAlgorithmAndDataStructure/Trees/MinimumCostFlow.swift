//
//  MinimumCostFlow.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-08-04.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

struct Pipe {
    let to: Int
    let cost: Int
    var isActive: Bool
}

func minimumCostFlow() {
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let n = firstLine[0]
    let m = firstLine[1]
    let d = firstLine[2]
    
    var adjList = [[Pipe]]()
    
    for i in 0..<m {
        let pipe = readLine()!.split(separator: " ").map { Int($0)! }
        
        if i < n {
            
        }
    }
}
