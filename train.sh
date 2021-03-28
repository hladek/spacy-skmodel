set -e
OUTDIR=build/train/output
TRAINDIR=build/train
mkdir -p $TRAINDIR 
mkdir -p $OUTDIR
mkdir -p dist
# Delete old training results
rm -rf $OUTDIR/*
# Train dependency and POS
spacy train sk $OUTDIR ./build/input/slovak-treebank ./build/input/ud-artificial-gapping  --n-iter 20 -p tagger,parser
rm -rf $TRAINDIR/posparser
# Move trained model
mv $OUTDIR/model-best $TRAINDIR/posparser
# Train NER
# -m posparser loads previous model, but does not copy model
python ./train.py -t ./sources/skner/wikiann-sk.bio -o $TRAINDIR/ner -n 20 -m $TRAINDIR/posparser/
# Copy previous models to the new model
cp -r $TRAINDIR/posparser $TRAINDIR/nerposparser/
cp -r $TRAINDIR/ner/ner $TRAINDIR/nerposparser/ner
# Package model
spacy package $TRAINDIR/nerposparser dist --meta-path ./meta.json --force
cd dist/sk_sk1-0.3.0
python ./setup.py sdist --dist-dir ../
