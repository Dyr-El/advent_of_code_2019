import strutils

proc fuelForMass*(mass: int): int =
    result = mass div 3 - 2

proc solution1*(input: string): int =
    for line in input.splitLines:
        let
            mass = line.parseInt
        result.inc(fuelForMass(mass))

proc fuelForAllMass*(mass: int): int =
    let
        thisMass = fuelForMass(mass)
    if thisMass > 0:
        result = thisMass + fuelForAllMass(thisMass)

proc solution2*(input: string): int =
    for line in input.splitLines:
        let
            mass = line.parseInt
        result.inc(fuelForAllMass(mass))