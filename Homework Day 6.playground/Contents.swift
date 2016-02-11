//: Day 6 Homework
import UIKit

var foods = ["apples","pasta","pizza", "salad", "cupcakes"]
var footballTeams = ["Seahawks", "49ers", "Rams", "Cardinals"]
var playerNumbers = [3,4,24,29,89]

func reverseArray(array:[AnyObject]) -> [AnyObject]
{
    var reversedArray = [AnyObject] ()
    for var index = array.count - 1 ; index >= 0 ; index--
    {
        reversedArray.append(array[index])
        print(reversedArray)
    }
    return reversedArray
}

reverseArray(foods)
reverseArray(footballTeams)
reverseArray(playerNumbers)
