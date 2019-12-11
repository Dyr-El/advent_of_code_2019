#!/usr/bin/env python3

def readFile(filename):
    with open(filename) as file:
        while True:
            data = file.readline()
            if not data:
                break
            yield data.strip()

def getIntsFromFile(filename):
    return map(lambda x: int(x), readFile(filename))

def getCommaSeparatedIntsFromFile(filename):
    with open(filename) as file:
        str = file.readline()
    return list(map(int, str.split(",")))
