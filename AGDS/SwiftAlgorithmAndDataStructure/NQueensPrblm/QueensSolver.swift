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

func solveQueensNumOfCalls(board: inout Board, _ column: inout Int) -> Bool {
    if column == board.size {
        return true
    }
	count += 1
    
    var row = 0
    while row < board.size {
        if board.isSafe(row: row, col: column) {
            board.place(row: row, col: column)
            column += 1
            if solveQueensNumOfCalls(board: &board, &column) {
                print(board)
            } else {
                column -= 1
                board.remove(row: row, col: column)
            }
         }
        row += 1
    }
    return false
}

func solveQueensAllPossibilities(board: inout Board, _ column: inout Int, _ possibilities: inout Set<Board>) -> Bool {
    if column == board.size {
        return true
    }
    
    var row = 0
    while row < board.size {
        if board.isSafe(row: row, col: column) {
            board.place(row: row, col: column)
            column += 1
            if solveQueensAllPossibilities(board: &board, &column, &possibilities), !possibilities.contains(board) {
                possibilities.insert(board)
                count += 1
            } else {
                column -= 1
                board.remove(row: row, col: column)
            }
         }
        row += 1
    }
    return false
}
