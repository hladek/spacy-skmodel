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

#with open(sys.argv[1],"w") as f:
json.dump(doc,sys.stdout,indent=4)

