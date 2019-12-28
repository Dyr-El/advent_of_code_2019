import complex
import hashes
import math
import sequtils
import tables

import intcodecpu

proc hash(c: Complex32): Hash =
    var h: Hash = 0
    h = h !& hash(c.re)
    h = h !& hash(c.im)
    result = !$h

proc hullPattern(tbl: Table[Complex32, int]): string =
    var
        keys = newSeqOfCap[Complex32](tbl.len)
    for key in tbl.keys:
        keys.add(key)
    let
        xmin = min(map(keys, proc (x: Complex32): float32 = x.re))
        xmax = max(map(keys, proc (x: Complex32): float32 = x.re))
        ymin = min(map(keys, proc (x: Complex32): float32 = x.im))
        ymax = max(map(keys, proc (x: Complex32): float32 = x.im))
    var
        x = xmin
        y = ymax
    while y >= ymin:
        x = xmin
        while x <= xmax:
            if tbl.getOrDefault(complex32(x, y), 0) == 1:
                result.add('*')
            else:
                result.add(' ')
            x += 1
        result.add('\n')
        y -= 1

proc paintShip(prog: string, startPos: Complex32, startWhite: bool): Table[Complex32, int] =
    const 
        leftTurn = 0
    var cpu = newCpu(prog)
    var position = startPos
    var heading = complex32(0.0, 1.0)
    if startWhite:
        result[position] = 1
    while cpu.state != PSHalted:
        cpu.inp(result.getOrDefault(position, 0))
        cpu.run()
        if not cpu.outpIsEmpty:
            let color = int(cpu.outp())
            let turn = cpu.outp()
            result[position] = color
            if turn == leftTurn:
                heading = heading * complex32(0.0, 1.0)
            else:
                heading = heading * complex32(0.0, -1.0)
            position = position + heading

proc numberOfPaintedPanels*(prog: string): int =
    result = paintShip(prog, complex32(0, 0), false).len

proc registrationId*(prog: string): string =
    let hullPaint = paintShip(prog, complex32(0, 0), true)
    result = hullPattern(hullPaint)