//
//  MST.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 7/30/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// Minimum Spanning Tree Algorithms
public final class MST {

  /// Prim's MST Algorithm O(ElgV)
  /// Use Priority Queue (Binary Heap) and Adjacency List
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
    
    struct Edge: Comparable, Hashable {
        let to: Int
        let weight: Int
        static func < (lhs: MST.Edge, rhs: MST.Edge) -> Bool {
            return lhs.weight < rhs.weight
        }
    }
    
  public func primMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    var queue = IndexPriorityQueue<Edge>(>)
    var isVisited = [Bool](repeating: false, count: graph.count)
    
    queue.enqueue(Edge(to: 0, weight: 0))
    var count = 0
    var minCost = 0
    
    while !queue.isEmpty {
        let edge = queue.dequeue()!
        if !isVisited[edge.to] {
            let vertex = edge.to
            isVisited[vertex] = true
            minCost += edge.weight
            for v in graph[vertex] {
                if !isVisited[v.v] {
                    queue.enqueue(Edge(to: v.v, weight: v.w))
                }
            }
        }
    }
    return minCost
  }
  
  /// Kruskal's MST Algorithm O(ElgE)
  /// Use Union-Find and Adjacency List (You can use Swift's built-in sort method.)
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
  public func kruskalMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    var unionFind = UF(graph.count)
    var adjList = [(v1: Int, v2: Int, w: Int)]()
    for i in 0..<graph.count {
        for j in 0..<graph[i].count {
            adjList.append((i, graph[i][j].v, graph[i][j].w))
        }
    }
    adjList.sort(by: { $0.w < $1.w })
    
    var minCost = 0
    var connectedV = 1
    
    print(adjList)
    while connectedV != graph.count {
        let edge = adjList.removeFirst()
        if !unionFind.connected(edge.v1, edge.v2) {
            minCost += edge.w
            connectedV += 1
            unionFind.union(edge.v1, edge.v2)
        }
    }
    print(unionFind)
    return minCost
  }
}

fileprivate struct IndexPriorityQueue<Key: Comparable & Hashable> {
  /// the array that stores the heap's nodes
  private(set) var elements = [Key]()
  /// determines whether this is a max-heap(>) or min-heap(<)
  private var order: (Key, Key) -> Bool
  /// dictionary from elements to its heap position(index) in the `elements` array
  private var indices = [Key: Int]()
  
  /// Returns true if this priority queue is empty
  public var isEmpty: Bool {
    return elements.isEmpty
  }
  
  /// Returns the number of keys on this priority queue.
  public var count: Int {
    return elements.count
  }
  
  /// Returns the min or max key O(1)
  public var peek: Key? {
    return elements.first
  }
  
  /// Initializes an empty indexed priority queue with indices
  /// - Parameter order: order of priority queue (`min <` or `max >`)
  public init(_ order: @escaping (Key, Key) -> Bool) {
    self.order = order
  }
  
  /// Returns the index of the given key element. (amortized constant time **O(1)**)
  /// - Parameter key: key element
  /// - Returns: the index of the given key element
  public func index(of key: Key) -> Int? {
    return indices[key]
  }
  
  /// Is `key` on this priority queue? **O(1)**
  /// - Parameter key: key element
  /// - Returns: `true` if key exists on this priority queue; `false` otherwise.
  public func contains(key: Key) -> Bool {
    return indices[key] != nil
  }
  
  /// Enqueue key element on this priority queue. **O (log N)**
  /// - Parameter key: key element
  public mutating func enqueue(_ key: Key) {
    guard !contains(key: key) else { return }
    elements.append(key)
    indices[key] = elements.count - 1
    siftUp(from: elements.count - 1)
  }
  
  /// Dequeue the root node on this priority queue. **O(log N)**
  /// - Returns: the root node if the priority queue is not empty
  @discardableResult
  public mutating func dequeue() -> Key? {
    if isEmpty { return nil }
    let peek = self.peek!
    swapAt(0, count - 1)
    elements.remove(at: count - 1)
    indices[peek] = nil
    siftDown(from: 0)
    return peek
  }
  
  /// Update the old key to the new key value. **O(log N)**
  /// - Parameters:
  ///   - oldKey: old key
  ///   - newKey: new key
  public mutating func update(oldKey: Key, to newKey: Key) {
    guard let index = indices[oldKey] else { return }
    elements[index] = newKey
    siftDown(from: index)
    siftUp(from: index)
  }
  
  /// Delete the key at index `i` in this priority queue. **O(log N)**
  /// - Parameter i: index of the key to delete
  public mutating func delete(at i: Int) {
    swapAt(i, count - 1)
    elements.remove(at: count - 1)
    indices[elements[i]] = nil
    siftUp(from: i)
    siftDown(from: i)
  }
  
  /**
   Private helper methods
   */
  private mutating func siftUp(from i: Int) {
    var i = i
    while i > 0 && order(elements[parent(of: i)], elements[i]) {
      swapAt(parent(of: i), i)
      i = parent(of: i)
    }
  }
  
  private mutating func siftDown(from i: Int) {
    var i = i
    while left(of: i) < count {
      var j = left(of: i)
      if j < count - 1 && order(elements[j], elements[j + 1]) {
        j += 1
      }
      if !order(elements[i], elements[j]) { break }
      swapAt(i, j)
      i = j
    }
  }
  
  private mutating func swapAt(_ i: Int, _ j: Int) {
    elements.swapAt(i, j)
    indices[elements[i]] = i
    indices[elements[j]] = j
  }
  
  @inline(__always) private func parent(of index: Int) -> Int {
    return (index - 1) / 2
  }
  
  @inline(__always) private func left(of index: Int) -> Int {
    return 2 * index + 1
  }
  
  @inline(__always) private func right(of index: Int) -> Int {
    return 2 * index + 2
  }
}


//
//  PriorityQueue.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-13.
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
