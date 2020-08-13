//
//  ShortestPath.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-08-06.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

class Solution {
    func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
        var adjList = [[(to: Int, w: Int)]](repeating: [], count: N + 1)
        var checked = [Bool](repeating: false, count: N + 1)
        for edge in times {
            adjList[edge[0]].append((to: edge[1], w: edge[2]))
        }
        var distance = [Int](repeating: Int.max, count: N + 1)
        distance[K] = 0
        for _ in 0..<N {
            var min = Int.max
            var minV = K
            for j in 1...N {
                if !checked[j] && distance[j] < min {
                    min = distance[j]
                    minV = j
                }
            }
            checked[minV] = true
            for e in adjList[minV] {
                if distance[e.to] > distance[minV] + e.w {
                    distance[e.to] = distance[minV] + e.w
                }
            }
        }
        var maxTime = 0
        for i in 1..<distance.count {
            if distance[i] > maxTime {
                maxTime = distance[i]
            }
            if distance[i] == Int.max {
                return -1
            }
        }
        return maxTime
    }
    
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        var adjList = [[(to: Int, w: Int)]](repeating: [(to: Int, w: Int)](), count: n + 1)
        let q = Queue<(Int, Int)>()
        var d = [[Int]](repeating: [Int](repeating: Int.max, count: K + 2), count: n + 1)
        for f in flights {
            adjList[f[0]].append((f[1], f[2]))
        }
        
        q.enqueue(item: (src, 0))
        d[src][0] = 0
        
        print(adjList)
        while let edge = q.dequeue() {
            let stepsTo = edge.1 + 1
            for e in adjList[edge.0] {
                if d[e.to][stepsTo] > d[edge.0][edge.1] + e.w {
                    d[e.to][stepsTo] = d[edge.0][edge.1] + e.w
                }
                if e.to != dst && stepsTo <= K {
                    q.enqueue(item: (e.to, stepsTo))
                }
            }
        }
        
        if let price = d[dst].min(), price < Int.max {
            return price
        } else {
            return -1
        }
    }
}


fileprivate final class Queue<E> {
    private(set) var count: Int
    fileprivate var first: Node<E>?
    fileprivate var last: Node<E>?
    init() {
        self.count = 0
        self.first = nil
        self.last = nil
    }
    public func enqueue(item: E) {
        let newNode = Node.init(item)
        if isEmpty() {
            self.first = newNode
            self.last = newNode
        } else {
            self.last!.next = newNode
            self.last = newNode
        }
        self.count += 1
    }
    public func dequeue() -> E? {
        if let node = self.first {
            self.first = node.next
            self.count -= 1
            return node.value
        }
        return nil
    }
    public func peek() -> E? {
        if let node = self.first {
            return node.value
        }
        return nil
    }
    public func isEmpty() -> Bool {
        return self.first == nil
    }
}
fileprivate class Node<T> {
    let value: T
    var next: Node<T>?
    init(_ value: T, _ next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}
