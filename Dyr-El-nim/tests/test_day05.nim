import day05
import unittest

const
    sol1 = 12440243
    sol2 = 15486302

suite "day05, problem 1":
    test "example 2":
        const
            input2 = """3,0,4,0,99"""
            userInput = 2
        let
            output = run(input2, userInput)
        check(output == userInput)
    test "solution":
        let
            input = open("inputs/day05.txt").readAll()
        const
            userInput = 1
        let
            output = run(input, userInput)
        check(output == sol1)
        echo("Solution 1: ", sol1)

suite "day05, problem 2":
    test "example 1":
        const
            input1 = "3,9,8,9,10,9,4,9,99,-1,8"
            expected1 = 0
            userInput = 7
        check(expected1 == run(input1, userInput))
    test "example 2":
        const
            input2 = "3,9,7,9,10,9,4,9,99,-1,8"
            expected2 = 1
            userInput = 7
        check(expected2 == run(input2, userInput))
    test "solution":
        let
            input = open("inputs/day05.txt").readAll()
            userInput = 5
        let
            solution = run(input, userInput)
        check(sol2 == solution)
        echo("Solution 2: ", sol2)        