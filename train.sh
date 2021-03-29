set -e
mkdir -p input
mkdir -p traindir
rm -rf ./traindir/*
mkdir -p dist
FLAGS="-g 1"

# Delete old training results
mkdir -p posparser
# Train dependency and POS
spacy train sk traindir input/slovak-treebank input/ud-artificial-gapping  --n-iter 10 -p tagger,parser -m "./meta.json" $FLAGS
rm -rf ./posparser
mv traindir/model-final ./posparser
rm -rf ./traindir/*
# Train NER
spacy train sk traindir input/skner/train.json input/skner/test.json -p ner -b posparser --n-iter 10 $FLAGS
mv traindir/model-final ./nerposparser
rm -rf nerposparser
# Package model
mkdir -p dist
rm -rf ./dist/*
spacy package nerposparser dist
cd dist/sk_sk1-0.3.0
python ./setup.py sdist --dist-dir ../

