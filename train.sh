mkdir build/train
mkdir build/train/output
mkdir dist
spacy train sk ./build/train/output ./build/input/slovak-treebank ./build/input/ud-artificial-gapping --pipeline tagger,parser,ner --n-iter 10
spacy package build/train/output/model-best dist --meta-path ./meta.json --force
cd dist/sk_sk1-0.0.1
python ./setup.py sdist --dist-dir ../
