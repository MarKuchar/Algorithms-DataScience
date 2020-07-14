//
//  GroupPresentation.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-13.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


func findElements(numberOfItems n: Int, numberOfElements m: Int) -> [Int] {
    var arrayOfElements = [Int]()
    for _ in 0...n {
        let input = Int(readLine()!)!
        addElement(input, &arrayOfElements)
    }
    print(arrayOfElements)
    return arrayOfElements
}

func addElement(_ e: Int ,_ array: inout [Int]) {
    array.append(e)
    if array.count == 1 {
        return
    }
    let indexOfE = array.count - 1
    organizeAfterAddition(indexOfE, &array, >)
}

func organizeAfterAddition(_ indexOfE: Int, _ array: inout [Int], _ comparator: (Int, Int) -> Bool) {
    if indexOfE == 0 {
        return
    }
    var index = indexOfE / 2
    if !isLeftChild(indexOfE) {
            index -= 1
    }
    if (comparator(array[indexOfE], array[index])) {
        return
    }
    let temp = array[index]
    array[index] = array[indexOfE]
    array[indexOfE] = temp
    organizeAfterAddition(index, &array, comparator)
}

func isLeftChild(_ i: Int) -> Bool {
    return i % 2 == 1
}

func removeElement(_ e: Int ,_ array: inout [Int], _ comparator: (Int, Int) -> Bool) -> Int {
    let toRemove = array.remove(at: 0)
    let last = array.remove(at: array.count - 1)
    array[0] = last
    organizeAfterDeletion(0, &array)
    return toRemove
}

func organizeAfterDeletion(_ i: Int, _ array: inout [Int]){
    if i >= array.count {
        return
    }
    if array[2 * i + 1] < array[2 * i + 2] {
        if array[i] > array[2 * i + 1] {
            let temp = array[2 * i + 1]
            array[2 * i + 1] = array[i]
            array[i] = temp
            organizeAfterDeletion((2 * i + 1), &array)
        }
    } else {
        if array[i] > array[2 * i + 2] {
            let temp = array[2 * i + 2]
            array[2 * i + 2] = array[i]
            array[i] = temp
            organizeAfterDeletion((2 * i + 2), &array)
        }
    }
}
