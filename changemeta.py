import json
import sys

with open(sys.argv[1]) as f:
    doc = json.load(f)
    doc["name"] = "sk1cc"
    doc["version"] = "3.0.0"
    doc["description"] = "Slovak model with word vectors"
    doc["author"] = "Daniel Hládek"
    doc["email"] = "daniel.hladek@tuke.sk"
    doc["url"] = "https://nlp.kemt.fei.tuke.sk"
    doc["license"] = "BSD"
    if "disabled" in doc:
        del doc["disabled"]
    doc["pipeline"] = ["tagger","parser","ner"]

with open(sys.argv[1],"w") as f:
    json.dump(doc,f,indent=4)

