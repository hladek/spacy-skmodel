set -e
mkdir -p input
mkdir -p output
mkdir -p dist
FLAGS="-g 1"

# Delete old training results
mkdir -p posparser
# Train dependency and POS
spacy train sk posparser input/slovak-treebank input/ud-artificial-gapping  --n-iter 10 -p tagger,parser -m "./meta.json" $FLAGS
mkdir -p nerposparser
# Train NER
spacy train sk nerposparser input/skner/train.json input/skner/test.json -p ner -b posparser/model-final --n-iter 10 $FLAGS
# Package model
rm -rf dist
mkdir -p dist
spacy package nerposparser/model-final dist
cd dist/sk_sk1-0.3.0
python ./setup.py sdist --dist-dir ../

