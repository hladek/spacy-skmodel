all: input/sk_snk-ud-test.spacy input/sk_snk-ud-train.spacy input/train-ner.spacy input/vectors/config.cfg

sources/slovak-treebank/sk_snk-ud-test.conllu:
	mkdir -p sources/slovak-treebank
	cd sources && wget -P slovak-treebank https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-test.conllu

sources/slovak-treebank/sk_snk-ud-train.conllu:
	mkdir -p sources/slovak-treebank
	cd sources && wget -P slovak-treebank https://raw.githubusercontent.com/UniversalDependencies/UD_Slovak-SNK/master/sk_snk-ud-train.conllu

sources/floret/vectors.floret.gz:
	mkdir -p sources/floret
	cd sources && wget -P floret https://files.kemt.fei.tuke.sk/models/fasttext/sk-fastext-floretvec-skweb2021/vectors.floret.gz  --no-check-certificate

input/sk_snk-ud-test.spacy: sources/slovak-treebank/sk_snk-ud-test.conllu
	mkdir -p input
	spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-test.conllu input

input/sk_snk-ud-train.spacy: sources/slovak-treebank/sk_snk-ud-train.conllu
	mkdir -p input
	spacy convert -n 10 sources/slovak-treebank/sk_snk-ud-train.conllu input

input/train-ner.spacy: sources/skner/wikiann-sk.bio
	python skner2json.py ./sources/skner/wikiann-sk.bio input/train-ner.json input/test-ner.json
	spacy convert input/train-ner.json input
	spacy convert input/test-ner.json input

input/vectors/config.cfg: sources/floret/vectors.floret.gz
	mkdir -p input/vectors
	spacy init vectors sk sources/floret/vectors.floret.gz input/vectors -V -m floret
