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
solveQueens(board: &board, &column)
