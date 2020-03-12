
#mkdir build
#mkdir build/input
#mkdir build/input/slovak-treebank
#spacy convert ./sources/slovak-treebank/stb.conll ./build/input/slovak-treebank
#mkdir build/input/ud-artificial-gapping
#spacy convert ./sources/ud-artificial-gapping/sk-ud-crawled-orphan.conllu ./build/input/ud-artificial-gapping
#mkdir build/skner
cat ./sources/skner/wikiann-sk.bio | python ./sources/bio-to-iob.py > build/skner/wikiann-sk.iob
spacy convert -n 10 --converter ner ./build/skner/wikiann-sk.iob ./build/slovak-treebank
