//
//  main.swift
//  Sorting
//
//  Created by Martin Kuchar on 2020-07-06.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


var arr: [Int] = [3, 2, 5, 1, 4]

quickSort(&arr, 0, arr.count-1, >)
print(arr)

/// Quick sort algorithm

func quickSort<T: Comparable> (_ arr: inout [T], _ startIndex: Int, _ endIndex: Int, _ comparator: (T, T) -> Bool)  {
    guard endIndex - startIndex <= 1 else {
        return
    }
    quickSort(&arr, startIndex, partition(&arr, startIndex, endIndex, comparator), comparator)
    quickSort(&arr, partition(&arr, startIndex, endIndex, comparator), endIndex, comparator)
}

func partition<T: Comparable> (_ arr: inout [T], _ startIndex: Int, _ endIndex: Int, _ comparator: (T, T) -> Bool)  -> Int {
    let pivot = arr[endIndex]
    var newPivotIndex = endIndex
    
    for i in 0..<arr.count-1 {
        if comparator(arr[i], pivot) {
            arr.append(arr.remove(at: i))
            newPivotIndex -= 1
        }
    }
    return newPivotIndex
}

