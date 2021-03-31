import spacy
import sys

nlp = spacy.load(sys.argv[1])
lines = []
for line in sys.stdin:
    lines.append(line.rstrip())
doc = nlp("\n".join(lines))
for token in doc:
    print(token.text, token.lemma_, token.pos_, token.tag_, token.dep_,token.shape_, token.is_alpha, token.is_stop)
