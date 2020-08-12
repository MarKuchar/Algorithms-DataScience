//
//  FloodFillAssignment.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-27.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

fileprivate final class Queue<E> : Sequence {
    
    private(set) var count = 0
    private var head: Node<E>? = nil
    private var tail: Node<E>? = nil
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        
        fileprivate init(_ item: E, _ next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() { }
    
    /// Returns true or false
    /// - Returns: True if the queue is empty, otherwise False
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func enqueue(item: E) {
        let oldLast = tail
        self.tail = Node<E>(item)
        if isEmpty() {
            self.head = tail
        } else {
            oldLast?.next = tail
        }
        count += 1
    }
    
    public func dequeue() -> E? {
        if let item = head?.item {
            head = head?.next
            count -= 1
            if isEmpty() {
                tail = nil
            }
            return item
        }
        return nil
    }
    
    public func peek() -> E? {
        return head?.item
    }
    
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                self.current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    public func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(head)
    }
}

func shortestBrige() {
    
    struct Square {
        let x: Int
        let y: Int
    }
    
    let dx = [0, 0, 1, -1]
    let dy = [-1, 1, 0, 0]
    let gridSize = Int(readLine()!)!
    var grid = [[Int]]()
    var gridSeparated = [[Int]](repeating: [Int](repeating: 0, count: gridSize), count: gridSize)
    
    for _ in 0..<gridSize {
        grid.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    // Assign different num to the disconnected islands
    func bfsColoring(_ square: Square, _ id: Int) {
        let q = Queue<Square>()
        q.enqueue(item: square)
        gridSeparated[square.x][square.y] = id
        
        while !q.isEmpty() {
            let s = q.dequeue()!
            for i in 0..<4 {
                let nsx = s.x + dx[i]
                let nsy = s.y + dy[i]
                if nsx >= 0 && nsx < gridSize && nsy >= 0 && nsy < gridSize {
                    if grid[nsx][nsy] == 1 && gridSeparated[nsx][nsy] == 0 {
                        q.enqueue(item: Square(x: nsx, y: nsy))
                        gridSeparated[nsx][nsy] = id
                    }
                }
            }
        }
    }
    
    // Check all the adjacent squares whether there is 0 or next ID and return the depth from the square
    func findShortest(_ square: Square, _ id: Int) -> Int{
        var squareVisited = [[Bool]](repeating: [Bool](repeating: false, count: gridSize), count: gridSize)
        let q = Queue<Square>()
        let qSize = Queue<Int>()
        q.enqueue(item: square)
        qSize.enqueue(item: 0)
        
        while !q.isEmpty() {
            let s = q.dequeue()!
            let sSize = qSize.dequeue()!
            for i in 0..<4 {
                let nsx = s.x + dx[i]
                let nsy = s.y + dy[i]
                if nsx >= 0 && nsx < gridSize && nsy >= 0 && nsy < gridSize {
                    if gridSeparated[nsx][nsy] != 0 && gridSeparated[nsx][nsy] != id {
                        return sSize
                    }
                    if gridSeparated[nsx][nsy] == 0 && !squareVisited[nsx][nsy] {
                        q.enqueue(item: Square(x: nsx, y: nsy))
                        qSize.enqueue(item: sSize + 1)
                        squareVisited[nsx][nsy] = true
                    }
                }
            }
        }
        return Int.max
    }

    
    var id = 0
    var bridgeSize = Int.max
    
    for i in 0..<gridSize {
        for j in 0..<gridSize {
            if gridSeparated[i][j] == 0 && grid[i][j] == 1 {
                id += 1
                bfsColoring(Square(x: i, y: j), id)
            }
        }
    }
    
     for i in 0..<gridSize {
           for j in 0..<gridSize {
               if gridSeparated[i][j] != 0 {
                 if findShortest(Square(x: i, y: j), gridSeparated[i][j]) < bridgeSize {
                     bridgeSize = findShortest(Square(x: i, y: j), gridSeparated[i][j])
                 }
               }
           }
       }
    
    print(bridgeSize)
}
