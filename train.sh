set -e # fail on error

make # prepare data

export CUDA_VISIBLE_DEVICES=0
VERSION=3.4.0
# cleanup old results
rm -rf dist
mkdir -p dist
mkdir -p train
mkdir -p train/sposparser
# Train POS and dependencies
#spacy train config-transformer.cfg -o ./train/sposparser -g 0 > ./train/sposparser/train.log 2> ./train/sposparser/train.err.log
# Package POS
#spacy package -m meta.json -F train/sposparser/model-best dist
#cd dist/sk_dep_web_md-$VERSION
#python ./setup.py sdist
# install to include pos and dependencies in new model
# name must be the same as in meta.json
#pip install dist/sk_dep_web_md-$VERSION.tar.gz
#cd ../../
mkdir -p train/snerposparser
# Train NER, copy POS and dep from old model
spacy train config-transformer-ner.cfg -o ./train/snerposparser -g 0 > ./train/snerposparser/train.log 2> ./train/snerposparser/train.err.log
# Correct meta
cp ./train/snerposparser/model-best/meta.json ./train/snerposparser/model-best/meta-ner.json
python changemeta.py ./train/sposparser/model-best ./train/snerposparser/model-best
# Package result
spacy package --version $VERSION train/snerposparser/model-best dist
cd dist/sk_core_web_md-$VERSION 
python ./setup.py sdist
