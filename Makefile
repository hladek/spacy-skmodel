all: input/sk_snk-ud-test.spacy input/sk_snk-ud-train.spacy input/train_ner.spacy

sources/slovak-treebank/sk_snk-ud-test.conllu:
	mkdir -p sources/slovak-treebank
	cd sources && wget -P slovak-treebank https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-test.conllu

sources/slovak-treebank/sk_snk-ud-train.conllu:
	mkdir -p sources/slovak-treebank
	cd sources && wget -P slovak-treebank https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-train.conllu

input/sk_snk-ud-test.spacy: sources/slovak-treebank/sk_snk-ud-test.conllu
	mkdir -p input
	spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-test.conllu input

input/sk_snk-ud-train.spacy: sources/slovak-treebank/sk_snk-ud-train.conllu
	mkdir -p input
	spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-train.conllu input

#input/cc.sk.300.vec.gz:
#	# Prepare vectors
#	wget -P input https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.sk.300.vec.gz

#input/vectors/config.cfg: ./input/cc.sk.300.vec.gz
#	mkdir -p input/vectors
#	spacy init vectors sk ./input/cc.sk.300.vec.gz input/vectors -n fastweb --prune 600000

input/train_ner.spacy:
	python skner2json.py ./sources/skner/wikiann-sk.bio  input/train-ner.json input/test-ner.json
	spacy convert input/train-ner.json input
	spacy convert input/test-ner.json input
