#rm -r train
#mkdir -p train
#rm -r train/vectors
#mkdir train/vectors
#spacy init vectors sk ./input/cc.sk.300.vec.gz train/vectors -n fastweb --prune 600000
spacy train config.cfg -o ./train/posparser -g 1
# Make python package
mkdir -p dist
mkdir dist/posparser
spacy package train/posparser/model-final dist/posparser
pip install --force dist/posparser/sk_pipeline-0.0.0/dist/sk_pipeline-0.0.0.tar.gz
spacy train config-ner.cfg -o ./train/nerposparser -g 1
python changemeta.py ./train/nerposparser/model-best/meta.json
mkdir dist/nerposparser
spacy package train/nerposparser/model-best dist/nerposparser
#cd dist/nerposparser/sk_sk1cc-3.0.0
#python ./setup.py sdist --dist-dir ../
