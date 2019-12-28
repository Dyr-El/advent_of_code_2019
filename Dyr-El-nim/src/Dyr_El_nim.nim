import std.monotimes
import times

import day01 as d01
import day02 as d02
import day03 as d03

when isMainModule:
  echo("Advent of Code 2019: Solutions")
  var
    startTime = getMonoTime()
    stopTime = getMonoTime()
    totalTime = initDuration(0)

  echo("Day 01:")
  block day01:
    startTime = getMonoTime()
    let
      input = open("inputs/day01.txt").readAll
    block part01_1:
      echo("  Solution 01.1: ", d01.solution1(input))
    block part01_2:
      echo("  Solution 01.2: ", d01.solution2(input))
    stopTime = getMonoTime()
  echo(" Time: ",$(float64((stopTime - startTime).inNanoseconds)*0.000001))
  totalTime = totalTime + (stopTime - startTime)

  echo("Day 02:")
  block day02:
    startTime = getMonoTime()
    let
      input = open("inputs/day02.txt").readAll()
    block part02_1:
      echo("  Solution 02.1: ", d02.run(input, 0, 0))
    block part02_2:
      echo("  Solution 02.2: ", d02.run(input, 12, 2))
    stopTime = getMonoTime()
  echo(" Time: ",$(float64((stopTime - startTime).inNanoseconds)*0.000001))

  echo("Day 03:")
  block day03:
    startTime = getMonoTime()
    let
      input = open("inputs/day03.txt").readAll()
    block part03_1:
      echo("  Solution 03.1: ", d03.findMinDistance(input))
    block part03_2:
      echo("  Solution 03.2: ", d03.findMinSteps(input))
    stopTime = getMonoTime()
  echo(" Time: ",$(float64((stopTime - startTime).inNanoseconds)*0.000001))

  totalTime = totalTime + (stopTime - startTime)
  echo("Total time: ", $(float(totalTime.inNanoseconds)*0.000001))
