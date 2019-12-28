import intcodecpu

const NounPosition = 1
const VerbPosition = 2
const AnswerPosition:int = 0

proc setNoun(cpu: var Cpu, noun: int) =
    cpu.poke(NounPosition, noun)

proc setVerb(cpu: var Cpu, verb: int) =
    cpu.poke(VerbPosition, verb)

proc run*(prog: string, noun, verb: int): int =
    var cpu = newCpu(prog)
    cpu.setNoun(noun)
    cpu.setVerb(verb)
    cpu.run()
    return int(cpu.peek(AnswerPosition))
    
proc findNounAndVerb*(input: string, key: int): int =
    for noun in 0..99:
        for verb in 0..99:
            let res = run(input, noun, verb)
            if res == key:
                return 100 * noun + verb
