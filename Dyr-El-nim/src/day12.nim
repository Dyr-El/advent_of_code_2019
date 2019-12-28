import strscans
import strutils
import strformat

type
    MoonPosition = tuple[x, y, z: int]
    MoonVelocity = tuple[dx, dy, dz: int]
    Moon = tuple[p: MoonPosition, v: MoonVelocity]
    Moons = seq[Moon]

proc `$`(m: Moon): string =
    fmt"pos=<x={m.p.x}, y={m.p.y}, z={m.p.z}>, vel=<x={m.v.dx}, y={m.v.dy}, z={m.v.dz}>"

proc `$`*(ms: Moons): string =
    for m in ms:
        if result.len > 0:
            result.add('\n')
        result.add($m)

proc updateVelocities(moons: var Moons) =
    for i in moons.low..moons.high:
        for j in moons.low..moons.high:
            if moons[i].p.x < moons[j].p.x:
                moons[i].v.dx.inc
                moons[j].v.dx.dec
            if moons[i].p.y < moons[j].p.y:
                moons[i].v.dy.inc
                moons[j].v.dy.dec
            if moons[i].p.z < moons[j].p.z:
                moons[i].v.dz.inc
                moons[j].v.dz.dec

proc updatePositions(moons: var Moons) =
    for i in moons.low..moons.high:
        moons[i].p.x.inc(moons[i].v.dx)
        moons[i].p.y.inc(moons[i].v.dy)
        moons[i].p.z.inc(moons[i].v.dz)

proc step*(moons: var Moons) =
    moons.updateVelocities()
    moons.updatePositions()

proc parseMoon(s: string, m: var Moon): bool =
    result = s.scanf("<x=$i, y=$i, z=$i>", m.p.x, m.p.y, m.p.z)

proc parseInput*(s: string): Moons =
    var
        m: Moon
    for line in s.splitlines:
        if line.parseMoon(m):
            result.add(m)

proc calculateKineticEnergy(moon: Moon): int =
    result = abs(moon.v.dx) + abs(moon.v.dy) + abs(moon.v.dz)

proc calculatePotentialEnergy(moon: Moon): int =
    result = abs(moon.p.x) + abs(moon.p.y) + abs(moon.p.z)

proc calculateEnergy(moons: Moons): int =
    for moon in moons:
        result.inc(calculateKineticEnergy(moon) * calculatePotentialEnergy(moon))

proc totalEnergyAfter*(inp: string, steps: int): int =
    var
        moons = parseInput(inp)
    for i in 1..steps:
        moons.step()
    moons.calculateEnergy()

proc isRepeatX(m1, m2: Moons): bool =
    result = true
    for i in m1.low..m1.high:
        if m1[i].p.x != m2[i].p.x or m1[i].v.dx != m2[i].v.dx:
            return false

proc isRepeatY(m1, m2: Moons): bool =
    result = true
    for i in m1.low..m1.high:
        if m1[i].p.y != m2[i].p.y or m1[i].v.dy != m2[i].v.dy:
            return false

proc isRepeatZ(m1, m2: Moons): bool =
    result = true
    for i in m1.low..m1.high:
        if m1[i].p.z != m2[i].p.z or m1[i].v.dz != m2[i].v.dz:
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
        cycleX = -1
        cycleY = -1
        cycleZ = -1
        steps = 0
    while cycleX < 0 or cycleY < 0 or cycleZ < 0:
        moons.step()
        steps.inc
        if cycleX < 0 and isRepeatX(initialMoons, moons):
            cycleX = steps
        if cycleY < 0 and isRepeatY(initialMoons, moons):
            cycleY = steps
        if cycleZ < 0 and isRepeatZ(initialMoons, moons):
            cycleZ = steps
    result = mgn(mgn(cycleX, cycleY), cycleZ)
