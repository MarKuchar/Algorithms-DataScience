//
//  NewQ.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-22.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

public final class Queue<E> : Sequence {
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
