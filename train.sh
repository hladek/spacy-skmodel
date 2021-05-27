rm -r train
mkdir -p train
rm -r train/vectors
mkdir train/vectors
spacy init vectors sk ./input/cc.sk.300.vec.gz train/vectors -n fastweb --prune 600000
spacy train config.cfg -o ./train/posparser -g 1

# Make python package
mkdir -p dist
spacy package train/posparser/model-final dist
cd dist/sk_pipeline-0.0.0
python ./setup.py install
cd ../../
spacy train config-ner.cfg -o ./train/nerposparser -g 1
python changemeta.py ./train/nerposparser/model-final/meta.json
cd dist/sk_sk1cc-3.0.0
python ./setup.py sdist --dist-dir ../
