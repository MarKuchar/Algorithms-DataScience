//
//  Stack.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-09.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

public final class Stack<E> : Sequence {
    private(set) var count = 0
    private var head: Node<E>? = nil
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        
        fileprivate init(_ item: E, _ next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() { }
    
    public func push(item: E) {
        let oldHead = head
        head = Node(item, oldHead)
        count += 1
    }
    
    public func pop() -> E? {
        if let toRemove = head {
            head = nil
            head = toRemove.next
            count -= 1
            return toRemove.item
        }
        return nil
    }
    
    public func peek() -> E? {
        return head?.item
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public class StackIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        public func next() -> E? {
            if let item = current?.item {
                self.current = current?.next
                return item
            }
            return nil
        }
        
        fileprivate init(_ current: Node<E>?) {
            self.current = current
        }
        public typealias Element = E
    }
    
    public func makeIterator() -> StackIterator<E> {
        return StackIterator<E>(head)
    }
}
