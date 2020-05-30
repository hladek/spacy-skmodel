import sys

buf = []

name = sys.argv[1]
counter = 0

trainfile = open(name+".train","w")
testfile = open(name+".test","w")

for l in sys.stdin:
    line = l.rstrip()
    buf.append(line)
    if len(buf) > 0 and len(line) == 0:
        f = trainfile
        if counter % 10 == 1:
            f = testfile
        print("\n".join(buf),file=f)
        counter += 1
        del buf[:]

trainfile.close()
testfile.close()


