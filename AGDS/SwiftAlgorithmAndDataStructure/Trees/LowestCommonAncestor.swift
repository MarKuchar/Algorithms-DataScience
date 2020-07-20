//
//  LowestCommonAncestor.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-20.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

struct Vertex {
    var parent: Int?
    var children: [Int]?
}

func lowestCommonAncestor() {
    let numOfVertices = Int(readLine()!)!
    var treeVertices = [Vertex](repeating: Vertex(parent: nil, children: []), count: numOfVertices)
    treeVertices[0].parent = 0
    
    for _ in 0..<numOfVertices-1 {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])
        let vertexB = Int(edge[1])
        if let a = vertexA, let b = vertexB {
            if treeVertices[a-1].parent != nil {
                treeVertices[b-1].parent = vertexA
                treeVertices[a-1].children?.append(b)
            } else {
                treeVertices[a-1].parent = vertexB
                treeVertices[b-1].children?.append(a)
            }
        }
    }
    for i in treeVertices {
     print(i)
    }
}
