//
//  main.swift
//  DynamicProgramming
//
//  Created by Martin Kuchar on 2020-08-10.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

func climbStairs(_ n: Int) -> Int {
  if n == 1 {
    return 1
  }
  var dp = [Int](repeating: 0, count: n + 1)
  dp[1] = 1
  dp[2] = 2
    dp[3] = 4
  for i in 4...n {
    dp[i] = dp[i - 1] + dp[i - 2] + dp[i - 3]
    }
  return dp[n]
}
//print(climbStairs(10))


func nonDecreasingNum(_ n: Int) -> Int {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 10), count: n + 1)
    for i in 0...9 {
        dp[1][i] = 1
    }
    for i in 2...n {
        for j in 0...9 {
            for k in 0...j {
                dp[i][j] += dp[i - 1][k]
            }
        }
    }
    return dp[n].reduce(0) { $0 + $1 }
}

print(nonDecreasingNum(2))


func longestNonDecreasingSubsequence(_ sequence: [Int]) -> Int {
    var dp = [Int](repeating: 1, count: sequence.count)
    for i in 0..<sequence.count {
        for j in 0..<i {
            if sequence[j] < sequence[i] && dp[j] + 1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
    }
    return dp.max()!
}

//print(longestNonDecreasingSubsequence([10,9,2,5,3,7,101,18]))
