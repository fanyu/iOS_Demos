//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// Map 

let num = [1,2,4]
let sum = num.map { $0 + $0 }
print(sum)

let sumStr = num.map { (num) -> String in
    return "the num is \(num)"
}
print(sumStr)

let isEven = num.map { $0 % 2 == 0 }
print(isEven)


// Flat Map 
let array = [[1,2,3], [4,5,6], [7,8,9]]
print(array.map { $0 })
print(array.flatMap { $0 })

let fruit = ["apple", "bannna", "orange"]
let count = [1, 2, 3]
let fruitCount = count.flatMap { count in
    fruit.map({ (fruit) in
        (fruit, count)
    })
}
print(fruitCount)


// Filter 
let newNum = [1,3,5,6,7,8,9,0]
print(newNum.filter({ $0 % 2 == 0}))


// Reduce 
let num2 = [1,2,3,4,5,6]
let sum2 = num2.reduce(0) { (one, two) in
    return one + two
}
let sum22 = num2.reduce(0) { $0 + $1 }
print(sum2)

let str2 = num2.reduce("") { "\($0)" + "\($1)"}
print(str2)










