conda install -c conda-forge -c pytorch spacy cupy pytorch cudatoolkit=9.2
# packages only available via pip
pip install spacy-transformers spacy-lookups-data
spacy init config config.cfg -l sk -p tagger,parser
