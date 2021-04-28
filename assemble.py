import sys
import json

base = sys.argv[1]
ner = sys.argv[2]
posparser = sys.argv[3]
outmeta = sys.argv[4]

meta = None
with open(base,"rb") as f:
    meta = json.load(f)

ner_meta = None
with open(ner,"rb") as f:
    ner_meta = json.load(f)
    meta["labels"]["ner"] = ner_meta["labels"]["ner"]
    meta["accuracy"]["ents_p"] = ner_meta["accuracy"]["ents_p"]
    meta["accuracy"]["ents_r"] = ner_meta["accuracy"]["ents_r"]
    meta["accuracy"]["ents_f"] = ner_meta["accuracy"]["ents_f"]
    meta["accuracy"]["ents_per_type"] = ner_meta["accuracy"]["ents_per_type"]

posparser_meta = None
with open(posparser,"rb") as f:
    posparser_meta = json.load(f)
    meta["accuracy"]["tags_acc"] = posparser_meta["accuracy"]["tags_acc"]
    meta["accuracy"]["uas"] = posparser_meta["accuracy"]["uas"]
    meta["accuracy"]["las"] = posparser_meta["accuracy"]["las"]
    meta["accuracy"]["las_per_type"] = posparser_meta["accuracy"]["las_per_type"]
    meta["labels"]["tagger"] = posparser_meta["labels"]["tagger"]

with open(outmeta,"wb") as f:
    json.dump(f)



