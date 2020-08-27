mkdir -p build
mkdir -p build/input
# Prepare Treebank
mkdir -p build/input/slovak-treebank
spacy convert ./sources/slovak-treebank/stb.conll ./build/input/slovak-treebank
# UDAG used as evaluation
mkdir -p build/input/ud-artificial-gapping
spacy convert ./sources/ud-artificial-gapping/sk-ud-crawled-orphan.conllu ./build/input/ud-artificial-gapping
# Prepare skner
mkdir -p build/input/skner
# Convert to IOB
cat ./sources/skner/wikiann-sk.bio | python ./sources/bio-to-iob.py > build/input/skner/wikiann-sk.iob
# Split to train test
cat ./build/input/skner/wikiann-sk.iob | python ./sources/iob-to-traintest.py ./build/input/skner/wikiann-sk
# Convert train and test
mkdir -p build/input/skner-train
spacy convert -n 15 --converter ner ./build/input/skner/wikiann-sk.train ./build/input/skner-train
mkdir -p build/input/skner-test
spacy convert -n 15 --converter ner ./build/input/skner/wikiann-sk.test ./build/input/skner-test
