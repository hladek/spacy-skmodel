FLAGS="-g 3 --n-iter 10"
rm -r ccout
mkdir -p ccout
spacy init-model sk ccout/basic -v ./input/cc.sk.300.vec.gz  -V 600000

# Train dependency and POS
spacy train sk ccout/posparser input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -b ccout/basic $FLAGS 

spacy train sk ccout/ner input/skner/train.json input/skner/test.json -p ner  -R -b ccout/basic $FLAGS

