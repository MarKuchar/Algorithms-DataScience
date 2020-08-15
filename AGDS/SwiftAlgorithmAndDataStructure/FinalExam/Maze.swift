//
//  Maze.swift
//  FinalExam
//
//  Created by Martin Kuchar on 2020-08-14.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func pizzaDeliver() {
    func printMaze() {
        let r = Int(readLine()!)!
           let c = Int(readLine()!)!

           var matrix = [[Character]]()
           for _ in 0..<r {
               let line = readLine()!
               let arr = Array(line)
               matrix.append(arr)
           }

           let plus = [[1, -1, 0, 0], [0, 0, -1, 1]]
           let northSouth = [[1, -1], [0, 0]]
           let westEast = [[0, 0], [1, -1]]
           
           var isVisited = [[Bool]](repeating: [Bool](repeating: false, count: c), count: r)
           let q = Queue<(x: Int, y: Int)>()
           let qDepth = Queue<Int>()
           q.enqueue(item: (x: 0, y: 0))
           qDepth.enqueue(item: 1)
           isVisited[0][0] = true
        
           while !q.isEmpty() {
               let intersection = q.dequeue()!
               let currentDepth = qDepth.dequeue()! + 1
               var nsx = 0
               var nsy = 0
               switch matrix[intersection.x][intersection.y] {
                   case "+":
                       for i in 0..<plus[0].count {
                           nsx = intersection.x + plus[0][i]
                           nsy = intersection.y + plus[1][i]
                           if nsx < r && nsy < c && nsx >= 0 && nsy >= 0 {
                               if !isVisited[nsx][nsy] && matrix[nsx][nsy] != "*" {
                                   if nsx == r - 1 && nsy == c - 1 {
                                       print(currentDepth)
                                       return
                               }
                               isVisited[nsx][nsy] = true
                               q.enqueue(item: (x: nsx, y: nsy))
                               qDepth.enqueue(item: currentDepth)
                               }
                           }
                       }
               case "|":
                   for i in 0..<northSouth[0].count {
                       nsx = intersection.x + northSouth[0][i]
                       nsy = intersection.y + northSouth[1][i]
                       if nsx < r && nsy < c && nsx >= 0 && nsy >= 0 {
                           if !isVisited[nsx][nsy] && matrix[nsx][nsy] != "*" {
                               if nsx == r - 1 && nsy == c - 1 {
                                   print(currentDepth)
                                   return
                           }
                           isVisited[nsx][nsy] = true
                           q.enqueue(item: (x: nsx, y: nsy))
                           qDepth.enqueue(item: currentDepth)
                           }
                   }
               }
           case "-":
               for i in 0..<westEast[0].count {
                   nsx = intersection.x + westEast[0][i]
                   nsy = intersection.y + westEast[1][i]
                   if nsx < r && nsy < c && nsx >= 0 && nsy >= 0 {
                       if !isVisited[nsx][nsy] && matrix[nsx][nsy] != "*" {
                           if nsx == r - 1 && nsy == c - 1 {
                               print(currentDepth)
                               return
                       }
                       isVisited[nsx][nsy] = true
                       q.enqueue(item: (x: nsx, y: nsy))
                       qDepth.enqueue(item: currentDepth)
                       }
                   }
               }
           default:
               print("-1")
            }
        }
        print("-1")
    }
    let testCases = Int(readLine()!)!
    for _ in 0..<testCases {
        printMaze()
    }
}



public final class Queue<E> : Sequence {
    
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
