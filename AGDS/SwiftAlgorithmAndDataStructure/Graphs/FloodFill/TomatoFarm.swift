//
//  TomatoFarm.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-27.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


func numOfDays() {
    struct Square {
        let x: Int
        let y: Int
    }
    let farmSize = readLine()!.split(separator: " ").map { Int($0)! }
    let farmWidth = farmSize[0]
    let farmHeight = farmSize[1]
    var farm = [[Int]]()
    
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    for _ in 0..<farmHeight {
        farm.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    func ripeAdjc(_ square: Square) -> Int {
        let q = Queue<Square>()
        q.enqueue(item: square)
        let qAdj = Queue<Int>()
        qAdj.enqueue(item: 0)
        var duration = -1
        
        while !q.isEmpty() {
            let s = q.dequeue()!
            duration = qAdj.dequeue()!
            for i in 0...3 {
                let nx = s.x + dx[i]
                let ny = s.y + dy[i]
                if nx >= 0 && nx < farmHeight && ny >= 0 && ny < farmWidth {
                    if farm[nx][ny] == 0 {
                        q.enqueue(item: Square(x: nx, y: ny))
                        qAdj.enqueue(item: duration + 1)
                        farm[nx][ny] = 1
                    }
                }
                
            }
        }
        return duration
    }
    
    var numOfDays = 0
    
    for i in 0..<farmHeight {
        for j in 0..<farmWidth {
            if farm[i][j] == 1 {
              numOfDays += ripeAdjc(Square(x: i, y: j))
            }
        }
    }
    
    for i in 0..<farmHeight {
        for j in 0..<farmWidth {
            if farm[i][j] == 0 {
              numOfDays = -1
            }
        }
    }
    
    for i in farm {
        print(i)
    }
    print(numOfDays)
}
