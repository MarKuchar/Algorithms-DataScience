//
//  main.swift
//  Sorting
//
//  Created by Martin Kuchar on 2020-07-06.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


var arr: [Int] = [8, 5, 4, 3, 1, 4, 5]

quickSort(&arr, 0, arr.count, >)
print(arr)

/// Quick sort algorithm

func quickSort<T: Comparable> (_ arr: inout [T], _ startIndex: Int, _ endIndex: Int, _ comparator: (T, T) -> Bool)  {
    guard endIndex - startIndex > 1 else {
        return
    }
    let pivotIndex = partition(&arr, startIndex, endIndex, comparator)
    quickSort(&arr, startIndex, pivotIndex, comparator)
    quickSort(&arr, pivotIndex, endIndex, comparator)
}

func partition<T: Comparable> (_ arr: inout [T], _ startIndex: Int, _ endIndex: Int, _ comparator: (T, T) -> Bool)  -> Int {
    let pivot = arr[endIndex-1]
    var newPivotIndex = endIndex-1
    
    for i in (startIndex..<newPivotIndex).reversed() {
        if comparator(arr[i], pivot) {
            arr.insert(arr.remove(at: i), at: newPivotIndex)
            newPivotIndex -= 1
        }
    }
    return newPivotIndex
}

