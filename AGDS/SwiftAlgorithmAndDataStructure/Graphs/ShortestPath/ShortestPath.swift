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
        var adjList = [[(to: Int, w: Int)]](repeating: [], count: n + 1)
        var checked = [Bool](repeating: false, count: n + 1)
        for edge in flights {
            adjList[edge[0]].append((to: edge[1], w: edge[2]))
        }
        var journey = [(dist: Int, stops: Int)](repeating: (dist: Int.max, stops: 0), count: n + 1)
        journey[src] = (dist: 0, stops: 0)
        for _ in 0..<n {
            var minD = Int.max
            var minV = src
            for i in 0..<n {
                if journey[i].dist < minD && !checked[i] {
                    minV = i
                    minD = journey[i].dist
                }
            }
            checked[minV] = true
            for i in adjList[minV] {
                if journey[i.to].dist > journey[minV].dist + i.w {
                    let next = minV == src ? 0 : journey[minV].stops + 1
                    if (i.to == dst && next > K) || (i.to != dst && next + 1 > K) {
                        continue
                    }
                    journey[i.to].stops = minV == src ? 0 : journey[minV].stops + 1
                    journey[i.to].dist = journey[minV].dist + i.w
                }
            }
        }
        guard journey[dst].stops <= K else {
            return -1
        }
        guard journey[dst].dist != Int.max else {
            return -1
        }
        return journey[dst].dist
    }
}
