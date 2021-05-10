import sys
import json
# https://spacy.io/api/data-formats#training
#from spacy.gold import offsets_from_biluo_tags
#from spacy.gold import iob_to_biluo


def save_data(filename,dataset):
    sentences = []
    words = []
    docs = []
    for i,item in enumerate(dataset):
        bad = False
        for token in item:
            words.append(token["orth"])
            h = token["head"] + token["id"]
            #print(h,len(item))
            if h < 0 or  h >= len(item):
                print(item)
                bad = True
                break
        if bad:
            continue
        sentences.append({"tokens":item})
        if len(sentences) > 4:
            doc = {
                "id": i,
                "paragraphs":[{
                    "raw": " ".join(words),
                    "sentences": list(sentences)
                }]
            }
            docs.append(doc)
            del words[:]
            del sentences[:]

    if len(docs)> 0 and len(sentences)>0: 
        doc = {
            "id": docs[-1]["id"] + 1,
            "paragraphs":[{
                "raw": " ".join(words),
                "sentences": list(sentences)
            }]
        }
        docs.append(doc)
    with open(filename,"w") as f:
        json.dump(docs,f)


def process_data(trainname,testname):
    dataset = []
    sentence = []
    for l in sys.stdin:
        tokens = l.split()
        #print(tokens)
        if len(tokens)  < 2:
            if len(sentence) > 0:
                dataset.append(list(sentence))
                del sentence[:]
            continue
        head = int(tokens[6])
        id = int(tokens[0]) -1
        print(head,id)
        h = head - id
        #print(h)
        token = {
            "id": id,
            "orth": tokens[1],
            "tag": tokens[3],
            # "ner":
            "head": h,
            "dep": tokens[7],
        }
        sentence.append(token)
    trainset = []
    testset = []
    for i, item in enumerate(dataset):
        if i % 10 == 0:
            testset.append(item)
        else:
            trainset.append(item)
    save_data(trainname,trainset)
    save_data(testname,testset)

process_data(sys.argv[1],sys.argv[2])
