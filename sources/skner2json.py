import sys
import json
# https://spacy.io/api/data-formats#training
#from spacy.gold import offsets_from_biluo_tags
#from spacy.gold import iob_to_biluo

def bio2bliou(ners):
    state = 0
    ners1 = []
    # add U
    for i,ner in enumerate(ners):
        ners1.append(list(ner))
        if i > 0 and ners[i-1][0] != "B" and ners[i-1][0]!= "I" and ner[0] == "I":
            ners1[i][0] = "B"
            print("fixed")
    ners = ners1
    ners1 = []
    for i,ner in enumerate(ners):
        ners1.append(ner)
        if i > 0 and ners[i-1][0] == "B" and ner[0] != "I" and ner !="O":
            ners1[i-1][0] = "U"
        if i > 1 and (ners[i-2][0] == "I" or ners[i-2][0] == "B") and ners[i-1][0] == "I" and ners[i][0] != "I":
            ners1[i-1][0] = "L"
    if len(ners) == 1 and ners[0][0] == "I":
        ners1[0][0] = "U"
    if len(ners) > 1 and ners[-1][0] == "B":
        ners1[-1][0] = "U"
    if len(ners) > 0 and ners[-1][0] == "I":
        ners1[-1][0] = "L"
    ners2 = []
    for nerlist in ners1:
        ners2.append("".join(nerlist))
    #if len(ners2) == 2:
    return ners2

def save_sentences(sentences,filename):
    paragraphs = []
    for id,sentence in enumerate(sentences):
        tokens = []
        words = []
        for word,tag in sentence:
            words.append(word)
            tokens.append({"orth":word,"ner":tag})
        paragraphs.append({"id":id,"paragraphs":[{"raw":" ".join(words),"sentences":[{"tokens":tokens}]}]})
    with open(filename,"w") as f:
        json.dump(paragraphs,f)


def strippunct(word):
    chars = list(word)
    repl = "\"' ,.()"
    if not word[0].isalpha():
        chars[0] = "x"
    if not word[-1].isalpha():
        chars[-1] = "x"
    #if not word.isalpha():
    #    print(word)
    #for c in word:
    #    if c in repl:
    #        c="x"
    #    chars.append(c)
    return "".join(chars)

def process_data(filename):
    with open(filename) as f:
        sentences = []
        words = []
        ners = []
        for l in f:
            line = l.strip()
            if len(line) > 0:
                tokens = l.split()
                word = tokens[0].strip()
                ner = tokens[-1].strip()
                #word = strippunct(word)
                if len(ner) > 1 and ner[1] == "-":
                    word = strippunct(word)
                    if len(word) == 0:
                        continue
                words.append(word)
                ners.append(ner)
            else:
                #print(ners)
                ners = bio2bliou(ners)
                sentence = []
                for word,tag in zip(words,ners):
                    sentence.append((word,tag))
                #print(sentence)
                sentences.append(sentence)
                del ners[:]
                del words[:]
    testset = []
    trainset = []
    for i,sentence in enumerate(sentences):
        if i % 10 == 0:
            testset.append(sentence)
        else:
            trainset.append(sentence)

    save_sentences(trainset,"train.json")
    save_sentences(testset,"test.json")

process_data(sys.argv[1])
