import day02
import unittest

const
    sol1 = 4945026
    sol2 = 5296

suite "day02, problem 1":
    test "example 1":
        const
            input1 = """1,9,10,3,2,3,11,0,99,30,40,50"""
        check(run(input1, 9, 10) == 3500)
    test "example 2":
        const
            input2 = """1,0,0,0,99"""
        check(run(input2, 0, 0) == 2)
    test "example 5":
        const
            input5 = """1,1,1,4,99,5,6,0,99"""
        check(run(input5, 1, 1) == 30)
    test "solution":
        let
            input = open("inputs/day02.txt").readAll()
        check(run(input, 12, 2) == sol1)
        echo("Solution 1: ", sol1)

suite "day02, problem 2":
    test "solution":
        let
            input = open("inputs/day02.txt").readAll()
        check(findNounAndVerb(input, 19690720) == sol2)
        echo("Solution 2: ", sol2)
