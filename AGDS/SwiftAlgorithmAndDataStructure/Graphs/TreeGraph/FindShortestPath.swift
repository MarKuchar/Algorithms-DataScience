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
        var time: Int
    }
    let allRestaurant = readLine()!.split(separator: " ").map { Int($0)! }
    let numOfAllRest = allRestaurant[0]
    let numOfRealRest = allRestaurant[1]
    var adjListOfRest = [[Int]](repeating: [], count: numOfAllRest)
    var newArray = [Int]()
    var arrayOfRealRest2 = [[(Int, Int)]](repeating: [], count: numOfAllRest)
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
    
    var startRest = Int()
    var isVisited = [Bool](repeating: false, count: numOfAllRest)
    var isVisited2 = [Bool](repeating: false, count: numOfAllRest)
    
    func BFS(_ start: Int, _ isVisited: inout [Bool], _ adjListOfRest: inout [[Int]]) {
        let q = Queue<Int>()
        q.enqueue(item: start)
        isVisited[start] = true
        while !q.isEmpty() {
            let r = q.dequeue()!
            for i in adjListOfRest[r] {
                if !isVisited[i] {
                    q.enqueue(item: i)
                    isVisited[i] = true
                    if arrayOfRealRest.contains(i) {
                        startRest = i
                    }
                }
            }
        }
    }
    
    func BFS2(_ start: Int, _ isVisited: inout [Bool], _ adjListOfRest: inout [[Int]]) {
          var count = 0
          newArray.append(start)
          let q = Queue<Int>()
          q.enqueue(item: start)
          isVisited[start] = true
          while !q.isEmpty() {
              let r = q.dequeue()!
              count += 1
              for i in adjListOfRest[r] {
                  if !isVisited[i] {
                      if arrayOfRealRest.contains(i) && !newArray.contains(i) {
                          arrayOfRealRest2[start].append((i, count))
                          BFS2(i, &isVisited, &adjListOfRest)
                          continue
                      }
                      q.enqueue(item: i)
                      isVisited[i] = true
                  }
              }
          }
      }
    
    BFS(0, &isVisited, &adjListOfRest)
    BFS2(startRest, &isVisited2, &adjListOfRest)
    print(arrayOfRealRest)
    print(startRest)
    print(newArray)
    print(arrayOfRealRest)
    print(arrayOfRealRest2)
}
