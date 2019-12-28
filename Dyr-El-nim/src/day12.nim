import strscans
import strutils
import strformat
import math
import sequtils

const
    MoonDimensions = 3

type
    MoonPosition = array[1 .. MoonDimensions, int]
    MoonVelocity = array[1 .. MoonDimensions, int]
    Moon = tuple[p: MoonPosition, v: MoonVelocity]
    Moons = seq[Moon]

proc `$`(m: Moon): string =
    fmt"pos=<x={m.p[1]}, y={m.p[2]}, z={m.p[3]}>, vel=<x={m.v[1]}, y={m.v[2]}, z={m.v[3]}>"

proc `$`*(ms: Moons): string =
    for m in ms:
        if result.len > 0:
            result.add('\n')
        result.add($m)

proc updateVelocities(moons: var Moons) =
    for i in moons.low..moons.high:
        for j in moons.low..moons.high:
            for dim in 1..MoonDimensions:
                if moons[i].p[dim] < moons[j].p[dim]:
                    moons[i].v[dim].inc
                    moons[j].v[dim].dec

proc updatePositions(moons: var Moons) =
    for i in moons.low..moons.high:
        moons[i].p[1].inc(moons[i].v[1])
        moons[i].p[2].inc(moons[i].v[2])
        moons[i].p[3].inc(moons[i].v[3])

proc step*(moons: var Moons) =
    moons.updateVelocities()
    moons.updatePositions()

proc parseMoon(s: string, m: var Moon): bool =
    result = s.scanf("<x=$i, y=$i, z=$i>", m.p[1], m.p[2], m.p[3])

proc parseInput*(s: string): Moons =
    var
        m: Moon
    for line in s.splitlines:
        if line.parseMoon(m):
            result.add(m)

proc calculateKineticEnergy(moon: Moon): int =
    result = sum(map(moon.v, proc (x:int): int = abs(x)))

proc calculatePotentialEnergy(moon: Moon): int =
    result = sum(map(moon.p, proc (x:int): int = abs(x)))

proc calculateEnergy(moons: Moons): int =
    for moon in moons:
        result.inc(calculateKineticEnergy(moon) * calculatePotentialEnergy(moon))

proc totalEnergyAfter*(inp: string, steps: int): int =
    var
        moons = parseInput(inp)
    for i in 1..steps:
        moons.step()
    moons.calculateEnergy()

proc isRepeat1D(m1, m2: Moons, d: int): bool =
    result = true
    for i in m1.low..m1.high:
        if m1[i].p[d] != m2[i].p[d] or m1[i].v[d] != m2[i].v[d]:
            return false

proc sgd(a, b : int64) : int64 =
    var aa = a
    var bb = b
    while bb > 0:
        result = bb
        bb = aa mod bb
        aa = result
    result = aa

proc mgn(a, b: int64) : int64 =
    return (a div sgd(a, b)) * b

proc firstRepeatAfter*(input: string): int64 =
    let
        initialMoons = parseInput(input)
    var
        moons = parseInput(input)
        cycles: array[1..MoonDimensions, int]
        steps = 0
    result = 1
    for d in 1..MoonDimensions:
        cycles[d] = -1
    while any(cycles, proc (x:int):bool = x < 0):
        moons.step()
        steps.inc
        for d in 1..MoonDimensions:
            if cycles[d] < 0 and isRepeat1D(initialMoons, moons, d):
                cycles[d] = steps
                result = mgn(result, steps)
