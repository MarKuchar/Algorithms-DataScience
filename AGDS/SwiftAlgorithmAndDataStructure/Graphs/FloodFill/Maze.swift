//
//  Maze.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-08-13.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func mazePath() -> Int {
    let line = readLine()!.split(separator: " ").map( { Int($0)! })
    let vertical = line[0]
    let horisont = line[1]
    var maze = [[Int]]()
    var isVisited = [[Bool]](repeating: [Bool](repeatElement(false, count: horisont)), count: vertical)
    for _ in 0..<line[0] {
        let line = readLine()!.split(separator: " ").map( { Int($0)! })
        maze.append(line)
    }
    let h = [1, -1, 0, 0]
    let v = [0, 0, -1, 1]
    
    let q = Queue<(x: Int, y: Int)>()
    let qDepth = Queue<Int>()
    q.enqueue(item: (x: 0, y: 0))
    qDepth.enqueue(item: 1)
    var count = 1
    isVisited[0][0] = true
    
    while !q.isEmpty() {
        let square = q.dequeue()!
        let currentDepth = qDepth.dequeue()! + 1
        count += 1
        for i in 0..<4 {
            let nsx = square.x + h[i]
            let nsy = square.y + v[i]
            
            if nsx < vertical && nsy < horisont && nsx >= 0 && nsy >= 0 {
                if maze[nsx][nsy] == 1 && !isVisited[nsx][nsy] {
                    if nsx == vertical - 1 && nsy == horisont - 1 {
                        return currentDepth
                    }
                    isVisited[nsx][nsy] = true
                    q.enqueue(item: (x: nsx, y: nsy))
                    qDepth.enqueue(item: currentDepth)
                }
            }
        }
    }
    return 0
}
