import json
import sys
dname = sys.argv[1]
meta_name = dname + "/meta.json"
with open(meta_name) as f:
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

with open(meta_name,"w") as f:
    json.dump(doc,f,indent=4)

clines = []
config_name = dname + "/config.cfg"
with open(config_name) as f:
    for l in f:
        line = l.rstrip()
        if "disabled" in line:
            line = "disabled: []"
        lines.append(line)

with open(config_name,"w") as f:
    print("\n".join(clines),file=f)
