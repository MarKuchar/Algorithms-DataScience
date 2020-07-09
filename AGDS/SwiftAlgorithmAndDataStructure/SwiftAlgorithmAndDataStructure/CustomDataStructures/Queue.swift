//
//  Queue.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-09.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

public final class Queue<E> {
    
    private(set) var count = 0
    private var first: Node<E>? = nil
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        
        fileprivate init(_ item: E, _ next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
        
    }
    
    public init() { }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func enqueue(item: E) {
        let oldFirst = first
        self.first = Node<E>(item, oldFirst)
        count += 1
    }
    
//    public func dequeue() -> E? {
//        
//    }
}
