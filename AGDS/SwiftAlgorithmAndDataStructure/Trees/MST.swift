//
//  MST.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 7/30/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// Minimum Spanning Tree Algorithms
public final class MST {

  /// Prim's MST Algorithm O(ElgV)
  /// Use Priority Queue (Binary Heap) and Adjacency List
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
    
    struct Edge: Comparable, Hashable {
        let to: Int
        let weight: Int
        static func < (lhs: MST.Edge, rhs: MST.Edge) -> Bool {
            return lhs.weight < rhs.weight
        }
    }
    
  public func primMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    var queue = IndexPriorityQueue<Edge>(>)
    var isVisited = [Bool](repeating: false, count: graph.count)
    
    queue.enqueue(Edge(to: 0, weight: 0))
    var count = 0
    var minCost = 0
    
    while !queue.isEmpty {
        let edge = queue.dequeue()!
        if !isVisited[edge.to] {
            let vertex = edge.to
            isVisited[vertex] = true
            minCost += edge.weight
            for v in graph[vertex] {
                if !isVisited[v.v] {
                    queue.enqueue(Edge(to: v.v, weight: v.w))
                }
            }
        }
    }
    return minCost
  }
  
  /// Kruskal's MST Algorithm O(ElgE)
  /// Use Union-Find and Adjacency List (You can use Swift's built-in sort method.)
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
  public func kruskalMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    var unionFind = UF(graph.count)
    var adjList = [(v1: Int, v2: Int, w: Int)]()
    for i in 0..<graph.count {
        for j in 0..<graph[i].count {
            adjList.append((i, graph[i][j].v, graph[i][j].w))
        }
    }
    adjList.sort(by: { $0.w < $1.w })
    
    var minCost = 0
    var connectedV = 1
    
    print(adjList)
    while connectedV != graph.count {
        let edge = adjList.removeFirst()
        if !unionFind.connected(edge.v1, edge.v2) {
            minCost += edge.w
            connectedV += 1
            unionFind.union(edge.v1, edge.v2)
        }
    }
    print(unionFind)
    return minCost
  }
}

