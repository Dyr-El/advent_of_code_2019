import std.monotimes
import times

import day01 as d01
import day02 as d02

when isMainModule:
  echo("Advent of Code 2019: Solutions")
  var
    startTime = getMonoTime()
    stopTime = getMonoTime()
    totalTime = initDuration(0)

  echo("Day 01:")
  block day01:
    startTime = getMonoTime()
    block part01_1:
      let
        inFile = open("inputs/day01.txt")
      echo("  Solution 01.1: ", d01.solution1(inFile))
      inFile.close()
    block part01_2:
      let
        inFile = open("inputs/day01.txt")
      echo("  Solution 01.2: ", d01.solution2(inFile))
      inFile.close()
    stopTime = getMonoTime()
  echo(" Time: ",$(float64((stopTime - startTime).inNanoseconds)*0.000001))
  totalTime = totalTime + (stopTime - startTime)

  echo("Day 02:")
  block day02:
    startTime = getMonoTime()
    block part02_1:
      let
        input = open("inputs/day02.txt").readAll()
      echo("  Solution 02.1: ", d02.run(input, 0, 0))
    block part02_2:
      let
        input = open("inputs/day02.txt").readAll()
      echo("  Solution 02.2: ", d02.run(input, 12, 2))
    stopTime = getMonoTime()
  echo(" Time: ",$(float64((stopTime - startTime).inNanoseconds)*0.000001))
  totalTime = totalTime + (stopTime - startTime)
  echo("Total time: ", $(float(totalTime.inNanoseconds)*0.000001))
