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
        var to: [Int]?
    }
    let numOfVertices = Int(readLine()!)!
    var treeVertices = [Vertex](repeating: Vertex(parent: nil, to: []), count: numOfVertices)
    treeVertices[0].depth = 0
    
    for _ in 0..<numOfVertices-1 {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])!
        let vertexB = Int(edge[1])!
        treeVertices[vertexB-1].to?.append(vertexA)
        treeVertices[vertexA-1].to?.append(vertexB)
    }
    
    // set the depth of the vertices
    
    let q = Queue<Int>()
    var isVisited = [Bool](repeating: false, count: numOfVertices+1)
    q.enqueue(item: 1)
    isVisited[1] = true
    while !q.isEmpty() {
        let vertex = q.dequeue()!
        isVisited[vertex] = true
        if let connections = treeVertices[vertex-1].to {
            for i in 0..<connections.count {
                if !isVisited[connections[i]] {
                    treeVertices[connections[i]-1].parent = vertex
                    treeVertices[connections[i]-1].depth = treeVertices[vertex-1].depth! + 1
                    q.enqueue(item: connections[i])
                }
            }
        }
    }
    
    var numberOfPairs = Int(readLine()!)!
    
    while numberOfPairs > 0 {
        let edge = readLine()!.split(separator: " ")
        var vertexA = Int(edge[0])!
        var vertexB = Int(edge[1])!
        if treeVertices[vertexA-1].depth! < treeVertices[vertexB-1].depth! {
            swap(&vertexA, &vertexB)
        }
        while treeVertices[vertexA-1].depth! != treeVertices[vertexB-1].depth! {
            vertexA = treeVertices[vertexA-1].parent!
        }
        while vertexA != vertexB {
            vertexA = treeVertices[vertexA-1].parent!
            vertexB = treeVertices[vertexB-1].parent!
        }
        print(vertexA)
        numberOfPairs -= 1
    }
}
