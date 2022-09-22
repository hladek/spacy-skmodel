# Slovak Spacy Model

This is Slovak Spacy model.

## Features

- Requires Spacy 3.x.
- Contains Floret Word Vectors.
- Tagger module uses Slovak National Corpus Tagset.
- Morphological analyzer uses Universal dependencies tagset and is trained on Slovak dependency treebank.
- Lemmatizer is trained on Slovak dependency treebank.
- Named entity recognizer is trained separately on WikiAnn database.


## Downloads 

# Version 3.4

- [Spacy 3.4, Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_dep_web_md-3.4.0.tar.gz). 
    - Model for trained lemmatization, POS tagging and dependency relations. 
    - Contains Floret Word Vectors, trained on our web corpus.
    - Should be without license issues.

- [Spacy 3.0, NER + Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_core_web_md-3.4.0.tar.gz). 
    - Includes the dependencies model.
    - This model uses separate fine-tuned model for NER recognition. 

# Version 3.3

- [Spacy 3.3, Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_dep_web_md-3.3.0.tar.gz). Model for trained lemmatization, POS tagging and dependency relations. 
- [Spacy 3.3, NER + Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_core_web_md-3.3.0.tar.gz). This model uses separate fine-tuned model for NER recognition. 

These models do not have word vectors. 

## Training

Requirements for training:

- Anaconda virtual environment
- Spacy 3
- make
- bash

Usage:

1. Install dependencies in the Conda

    ./prepare-env.sh

2. Download and prepare data:

    make

3. Train models

    ./train.sh

## Credits 

Author:

Daniel Hládek daniel.hladek@tuke.sk and Technical University of Košice

Sources:

- The model uses spacy-transformers and [SlovakBERT](https://huggingface.co/gerulata/slovakbert).
- [Part of Speech and Dependency relations](https://github.com/UniversalDependencies/UD_Slovak-SNK)
The Slovak UD treebank with  Creative Commons - Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
- [Semi-automatic named entities](https://huggingface.co/datasets/wikiann) -  Unspecified License

