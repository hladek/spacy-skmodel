mkdir build/train
mkdir build/train/output
mkdir dist
spacy train sk ./build/train/output ./build/input/slovak-treebank ./build/input/ud-artificial-gapping --pipeline tagger,parser --n-iter 10
spacy package build/train/output/model-best dist
