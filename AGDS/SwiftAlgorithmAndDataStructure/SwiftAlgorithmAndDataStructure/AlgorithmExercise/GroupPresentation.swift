//
//  GroupPresentation.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-13.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

//func findElementsSort(numberOfItems n: Int, numberOfElements m: Int) -> [Int] {
//    var arrayOfElements = [Int]()
//    for _ in 0...n-1 {
//        let input = Int(readLine()!)!
//        compareE(&arrayOfElements, 0, arrayOfElements.count, input, m, <=)
//    }
//    print(arrayOfElements)
//    return arrayOfElements
//}
//
//func compareE(_ arr: inout [Int], _ firstIndex: Int, _ lastIndex: Int, _ e: Int, _ numOfElements: Int, _ comparator: (Int, Int) -> Bool) {
//    if arr.count < 1 {
//        arr.append(e)
//        return
//    }
//    let middleIndex = (lastIndex + firstIndex) / 2
//    if lastIndex - firstIndex <= 1 {
//        if comparator(e, arr[middleIndex]) {
//            arr.insert(e, at: middleIndex)
//        } else {
//            arr.insert(e, at: middleIndex + 1)
//        }
//        if arr.count > numOfElements {
//            arr.removeLast()
//        }
//        return
//    }
//
//    if comparator(e, arr[middleIndex]) {
//        let newLastIndex = (middleIndex + lastIndex) / 2
//        compareE(&arr, firstIndex, newLastIndex, e, numOfElements, comparator)
//    } else {
//        let newFirstIndex = (middleIndex + lastIndex) / 2
//        compareE(&arr, newFirstIndex, lastIndex, e, numOfElements, comparator)
//    }
//}

/// Attempt to use binary heap addition and deletion


func findElements(numberOfItems n: Int, numberOfElements m: Int) -> [Int] {
    var arrayOfElements = [Int]()
    for _ in 0...n-1 {
        let input = Int(readLine()!)!
        addElement(input, &arrayOfElements, m)
    }
    print(arrayOfElements)
    return arrayOfElements
}

func addElement(_ e: Int ,_ array: inout [Int], _ m: Int) {
    let indexOfE = array.count
    if array.count < m {
        array.append(e)
    }
    organizeAfterAddition(e, indexOfE, &array, <)
}

func organizeAfterAddition(_ e: Int, _ indexOfE: Int, _ array: inout [Int], _ comparator: (Int, Int) -> Bool) {
    if indexOfE == 0 { return }
    var index = indexOfE / 2
    if !isLeftChild(indexOfE) {
        index -= 1
    }
    
    let temp = array[index]
    
    if indexOfE < 4 {
        if (comparator(e, array[index])) { return }
        array[index] = e
        array[indexOfE] = temp
    }
    
    organizeAfterAddition(e, index, &array, comparator)
}

func isLeftChild(_ i: Int) -> Bool {
    return i % 2 == 1
}

