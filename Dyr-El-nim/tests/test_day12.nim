import day12
import unittest

const
    sol1 = 12351
    sol2 = 380635029877596

suite "day12, problem 1":
    test "example 1:0":
        let
            input = """<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>"""
            expected = """pos=<x=-1, y=0, z=2>, vel=<x=0, y=0, z=0>
pos=<x=2, y=-10, z=-7>, vel=<x=0, y=0, z=0>
pos=<x=4, y=-8, z=8>, vel=<x=0, y=0, z=0>
pos=<x=3, y=5, z=-1>, vel=<x=0, y=0, z=0>"""
        check($parseInput(input) == expected)
    test "example 1:1":
        let
            input = """<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>"""
            expected = """pos=<x=2, y=-1, z=1>, vel=<x=3, y=-1, z=-1>
pos=<x=3, y=-7, z=-4>, vel=<x=1, y=3, z=3>
pos=<x=1, y=-7, z=5>, vel=<x=-3, y=1, z=-3>
pos=<x=2, y=2, z=0>, vel=<x=-1, y=-3, z=1>"""
        var
            moons = parseInput(input)
        moons.step()
        check($moons == expected)
    test "solution":
        let
            input = open("inputs/day12.txt").readAll()
        check(totalEnergyAfter(input, 1000) == sol1)
        echo("Solution 1: ", sol1)
suite "day12, problem 2":
    test "example 1":
        let
            input = """<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>"""
        check(firstRepeatAfter(input) == 2772)
    test "example 2":
        let
            input = """<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>"""
        check(firstRepeatAfter(input) == 4686774924)
    test "solution":
        let
            input = open("inputs/day12.txt").readAll()
        check(firstRepeatAfter(input) == sol2)
        echo("Solution 2: \n", sol2)
