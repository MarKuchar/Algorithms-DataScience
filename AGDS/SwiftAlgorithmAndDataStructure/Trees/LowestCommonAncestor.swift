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

func commonAncestor() {
    let numOfVertices = Int(readLine()!)!
    var treeVertices = [Vertex](repeating: Vertex(parent: nil, children: []), count: numOfVertices)
    treeVertices[0].parent = 0
    
    for _ in 0..<numOfVertices-1 {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])!
        let vertexB = Int(edge[1])!
        if treeVertices[vertexA-1].parent != nil {
            treeVertices[vertexB-1].parent = vertexA
            treeVertices[vertexA-1].children?.append(vertexB)
        } else {
            treeVertices[vertexA-1].parent = vertexB
            treeVertices[vertexB-1].children?.append(vertexA)
        }
    }
    
    let numberOfPairs = Int(readLine()!)!
//    var pairLCA = [Int]()
    
    func lowestCommonAncestor(_ vertexA: Vertex, _ vertexB: Vertex, _ treeVertices: inout [Vertex]) -> Int {
        var parent = 0
        if vertexA.parent == vertexB.parent {
            return vertexA.parent!
        } else if vertexA.parent! > vertexB.parent! {
            parent = lowestCommonAncestor(treeVertices[vertexA.parent!-1], vertexB, &treeVertices)
        } else {
            parent = lowestCommonAncestor(vertexA, treeVertices[vertexB.parent!-1], &treeVertices)
        }
        return parent
    }
    
    for _ in 0..<numberOfPairs {
        let edge = readLine()!.split(separator: " ")
        let vertexA = treeVertices[Int(edge[0])!-1]
        let vertexB = treeVertices[Int(edge[1])!-1]
//        pairLCA.append(lowestCommonAncestor(vertexA, vertexB))
        print(lowestCommonAncestor(vertexA, vertexB, &treeVertices))
    }
    
    for i in treeVertices {
     print(i)
    }
//    print(pairLCA)
}
