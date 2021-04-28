FLAGS="--n-iter 10"
#rm -r out
#mkdir -p out
# Train dependency and POS
#spacy train sk out/posparser input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser $FLAGS
# Train NER
#spacy train sk out/ner input/skner/train.json input/skner/test.json -p ner  -R $FLAGS

## Assemle model
mkdir -p out/nerposparser
cp -r out/posparser/model-final/* out/nerposparser
cp -r out/ner/model-final/ner out/nerposparser
python ./assemble.py meta.json out/ner/model-final/meta.json out/posparser/model-final/meta.json out/nerposparser/meta.json

# Make python package
mkdir -p out/dist
spacy package out/nerposparser out/dist
DNAME=`ls out/dist`
cd out/dist/$DNAME
python ./setup.py sdist --dist-dir ../
