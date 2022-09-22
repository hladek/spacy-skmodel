import json
import sys

pos_dname = sys.argv[1]
with open(pos_dname + "/meta.json") as f:
    pos_meta = json.load(f)
    pos_performance = pos_meta["performance"]


dname = sys.argv[2]
meta_name = dname + "/meta.json"
with open(meta_name) as f:
    doc = json.load(f)
    doc["name"] = "core_web_md"
    if "disabled" in doc:
        del doc["disabled"]
    doc["pipeline"] = ["transformer","tagger","morphologizer","trainable_lemmatizer","parser","ner"]
    for k,v in pos_performance.items():
        doc["performance"][k] = v

with open(meta_name,"w") as f:
    json.dump(doc,f,indent=4)

clines = []
config_name = dname + "/config.cfg"
with open(config_name) as f:
    for l in f:
        line = l.rstrip()
        if "disabled" in line:
            line = "disabled: []"
        clines.append(line)


with open(config_name,"w") as f:
    print("\n".join(clines),file=f)
