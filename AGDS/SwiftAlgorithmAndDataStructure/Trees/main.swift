//
//  main.swift
//  Trees
//
//  Created by Martin Kuchar on 2020-07-29.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


let mst = MST()
//print(mst.kruskalMST([[(1, 5), (3, 4)], [(0, 5), (3, 2), (2, 3)], [(1, 3), (3, 6)], [(0, 4), (1, 2), (2, 6)]]))
//print(mst.primMST([[(1, 5), (3, 4)], [(0, 5), (3, 2), (2, 3)], [(1, 3), (3, 6)], [(0, 4), (1, 2), (2, 6)]]))

//minimumCostFlow([])

for j in 1...50 {
    let i = String(format: "%.2d", j)
    let testCase = "/Users/martin.kuchar/Downloads/mcf/mcf.\(i)"
//    if let url = URL.init(string: testCase) {
//        print("\([Character](repeating: "-", count: 40).reduce("") {$0 + String.init($1)})")
//        print("TestCase: \(url.lastPathComponent)")
//    }
    print(testCases(inFile: "\(testCase).in", outFile: "\(testCase).out"))
}
