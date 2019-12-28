import intcodecpu

proc runProgram*(prog: string, input: seq[int64]): seq[int64] =
    result = newSeqOfCap[int64](16)
    var
        cpu =  newCpu(prog)
    for inVal in input:
        cpu.inp(inVal)
    cpu.run()
    while not cpu.outpIsEmpty():
        result.add(int64(cpu.outp))