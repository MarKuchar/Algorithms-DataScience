//
//  Epidemiology.swift
//  FinalExam
//
//  Created by Martin Kuchar on 2020-08-14.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func epidemioloy() {
    let total = Int(readLine()!)!
    let first = Int(readLine()!)!
    let spread = Int(readLine()!)!
    var dp = [Int]()
    dp.append(first)
    var count = 0
    while dp[dp.count - 1] < total {
        count += 1
        dp.append(dp[count - 1] * spread * first)
     }
    print(count - 1)
}
