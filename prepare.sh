#conda install -c pytorch cupy pytorch cudatoolkit=9.2
#conda install -c conda-forge spacy ray-all
# packages only available via pip
#pip install spacy-transformers spacy-lookups-data
#spacy init config config.cfg -l sk -p tagger,parser
mkdir -p input

# get the treebank
cd sources/slovak-treebank
wget https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-train.conllu
wget https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-test.conllu
wget https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-dev.conllu
cd ../..
# Prepare treebank

spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-test.conllu input
spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-train.conllu input
# spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-dev.conllu input

# Prepare skner
python skner2json.py ./sources/skner/wikiann-sk.bio  input/train-ner.json input/test-ner.json
spacy convert input/train-ner.json input
spacy convert input/test-ner.json input

# Prepare vectors
mkdir input
cd input
wget https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.sk.300.vec.gz


# cleanup old training
rm -r train
mkdir -p train
# prepare vectors
rm -r train/vectors
mkdir train/vectors
spacy init vectors sk ./input/cc.sk.300.vec.gz train/vectors -n fastweb --prune 600000
