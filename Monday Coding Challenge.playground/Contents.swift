//: Reverse an array

import Foundation

func reverse<T>(inout array: [T]) {
    for i in 0..<(array.count/2) {
        let tmp = array[i]
        array[i] = array[array.count-1-i]
        array[array.count-1-i] = tmp
    }
}

var test = [1, 2, 3, 4, 5]
reverse(&test)

test = [5, 3]
reverse(&test)

test = [17]
reverse(&test)

test = []
reverse(&test)