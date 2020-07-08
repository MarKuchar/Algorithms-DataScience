//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that accepts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.

var count = 0

func solveQueens(board: inout Board, _ column: inout Int) {
    if column == board.size {
        column = 0
    }
	count += 1
    
    var row = 0
    while row < board.size {
        if board.isSafe(row: row, col: column) {
            board.place(row: row, col: column)
            column += 1
            solveQueens(board: &board, &column)
            break
         }
        row += 1
    }
    print(board)
}
