# conda install spacy=2.3.5 cupy cudatoolkit=9.2
mkdir -p input
# Prepare Treebank
mkdir -p input/slovak-treebank
spacy convert ./sources/slovak-treebank/stb.conll ./input/slovak-treebank
# UDAG used as evaluation
mkdir -p input/ud-artificial-gapping
spacy convert ./sources/ud-artificial-gapping/sk-ud-crawled-orphan.conllu ./d/input/ud-artificial-gapping
# Prepare skner
mkdir -p input/skner
cd input/skner
python ../../skner2json.py ../../sources/skner/wikiann-sk.bio

wget https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.sk.300.vec.gz
mv cc.sk.300.vec.gz ./input
