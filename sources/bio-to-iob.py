import sys

for l in sys.stdin:
    line = l.rstrip()
    tokens = line.split()
    if len(tokens) < 1:
        print("")
        continue
    print(tokens[0] + " " + tokens[-1])
