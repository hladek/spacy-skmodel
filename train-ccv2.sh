FLAGS="-g 3 --n-iter 10"
OUTDIR=outccv2
rm -r $OUTDIR
mkdir -p $OUTDIR
spacy init-model sk $OUTDIR/basic -v ./input/cc.sk.300.vec.gz  -V 600000

# Train dependency and POS
spacy train sk $OUTDIR/posparser input/slovak-treebank input/ud-artificial-gapping  -p tagger,parser -b $OUTDIR/basic $FLAGS 

spacy train sk $OUTDIR/ner input/skner/train.json input/skner/test.json -p ner  -R -b $OUTDIR/basic $FLAGS

