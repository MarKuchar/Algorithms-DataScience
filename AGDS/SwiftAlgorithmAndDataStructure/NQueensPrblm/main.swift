//
//  main.swift
//  NQueenPrblm
//
//  Created by Martin Kuchar on 2020-07-07.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation


var board = Board(size: 8)
var column = 0


// Part one - print all the possibilities
var possibilities = Set<Board>()
solveQueensAllPossibilities(board: &board, &column, &possibilities)
print(possibilities)
print(possibilities.count)

// Part two - count number of recursive calls
//if !solveQueensNumOfCalls(board: &board, &column) {
//    print("Number of recursive calls: ",count)
//}
