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
        var pathFrom: Int
        var depht: Int
    }
    
    let allRestaurant = readLine()!.split(separator: " ").map { Int($0)! }
    let arrayOfRealRest = readLine()!.split(separator: " ").map { Int($0)! }
    let numOfAllRest = allRestaurant[0]
    let numOfAllRealRest = allRestaurant[1]
    
    var adjListOfRest = [[Int]](repeating: [], count: numOfAllRest)
    // To keep track of real restaurant visited (addition after visiting)
    var newArray = [Int]()
    // Just real restaurant are added to the restaurant's index is add a tupple with adj restaurant and distance between them
    var arrayOfRealRest2 = [[(Int, Int)]](repeating: [], count: numOfAllRest)
    // To keep track of depth and "parent" of current restaurant
    var arrayOfAllRest = [Restaurant](repeating: Restaurant(pathFrom: 0, depht: 0), count: numOfAllRest)
    
    for _ in 0..<numOfAllRest-1 {
        let path = readLine()!.split(separator: " ").map { Int($0)! }
        let restA = path[0]
        let restB = path[1]
        adjListOfRest[restA].append(restB)
        adjListOfRest[restB].append(restA)
    }
    
    var isVisited = [Bool](repeating: false, count: numOfAllRest)
    var isVisited2 = [Bool](repeating: false, count: numOfAllRest)
    var isVisited3 = [Bool](repeating: false, count: numOfAllRest)
    var lastReal = -1
    
    // To set all depths and "parents" of all the restaurants, plus method finds the furthest leaf vertex that is real restaurant.
    func BFS(_ start: Int, _ isVisited: inout [Bool]) {
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
                    arrayOfAllRest[i].pathFrom = r
                    if arrayOfRealRest.contains(i) {
                        lastReal = i
                    }
                    q.enqueue(item: i)
                    isVisited[i] = true
                }
            }
        }
    }
    
    // Separate real restaurants from unreal to use only real restaurant with new distances (count the distance between two real restaurants by using
    // lowest common ancestor algorithm).
    // Method starts from the furthest real restaurant and when it reach new real restaurant recursively calls itself, that how it keeps lastReal updated.
    func separation(_ lastReal: Int, _ isVisited: inout [Bool]) {
        newArray.append(lastReal)
        let q = Queue<Int>()
        q.enqueue(item: lastReal)
        isVisited[lastReal] = true
        while !q.isEmpty() {
            let r = q.dequeue()!
            for i in adjListOfRest[r] {
                if !isVisited[i] {
                    
                    // distance between two real restaurant
                    var count = 0
                    var restA = i
                    var restB = lastReal
                    
                    if arrayOfAllRest[restA].depht < arrayOfAllRest[restB].depht {
                        swap(&restA, &restB)
                    }
                    while arrayOfAllRest[restA].depht != arrayOfAllRest[restB].depht  {
                        count += 1
                        restA = arrayOfAllRest[restA].pathFrom
                    }
                    while restA != restB {
                        count += 2
                        restA = arrayOfAllRest[restA].pathFrom
                        restB = arrayOfAllRest[restB].pathFrom
                    }
                    // *********
                    
                    // Addition of real rest to the array
                    if arrayOfRealRest.contains(i) {
                        arrayOfRealRest2[lastReal].append((i, count))
                        var isVisited4 = [Bool](repeating: false, count: numOfAllRest)
                        // If is already added than don't call separation from the same vertex, otherwise call the separation from each real rest.
                        if !newArray.contains(i) {
                            separation(i, &isVisited4)
                        }
                        continue
                    }
                    
                q.enqueue(item: i)
                isVisited[i] = true
                }
            }
        }
    }
    
    var newArray2 = [Int]()
    
    // Method starts from the furthest real restaurant node and if there is only one non-visited real restaurant then add the distance, if there are two non-visited
    // restaurant then it compare both paths. The greater path is added to the count and the lower is multiply by two and then added, because it has to go 2x each path.
    // It's supposed to return the shortest path.
    func shortestPath(_ lastReal: Int, _ isVisited: inout [Bool]) -> Int {
        var count = 0
        isVisited[lastReal] = true
        var firstBranch = 0
        var secondBranch = 0
        let q = Queue<Int>()
        q.enqueue(item: lastReal)
        isVisited[lastReal] = true
        while !q.isEmpty() {
            var a = 0
            guard let r = q.dequeue() else {
                return count
            }
            isVisited[r] = true
            for i in arrayOfRealRest2[r] {
                if !isVisited[i.0] {
                    newArray2.append(i.0)
                    q.enqueue(item: i.0)
                    // Increment count after visiting every restaurant
                    count += i.1
                    // Set the distance from the first restaurant
                    if q.count == 1 {
                        a = i.1
                    }
                }
                if q.count == 2 {
                    // Split two paths according a path to the next restaurants, count the distance till the futhest restavrant it can go.
                    if a < i.1 {
                        firstBranch = shortestPath(q.dequeue()!, &isVisited)
                        if newArray2.count == numOfAllRealRest {
                            // Decrement distance to the seconde leaf, if all real rest were visited
                            return count + firstBranch - i.1
                        }
                        secondBranch = shortestPath(q.dequeue()!, &isVisited)
                    } else {
                        secondBranch = shortestPath(q.dequeue()!, &isVisited)
                        if newArray2.count == numOfAllRealRest {
                            // Decrement distance to the seconde leaf, if all real rest were visited
                            return count + secondBranch - a
                        }
                        firstBranch = shortestPath(q.dequeue()!, &isVisited)
                    }
                    // The longer path will be taken just once whereas the shorter one will be taken back and forth.
                    // Plus incrementing second time the distance to the next rest.
                    if firstBranch > secondBranch {
                        return count + firstBranch + 2 * (secondBranch) + i.1
                    } else {
                        return count + 2 * (firstBranch) + a + secondBranch
                    }
                }
            }
        }
        return count
    }
    
    BFS(0, &isVisited)
    separation(lastReal, &isVisited2)

    print(arrayOfAllRest)
    print(lastReal)
    print(arrayOfRealRest2)
    print(shortestPath(lastReal, &isVisited3))
}
