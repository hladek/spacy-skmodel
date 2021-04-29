FLAGS="-g 0 --n-iter 10"
#rm -r ccout
#mkdir -p ccout
#spacy init-model sk ccout/basic -v ./input/cc.sk.300.vec.gz  -V 600000

# Train dependency and POS
#spacy train sk ccout/posparser input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -b ccout/basic $FLAGS 

# spacy train sk ccout/ner input/skner/train.json input/skner/test.json -p ner  -R -b ccout/basic $FLAGS

## Assemle model
mkdir -p ccout/nerposparser
cp -r ccout/posparser/model-final/* ccout/nerposparser
cp -r ccout/ner/model-final/ner ccout/nerposparser
python ./assemble.py meta-cc.json ccout/ner/model-final/meta.json ccout/posparser/model-final/meta.json ccout/nerposparser/meta.json

# Make python package
mkdir -p ccout/dist
spacy package ccout/nerposparser ccout/dist
DNAME=`ls ccout/dist`
cd ccout/dist/$DNAME
python ./setup.py sdist --dist-dir ../
