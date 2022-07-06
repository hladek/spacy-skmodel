# Slovak Spacy Model

This is unreleased version.

## Downloads 

- [Spacy 3.0, Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_dep_web_md-3.3.0.tar.gz). Model for trained lemmatization, POS tagging and dependency relations. 
- [Spacy 3.0, NER + Dependencies](https://files.kemt.fei.tuke.sk/models/spacy/sk_core_web_md-3.3.0.tar.gz). This model uses separate fine-tuned model for NER recognition. 

These models do not have word vectors. 

## Requirements

- Anaconda virtual environment
- Spacy 3
- make
- bash

## Usage

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
