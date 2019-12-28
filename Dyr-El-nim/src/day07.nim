import algorithm

import intcodecpu

proc createThruster(prog: string, setting: int): Cpu =
    result = newCpu(prog)
    result.inp(setting)

proc runThrusters*(prog: string, settings: seq[int]): int =
    var
        thrusters = newSeqOfCap[Cpu](5)
    for setting in settings:
        thrusters.add(createThruster(prog, setting))
    thrusters[0].inp(0)
    while true:
        var
            noHalted = 0
        for idx, thruster in thrusters.mpairs:
            if thruster.state == PSHalted:
                noHalted.inc
                continue
            var
                prevThruster = thrusters[(idx + len(thrusters) - 1) mod len(thrusters)]
            if not prevThruster.outpIsEmpty:
                thruster.inp(prevThruster.outp)
            thruster.run()
        if noHalted == len(thrusters):
            break
    result = int(thrusters[len(thrusters)-1].outp)

proc optimiseThrusters*(prog: string): int =
    var
        settings = @[0, 1, 2, 3, 4]
    while true:
        result = max(result, runThrusters(prog, settings))
        if not settings.nextPermutation():
            break

proc optimiseThrustersFeedback*(prog: string): int =
    var
        settings = @[5, 6, 7, 8, 9]
    while true:
        result = max(result, runThrusters(prog, settings))
        if not settings.nextPermutation():
            break