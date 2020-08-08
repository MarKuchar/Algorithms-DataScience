//
//  MinimumCostFlow.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-08-04.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

struct Pipe: Comparable, Hashable {
    let to: Int
    let cost: Int
    var isActive = false
    
    static func < (lhs: Pipe, rhs: Pipe) -> Bool {
        if lhs.cost == rhs.cost {
            if lhs.isActive {
                return true
            } else {
                return false
            }
        }
        return lhs.cost < rhs.cost
    }
}

func minimumCostFlow(_ testInput: [String]) -> Int {
    
    /// Test cases
//    let header = testInput[0].split(separator: " ").map( { Int($0)! })
//    let n = header[0]
//    let m = header[1]
//    let d = header[2]


    /// StdIn
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let n = firstLine[0]
    let m = firstLine[1]
    let _ = firstLine[2]

    var pipeArr = [[Pipe]](repeating: [], count: n + 1)
    var pipeQueue = IndexPriorityQueue<Pipe>(>)

    /// Test cases
//    for i in 1..<testInput.count {
//           let line = testInput[i].split(separator: " ").map( { Int($0)! })
//
//           var pipe = Pipe(to: line[1], cost: line[2])
//           var pipeB = Pipe(to: line[0], cost: line[2])
//           if i < n {
//               pipe.isActive = true
//               pipeB.isActive = true
//           }
//           pipeArr[line[0]].append(pipe)
//          pipeArr[line[1]].append(pipeB)
//
//       }
    
    /// StdIn
    for i in 0..<m {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        var pipe = Pipe(to: line[1], cost: line[2])
        var pipeB = Pipe(to: line[0], cost: line[2])
        if i < n - 1 {
            pipe.isActive = true
            pipeB.isActive = true
        }
        pipeArr[line[0]].append(pipe)
        pipeArr[line[1]].append(pipeB)
    }
    
    var isConnected = [Bool](repeating: false, count: n + 1)
    pipeQueue.enqueue(Pipe(to: 1, cost: 0, isActive: true))
    var days = 0
    var connected = 0
    var totalCost = 0
    
    while !pipeQueue.isEmpty {
        let b = pipeQueue.dequeue()!
        if !isConnected[b.to] {
            if !b.isActive {
                days += 1
            }
            totalCost += b.cost
            connected += 1
            isConnected[b.to] = true
            for i in pipeArr[b.to] {
                pipeQueue.enqueue(i)
            }
        }
    }
    print(days)
    return days
}


func testCases(inFile: String, outFile: String? = nil) -> Int {
    func readFile(_ path: String) -> [String] {
        var lines = [String]()
        errno = 0
        if freopen(path, "r", stdin) == nil {
            perror(path)
            return []
        }
        while let line = readLine() {
            lines.append(line)
        }
        return lines
    }
    
    let input = readFile(inFile)
    let result = minimumCostFlow(input)
    let output = readFile(outFile!)
    let answer = Int(output[0])!
    if result == answer {
        print("Success(expected:\(answer) - result:\(result))\n")
    } else {
        print("Fail (expected:\(answer) - result:\(result))\n")
    }
    return result
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
