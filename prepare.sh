#spacy init config config.cfg -l sk -p tagger,parser
mkdir -p input
cd sources
make
cd ..
make all

