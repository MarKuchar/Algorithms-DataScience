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
        addElement(input, &arrayOfElements, >)
    }
    print(arrayOfElements)
    return arrayOfElements
}

func addElement(_ e: Int ,_ array: inout [Int], _ comparator: (Int, Int) -> Bool) {
    array.append(e)
    if array.count == 1 {
        return
    }
    var indexOfE = array.count - 1
    while indexOfE != 0 {
        var index = indexOfE / 2
        if !isLeftChild(indexOfE) {
            index -= 1
        }
        if (isLeftChild(indexOfE) && comparator(e, array[index])) {
            return
        }
        let temp = array[index]
        array[index] = e
        array[indexOfE] = temp
        indexOfE = index
    }
}

func isLeftChild(_ i: Int) -> Bool {
    return i % 2 == 1
}
