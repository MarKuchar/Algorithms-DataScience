//
//  LowestCommonAncestor.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-20.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func commonAncestor() {
    struct Vertex {
        var parent: Int?
        var depth: Int?
        var children: [Int]?
    }
    let numOfVertices = Int(readLine()!)!
    var treeVertices = [Vertex](repeating: Vertex(parent: nil, children: []), count: numOfVertices)
    treeVertices[0].parent = 0
    treeVertices[0].depth = 0
    
    for _ in 0..<numOfVertices-1 {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])!
        let vertexB = Int(edge[1])!
        if treeVertices[vertexA-1].parent != nil {
            treeVertices[vertexB-1].parent = vertexA
//            treeVertices[vertexA-1].children?.append(vertexB)
        } else {
            treeVertices[vertexA-1].parent = vertexB
//            treeVertices[vertexB-1].children?.append(vertexA)
        }
    }
    
    // set the depth of the vertices
    
    
    let numberOfPairs = Int(readLine()!)!
    
    func lowestCommonAncestor(_ nodeA: Int, _ nodeB: Int, _ treeVertices: inout [Vertex]) -> Int {
        var parent = 0
        guard let parentA = treeVertices[nodeA-1].parent else {
            return nodeA
        }
        guard let parentB = treeVertices[nodeB-1].parent else {
            return nodeB
        }
        if parentA == parentB {
            return parentA
        } else if parentA == nodeB {
            return nodeB
        } else if parentB == nodeA {
            return nodeA
        }
        if parentA > parentB {
            parent = lowestCommonAncestor(parentA, nodeB, &treeVertices)
        } else {
            parent = lowestCommonAncestor(nodeA, parentB, &treeVertices)
        }
        return parent
    }

    for _ in 0..<numberOfPairs {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])!
        let vertexB = Int(edge[1])!
        print(lowestCommonAncestor(vertexA, vertexB, &treeVertices))
    }
    print(treeVertices)
}
