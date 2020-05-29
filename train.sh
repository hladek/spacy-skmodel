set -e
OUTDIR=build/train/output
mkdir -p build/train
mkdir -p $OUTDIR
mkdir -p dist
# Delete old training results
rm -r $OUTDIR/*
# Train dependency and POS
spacy train sk $OUTDIR ./build/input/slovak-treebank ./build/input/ud-artificial-gapping --pipeline tagger,parser --n-iter 10
# Package model
spacy package $OUTDIR/model-best dist --meta-path ./meta.json --force
cd dist/sk_sk1-0.0.1
python ./setup.py sdist --dist-dir ../
