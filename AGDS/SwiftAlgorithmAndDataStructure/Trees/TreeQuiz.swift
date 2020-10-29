//
//  TreeQuiz.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-18.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

fileprivate final class PriorityQueue<E> : Sequence {
    
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

func printParent() {
    let numberOfNodes = Int(readLine()!)!
    var hasParent = [Bool](repeating: false, count: numberOfNodes)
    hasParent[0] = true
    var parents = [Int](repeating: 0, count: numberOfNodes+1)
    for _ in 0..<numberOfNodes-1 {
        let edge = readLine()!.split(separator: " ")
        let nodeA = Int(edge[0])!
        let nodeB = Int(edge[1])!
        if hasParent[nodeA-1] {
            parents[nodeB] = nodeA
            hasParent[nodeB-1] = true
        } else {
            parents[nodeA] = nodeB
            hasParent[nodeA-1] = true
        }
    }
    for i in 2...numberOfNodes {
        print(parents[i])
    }
}


func diameter() {
    let numberOfNodes = Int(readLine()!)!
    var nodes = [[(Int, Int)]](repeating: [], count: numberOfNodes)
    
    for _ in 0...numberOfNodes-1 {
        let edges = readLine()!.split(separator: " ")
        let nodeA = Int(edges[0])!
        var i = 1
        var j = 0
        while Int(edges[i])! != -1 {
            let nodeB = Int(edges[i])!
            let distance = Int(edges[i+1])!
            let pair: (Int, Int) = (nodeB, distance)
            nodes[nodeA-1].append(pair)
            j += 1
            i += 2
        }
    }
    
    func findMaxDiameter(_ node: Int, _ isVisited: inout [Bool]) -> Int {
        if isVisited[node] == true {
            return 0
        }
        var currentDiameter = 0
        isVisited[node] = true
        
        for tupple in nodes[node] {
            if isVisited[tupple.0 - 1] == true {
                continue
            }
            let diameter = tupple.1 + findMaxDiameter(tupple.0 - 1 , &isVisited)
            if currentDiameter < diameter {
                currentDiameter = diameter
            }
        }
        return currentDiameter
    }
    
    var maxDiameter = 0
    for i in 0...numberOfNodes-1 {
        var isVisited = [Bool](repeating: false, count: numberOfNodes)
        let diameterFromNode = findMaxDiameter(i, &isVisited)
        if diameterFromNode > maxDiameter {
            maxDiameter = diameterFromNode
        }
    }
    print(nodes)
    print(maxDiameter)
}



func findParent() {
    let numOfNodes = Int(readLine()!)!
    var visited = [Bool](repeating: false, count: numOfNodes + 1)
    var parents = [Int](repeating: -1, count: numOfNodes + 1)
    var adjList = [[Int]](repeating: [], count: numOfNodes + 1)
    for _ in 0..<numOfNodes - 1 {
        let line = readLine()!.split(separator: " ")
        let a = Int(line[0])!
        let b = Int(line[1])!
        adjList[a].append(b)
        adjList[b].append(a)
    }
    let q = PriorityQueue<Int>()
    q.enqueue(item: 1)
    while q.isEmpty() == false {
        let parent = q.dequeue()!
        visited[parent] = true
        for child in adjList[parent] {
            if !visited[child] {
                parents[child] = parent
                q.enqueue(item: child)
            }
        }
    }
    print(parents)
}

class Edge {
    let to: Int
    let distance: Int
    init(to: Int, with distance: Int) {
        self.to = to
        self.distance = distance
    }
}

func diameterOfTree() {
    let numOfV = Int(readLine()!)!
    var adjList = [[Edge]](repeating: [], count: numOfV + 1)
    var visited = [Bool](repeating: false, count: numOfV + 1)
    
    for _ in 0..<numOfV {
        var line = readLine()!.split(separator: " ")
        let nodeA = Int(line.remove(at: 0))!
        while Int(line[0]) != -1 {
            let nodeB = Int(line.remove(at: 0))!
            let distance = Int(line.remove(at: 0))!
            adjList[nodeA].append(Edge(to: nodeB, with: distance))
        }
    }
    
    var farthest = 1
    
    func BFS(node: Int) {
        visited[node] = true
        for edge in adjList[node] {
            if !visited[edge.to] {
                farthest = edge.to
                BFS(node: edge.to)
            }
        }
    }
    
    var diameter = 0
    var visited2 = [Bool](repeating: false, count: numOfV + 1)
    func countMax(node: Int, currentDiameter: Int) {
        visited2[node] = true
        for edge in adjList[node] {
            if !visited2[edge.to] {
                if diameter < currentDiameter + edge.distance {
                    diameter = currentDiameter + edge.distance
                }
                countMax(node: edge.to, currentDiameter: currentDiameter + edge.distance)
            }
        }
    }
    
    BFS(node: 1)
    countMax(node: farthest, currentDiameter: 0)
    print(diameter)
}
