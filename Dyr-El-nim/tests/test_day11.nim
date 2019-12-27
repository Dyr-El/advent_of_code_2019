import day11
import unittest

const
    sol1 = 2018
    sol2 = """  **  ***  **** *  * ***  *  * ***  ***    
 *  * *  * *    * *  *  * * *  *  * *  *   
 *  * *  * ***  **   *  * **   ***  *  *   
 **** ***  *    * *  ***  * *  *  * ***    
 *  * *    *    * *  * *  * *  *  * * *    
 *  * *    *    *  * *  * *  * ***  *  *   
"""

suite "day11, problem 1":
    test "solution":
        let
            input = open("inputs/day11.txt").readAll()
        check(numberOfPaintedPanels(input) == sol1)
        echo("Solution 1: ", sol1)
suite "day11, problem 2":
    test "solution":
        let
            input = open("inputs/day11.txt").readAll()
            output = registrationId(input)
        check(output == sol2)
        echo("Solution 2: \n", sol2)
