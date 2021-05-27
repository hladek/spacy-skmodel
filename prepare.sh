#conda install -c pytorch cupy pytorch cudatoolkit=9.2
#conda install -c conda-forge spacy ray-all
# packages only available via pip
#pip install spacy-transformers spacy-lookups-data
#spacy init config config.cfg -l sk -p tagger,parser
mkdir -p input

# Prepare treebank
cat ./sources/slovak-treebank/stb.conll ./sources/ud-artificial-gapping/sk-ud-crawled-orphan.conllu | python ./treebank2json.py input/train.json input/test.json
spacy convert input/train.json input
spacy convert input/test.json input

# Prepare skner
python skner2json.py ./sources/skner/wikiann-sk.bio  input/train-ner.json input/test-ner.json
spacy convert input/train-ner.json input
spacy convert input/test-ner.json input
