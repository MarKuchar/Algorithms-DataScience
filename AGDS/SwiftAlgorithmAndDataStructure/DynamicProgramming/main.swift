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
//print(climbStairs(7))


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

//print(nonDecreasingNum(2))


func longestNonDecreasingSubsequence(_ sequence: [Int]) -> Int {
    var dp = [Int](repeating: 1, count: sequence.count)
        for i in 0..<sequence.count {
            var best = 1
            for j in 0..<i {
                if sequence[j] < sequence[i] {
                    best = max(best, dp[j] + 1)
                }
            }
            dp[i] = best
        }
    return dp.max()!
}

//print(longestNonDecreasingSubsequence([10,9,2,5,3,7,101,18]))


func numDecodings(_ s: String) -> Int {
    let arr = Array(s)
      var dp = [Int](repeating: 0, count: s.count + 2)
      dp[0] = 1
      dp[1] = s.first! == "0" ? 0 : 1
      if s.count >= 2 {
        for i in 2...s.count {
          let firstDigit = Int(String(arr[i - 1]))!
          if firstDigit >= 1{
            dp[i] += dp[i - 1]
          }
          let twoDigits = firstDigit + Int(String(arr[i - 2]))! * 10
          if twoDigits >= 10 && twoDigits <= 26 {
            dp[i] += dp[i - 2]
          }
        }
      }
      return dp[s.count]
    }


//print(numDecodings("363636"))

extension String {
    subscript(index: Int) -> String {
        get {
            return String(self[self.index(startIndex, offsetBy: index)])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            self = self.replacingCharacters(in: startIndex..<self.index(after: startIndex), with: newValue)
        }
    }
    
    subscript(start: Int, end: Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            return String(self[startIndex..<endIndex])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            self = self.replacingCharacters(in: startIndex..<endIndex, with: newValue)
        }
    }
}

func maxSubArray(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    var dp = [Int](repeating: Int.min, count: nums.count)
    dp[0] = nums[0]
    for i in 1..<nums.count {
        dp[i] = max(nums[i], dp[i - 1] + nums[i])
    }
    var max = Int.min
    for i in dp {
        if max < i {
            max = i
        }
    }
    return max
}

//print(maxSubArray([]))

func judgeSquareSum(_ c: Int) -> Bool {
    var dp = [Int]()
    for i in 0...Int(sqrt(Double(c) + 1)) {
        dp.append(i * i)
    }
    
    for i in 0..<dp.count {
        for j in 0..<dp.count {
            if dp[i] + dp[j] == c {
                return true
            }
        }
    }
    return false
}

print(judgeSquareSum(4))
