set -e
mkdir -p input
mkdir -p dist
FLAGS="-g 1 --n-iter 2 "

# Delete old training results
mkdir -p traindir
rm -rf ./traindir/*
# Train dependency and POS
spacy train sk traindir input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -m "./meta.json" $FLAGS
rm -rf ./posparser
mv traindir/model-final ./posparser
rm -rf ./traindir/*
# Train NER
spacy train sk traindir input/skner/train.json input/skner/test.json -p ner  -R -b posparser $FLAGS -m posparser/meta.json
rm -rf nerposparser
mv traindir/model-final ./nerposparser
# Package model
mkdir -p dist
rm -rf ./dist/*
spacy package nerposparser dist
DNAME=`ls dist`
cd dist/$DNAME
python ./setup.py sdist --dist-dir ../

