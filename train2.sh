set -e # fail on error
export CUDA_VISIBLE_DEVICES=0
# cleanup old results
rm -rf dist
mkdir -p dist
mkdir -p train
mkdir -p train/sposparser
# Train POS and dependencies
spacy train config-transformer.cfg -o ./train/sposparser -g 0 > ./train/sposparser/train.log 2> ./train/sposparser/train.err.log
# Package POS
mkdir dist/sposparser
spacy package train/sposparser/model-best dist/sposparser
# install to include pos and dependencies in new model
pip install --force dist/sposparser/sk_pipeline-0.0.0/dist/sk_pipeline-0.0.0.tar.gz
mkdir -p train/snerposparser
# Train NER, copy POS and dep from old model
spacy train config-transformer-ner.cfg -o ./train/snerposparser -g 0 > ./train/snerposparser/train.log 2> ./train/snerposparser/train.err.log
# Correct meta
cp ./train/snerposparser/model-best/meta.json ./train/snerposparser/model-best/meta-ner.json
python changemeta.py ./train/sposparser/model-best ./train/snerposparser/model-best
# Package result
mkdir dist/snerposparser
spacy package train/snerposparser/model-best dist/snerposparser
