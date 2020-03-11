mkdir build
mkdir build/input
mkdir build/input/slovak-treebank
mkdir build/input/ud-artificial-gapping
spacy convert ./sources/slovak-treebank/stb.conll ./build/input/slovak-treebank
spacy convert ./sources/ud-artificial-gapping/sk-ud-crawled-orphan.conllu ./build/input/ud-artificial-gapping
