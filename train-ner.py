import spacy
from spacy.gold import offsets_from_biluo_tags

buf = []

for l in sys.stdin:
    line = l.strip()
    if len(line) > 0:
        tokens = l.split()
        word = tokens[0]
        ner = tokens[-1]
        buf.append((word,ner))
    else:
        # TODO
        pass

