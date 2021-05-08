import sys
import json
# https://spacy.io/api/data-formats#training
#from spacy.gold import offsets_from_biluo_tags
#from spacy.gold import iob_to_biluo

dataset = []

def save_data(filename,dataset):
    pass


def process_data(filename):
    with open(filename) as f:
        sentence = []
        for l in f:
            tokens = l.split()
            head = int(tokens[5])
            id = int(tokens[0])
            if id == 1 and len(sentence) > 0:
                dataset.append(sentence)
                del sentence[:]
            token = {
                "id": id,
                "orth": tokens[1],
                "tag": tokens[3],
                # "ner":
                "head": id - head,
                "dep": tokens[6],
            }
            sentence.append(token)
        trainset = []
        testset = []
        for i, item in enumerate(dataset):
            if i % 10 == 0:
                testset.append(item)
            else:
                trainset.append(item)

process_data(sys.argv[1])
