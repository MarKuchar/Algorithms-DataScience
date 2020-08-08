//
//  LowestCommonAncestor.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-20.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func commonAncestor() {
    struct Vertex {
        var parent: Int?
        var depth: Int?
        var to: [Int]?
    }
    let numOfVertices = Int(readLine()!)!
    var treeVertices = [Vertex](repeating: Vertex(parent: nil, to: []), count: numOfVertices)
    treeVertices[0].depth = 0
    
    for _ in 0..<numOfVertices-1 {
        let edge = readLine()!.split(separator: " ")
        let vertexA = Int(edge[0])!
        let vertexB = Int(edge[1])!
        treeVertices[vertexB-1].to?.append(vertexA)
        treeVertices[vertexA-1].to?.append(vertexB)
    }
    
    // set the depth of the vertices
    
    let q = Queue<Int>()
    var isVisited = [Bool](repeating: false, count: numOfVertices+1)
    q.enqueue(item: 1)
    isVisited[1] = true
    while !q.isEmpty() {
        let vertex = q.dequeue()!
        isVisited[vertex] = true
        if let connections = treeVertices[vertex-1].to {
            for i in 0..<connections.count {
                if !isVisited[connections[i]] {
                    treeVertices[connections[i]-1].parent = vertex
                    treeVertices[connections[i]-1].depth = treeVertices[vertex-1].depth! + 1
                    q.enqueue(item: connections[i])
                }
            }
        }
    }
    
    var numberOfPairs = Int(readLine()!)!
    
    while numberOfPairs > 0 {
        let edge = readLine()!.split(separator: " ")
        var vertexA = Int(edge[0])!
        var vertexB = Int(edge[1])!
        if treeVertices[vertexA-1].depth! < treeVertices[vertexB-1].depth! {
            swap(&vertexA, &vertexB)
        }
        while treeVertices[vertexA-1].depth! != treeVertices[vertexB-1].depth! {
            vertexA = treeVertices[vertexA-1].parent!
        }
        while vertexA != vertexB {
            vertexA = treeVertices[vertexA-1].parent!
            vertexB = treeVertices[vertexB-1].parent!
        }
        print(vertexA)
        numberOfPairs -= 1
    }
}

/// The Queue class represents a first-in-first-out (FIFO) queue of generic items.
/// It supports the usual *eunque* and *dequeue* operations, along with methods for peeking at the first item, testing if the queue is empty, and iterating through the items in FIFO order.
/// This implementation uses a singly linked list with an inner class for linked list nodes.
fileprivate final class Queue<E> : Sequence {
    /// beginning of queue
    private var first: Node<E>? = nil
    /// end of queue
    private var last: Node<E>? = nil
    /// size of the queue
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    /// Initializes an empty queue.
    public init() {}
    
    /// Returns true if this queue is empty.
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> E? {
        return first?.item
    }
    
    /// Adds the item to this queue
    /// - Parameter item: the item to add
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last }
        else { oldLast?.next = last }
        count += 1
    }
    
    /// Removes and returns the item on this queue that was least recently added.
    public func dequeue() -> E? {
        if let item = first?.item {
            first = first?.next
            count -= 1
            // to avoid loitering
            if isEmpty() { last = nil }
            return item
        }
        return nil
    }
    
    /// QueueIterator that iterates over the items in FIFO order.
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}
