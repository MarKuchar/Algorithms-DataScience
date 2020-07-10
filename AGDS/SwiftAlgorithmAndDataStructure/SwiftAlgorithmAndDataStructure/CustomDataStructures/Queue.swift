//
//  Queue.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-09.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

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
        let oldFirst = head
        if count == 0 {
            self.tail = Node<E>(item)
        }
        self.head = Node<E>(item, oldFirst)
        count += 1
    }
    
    public func dequeue() -> E? {
        if count == 0 {
            return nil
        }
        var current = head
        while current?.next?.next != nil {
            current = current?.next
        }
        let toRemove = tail?.item
        tail = current
        tail?.next = nil
        count -= 1
        return toRemove
    }
    
    public func peek() -> E? {
        var current = head
        while current?.next != nil {
           current = current?.next
        }
        return current?.item
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
