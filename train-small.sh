set -e # fail on error

#make # prepare data

export CUDA_VISIBLE_DEVICES=0
# cleanup old results
#rm -rf dist
mkdir -p dist
mkdir -p train
TRAINDIR=train/smposparser
NERTRAINDIR=train/smnerposparser
VER=3.3.0
MODELDIR=dist/sk_dep_web_sm-$VER
NERMODELDIR=dist/sk_core_web_sm-$VER
mkdir -p $TRAINDIR 
# Train POS and dependencies
spacy train small-config.cfg -o $TRAINDIR -g 0 > $TRAINDIR/train.log 2> $TRAINDIR/train.err.log
# Package POS
spacy package -m small-meta.json -F $TRAINDIR/model-best dist
cd $MODELDIR
python ./setup.py sdist
# install to include pos and dependencies in new model
# name must be the same as in meta.json
pip install $MODELDIR.tar.gz
cd ../../
mkdir -p $NERTRAINDIR
# Train NER, copy POS and dep from old model
spacy train small-ner.cfg -o $NERTRAINDIR -g 0 > $NERTRAINDIR/train.log 2> $NERTRAINDIR/train.err.log
# Correct meta
cp $NERTRAINDIR/model-best/meta.json $NERTRAINDIR/model-best/meta-ner.json
python changemeta.py $TRAINDIR/model-best $NERTRAINDIR/model-best
# Package result
spacy package --version $VER $NERTRAINDIR/model-best dist
cd $NERMODELDIR
python ./setup.py sdist
