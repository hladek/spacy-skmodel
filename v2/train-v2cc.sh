FLAGS="-g 0 --n-iter 10"
OUTDIR=outccv2
rm -r $OUTDIR
mkdir -p $OUTDIR
spacy init-model sk $OUTDIR/basic -v ./input/cc.sk.300.vec.gz  -V 600000

# Train dependency and POS
spacy train sk $OUTDIR/posparser input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -b $OUTDIR/basic $FLAGS 

 spacy train sk $OUTDIR/ner input/skner/train.json input/skner/test.json -p ner  -R -b $OUTDIR/basic $FLAGS

## Assemle model
mkdir -p $OUTDIR/nerposparser
cp -r $OUTDIR/posparser/model-final/* $OUTDIR/nerposparser
cp -r $OUTDIR/ner/model-final/ner $OUTDIR/nerposparser
python ./assemble.py v2/meta-ccv2.json $OUTDIR/ner/model-final/meta.json $OUTDIR/posparser/model-final/meta.json $OUTDIR/nerposparser/meta.json

# Make python package
mkdir -p $OUTDIR/dist
spacy package $OUTDIR/nerposparser $OUTDIR/dist
DNAME=`ls $OUTDIR/dist`
cd $OUTDIR/dist/$DNAME
python ./setup.py sdist --dist-dir ../
