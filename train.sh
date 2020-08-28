set -e
OUTDIR=build/train/output
TRAINDIR=build/train
mkdir -p $TRAINDIR 
mkdir -p $OUTDIR
mkdir -p dist
# Delete old training results
rm -rf $OUTDIR/*
# Train dependency and POS
spacy train sk $OUTDIR ./build/input/slovak-treebank ./build/input/ud-artificial-gapping  --n-iter 15 -p tagger,parser
mv $OUTDIR/model-best $TRAINDIR/posparser
rm -r $OUTDIR/*
# Train NER
python ./train.py -t ./sources/skner/wikiann-sk.bio -o $TRAINDIR/nerposparser -n 10 -m $TRAINIR/posparser/
#spacy train sk $OUTDIR ./build/input/skner-train/ ./build/input/skner-test/  --n-iter 15 -b $TRAINDIR/posparser
# Package model
spacy package $TRAINDIR/nerposparser dist --meta-path ./meta.json --force
cd dist/sk_sk1-0.1.0
python ./setup.py sdist --dist-dir ../
