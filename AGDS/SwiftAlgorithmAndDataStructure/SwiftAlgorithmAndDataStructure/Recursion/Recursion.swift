//
//  Recursion.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-06-23.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func reverseLines (_ line: Int) {
    let contents = try! String(contentsOfFile: "/Users/martin.kuchar/Development/AlgorithmsAndDataStructures/Classes/Swift-AGDS/SwiftAGDS/Recursion/story.txt")
    let lines = contents.split(separator: "\n")
    if line == lines.count {
        return
    }
    reverseLines(line + 1)
    print("\(lines[line])")
}
