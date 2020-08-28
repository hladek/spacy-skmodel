import sys
import spacy
from spacy.gold import offsets_from_biluo_tags
from spacy.gold import iob_to_biluo

def read_iob(nlp, filename):
    words = []
    ners = []
    training_data = []
    with open(filename) as f:
        for l in sys.stdin:
            line = l.strip()
            if len(line) > 0:
                tokens = l.split()
                word = tokens[0]
                ner = tokens[-1]
                words.append(word)
                ners.append(ner)
            else:
                biluo = iob_to_biluo(ners)
                text = " ".join(words)
                doc = nlp(text)
                spans = offsets_from_biluo_tags(doc,biluo) 
                training_data.append((doc,spans))
                del ners[:]
                del words[:]
        return trainig_data

