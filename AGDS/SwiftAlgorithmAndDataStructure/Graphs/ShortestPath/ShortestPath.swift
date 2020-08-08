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
            for j in 1..<N + 1 {
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
}
