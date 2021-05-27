rm -r ccout3
mkdir ccout3
spacy init vectors sk ./input/cc.sk.300.vec.gz ccout3 -n fastweb --prune 600000
rm -r train
mkdir -p train
spacy train config.cfg -o ./train -g 1
