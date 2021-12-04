set -e # fail on error
# cleanup old results
rm -r dist
mkdir -p dist
CUDA_VISIBLE_DEVICES=3 spacy train config.cfg -o ./train/posparser -g 0 > ./train/posparser/train.log 2> ./train/posparser/train.err.log
# Train POS and dependencies
mkdir dist/posparser
spacy package train/posparser/model-best dist/posparser
# install to include pos and dependencies in new model
pip install --force dist/posparser/sk_pipeline-0.0.0/dist/sk_pipeline-0.0.0.tar.gz
# Train NER, copy POS and dep from old model
CUDA_VISIBLE_DEVICES=3 spacy train config-ner.cfg -o ./train/nerposparser -g 0 > ./train/nerposparser/train.log 2> ./train/nerposparser/train.err.log
# Correct meta
cp ./train/nerposparser/model-best/meta.json ./train/nerposparser/model-best/meta-ner.json
python changemeta.py ./train/posparser/model-best ./train/nerposparser/model-best
# Package result
mkdir dist/nerposparser
spacy package train/nerposparser/model-best dist/nerposparser
