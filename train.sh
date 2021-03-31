FLAGS="-g 1 --n-iter 10"

# Delete old training results
TRAINDIR=`mktemp -d`
echo Training posparser in $TRAINDIR
# Train dependency and POS
spacy train sk $TRAINDIR input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -m "./meta.json" $FLAGS
rm -rf ./posparser
mv $TRAINDIR/model-final ./posparser
rm -rf $TRAINDIR

# Train NER
TRAINDIR=`mktemp -d`
echo Training nerposparser in $TRAINDIR
spacy train sk $TRAINDIR input/skner/train.json input/skner/test.json -p ner  -R -b posparser $FLAGS -m posparser/meta.json
rm -rf nerposparser
mv $TRAINDIR/model-final ./nerposparser
rm -rf $TRAINDIR


