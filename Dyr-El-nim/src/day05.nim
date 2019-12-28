import intcodecpu
    
proc run*(prog: string, userInput: int): int =
    var
        cpu = newCpu(prog)
    cpu.inp(userInput)
    cpu.run()
    while not cpu.outpIsEmpty():
        result = int(cpu.outp)