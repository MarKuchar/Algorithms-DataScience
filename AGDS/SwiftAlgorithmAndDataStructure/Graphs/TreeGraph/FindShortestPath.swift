//
//  FindShortestPath.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-22.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation



func findShortestPath() {
    struct Restaurant {
        var pathTo: Int
        var depht: Int
    }
    let allRestaurant = readLine()!.split(separator: " ").map { Int($0)! }
    let numOfAllRest = allRestaurant[0]
    let numOfRealRest = allRestaurant[1]
    var adjListOfRest = [[Int]](repeating: [], count: numOfAllRest)
    var newArray = [Int]()
    var arrayOfRealRest2 = [[(Int, Int)]](repeating: [], count: numOfAllRest)
    
    
    var arrayOfAllRest = [Restaurant](repeating: Restaurant(pathTo: 0, depht: 0), count: numOfAllRest)
    let arrayOfRealRest = readLine()!.split(separator: " ").map { Int($0)! }
    
    var isRealRest = [Bool](repeating: false, count: numOfAllRest)
    for rest in arrayOfRealRest {
        isRealRest[rest] = true
    }
    
    for _ in 0..<numOfAllRest-1 {
        let path = readLine()!.split(separator: " ").map { Int($0)! }
        let restA = path[0]
        let restB = path[1]
        adjListOfRest[restA].append(restB)
        adjListOfRest[restB].append(restA)
    }
    
    
    var isVisited = [Bool](repeating: false, count: numOfAllRest)
    var lastReal = -1
    
    func BFS(_ start: Int, _ isVisited: inout [Bool], _ adjListOfRest: inout [[Int]]) {
        if arrayOfRealRest.contains(start) {
            lastReal = start
        }
        let q = Queue<Int>()
        q.enqueue(item: start)
        isVisited[start] = true
        while !q.isEmpty() {
            let r = q.dequeue()!
            for i in adjListOfRest[r] {
                if !isVisited[i] {
                    arrayOfAllRest[i].depht = arrayOfAllRest[r].depht + 1
                    if arrayOfRealRest.contains(i) {
                        lastReal = i
                    }
                    q.enqueue(item: i)
                    isVisited[i] = true
                }
            }
        }
    }
    
    func separation(_ lastReal: Int, _ isVisited: inout [Bool], _ adjListOfRest: inout [[Int]]) {
        var count = 0
        newArray.append(lastReal)
        let q = Queue<Int>()
        q.enqueue(item: lastReal)
        isVisited[lastReal] = true
        while !q.isEmpty() {
            let r = q.dequeue()!
            count += 1
            for i in adjListOfRest[r] {
                if !isVisited[i] {
                    if arrayOfRealRest.contains(i) && !newArray.contains(i) {
    
                        arrayOfRealRest2[lastReal].append((i, count))
                        arrayOfRealRest2[i].append((lastReal, count))
                        separation(i, &isVisited, &adjListOfRest)
                        continue
                    }
                q.enqueue(item: i)
                isVisited[i] = true
                }
            }
        }
    }
    
    func shortestPath(_ lastReal: Int, _ isVisited: inout [Bool], _ adjListOfRest: inout [[Int]]) -> Int {
        var count = 0
        var firstBranch = 0
        var secondBranch = 0
        newArray.append(lastReal)
        let q = Queue<Int>()
        q.enqueue(item: lastReal)
        isVisited[lastReal] = true
        while !q.isEmpty() {
            guard let r = q.dequeue() else {
                return count
            }
            for i in arrayOfRealRest2[r] {
                if !isVisited[i.0] {
                    count += i.1
                    isVisited[i.0] = true
                    q.enqueue(item: i.0)
                }
            }
            if q.count == 2 {
                let a = q.dequeue()!
                let b = q.dequeue()!
                firstBranch = shortestPath(a, &isVisited, &adjListOfRest)
                secondBranch = shortestPath(b, &isVisited, &adjListOfRest)
                if firstBranch > secondBranch {
                    return count + firstBranch + 2 * secondBranch + arrayOfRealRest2[r][a].1
                } else {
                    return count + 2 * firstBranch + arrayOfRealRest2[r][b].1 + secondBranch
                }
            }
        }
        return count
    }
    
    var isVisited2 = [Bool](repeating: false, count: numOfAllRest)
    var isVisited3 = [Bool](repeating: false, count: numOfAllRest)
//    arrayOfRealRest3[0].depht = 0
    
    
    BFS(0, &isVisited, &adjListOfRest)
    separation(lastReal, &isVisited2, &adjListOfRest)

    print(arrayOfAllRest)
    print(lastReal)
    print(arrayOfRealRest2)
    print(shortestPath(lastReal, &isVisited3, &adjListOfRest))
}
