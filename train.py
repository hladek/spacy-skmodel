#!/usr/bin/env python
# coding: utf8
# https://raw.githubusercontent.com/explosion/spaCy/master/examples/training/train_ner.py
"""Example of training spaCy's named entity recognizer, starting off with an
existing model or a blank model.

For more details, see the documentation:
* Training: https://spacy.io/usage/training
* NER: https://spacy.io/usage/linguistic-features#named-entities

Compatible with: spaCy v2.0.0+
Last tested with: v2.2.4
"""
from __future__ import unicode_literals, print_function

import plac
import random
import warnings
from pathlib import Path
import spacy
from spacy.util import minibatch, compounding

from spacy.gold import offsets_from_biluo_tags
from spacy.gold import iob_to_biluo
from spacy.gold import GoldParse

def read_iob(nlp, filename):
    words = []
    ners = []
    training_data = []
    with open(filename) as f:
        for l in f:
            line = l.strip()
            if len(line) > 0:
                tokens = l.split()
                word = tokens[0]
                ner = tokens[-1]
                words.append(word)
                ners.append(ner)
            else:
                biluo = iob_to_biluo(ners)
                text = " ".join(words)
                doc = nlp(text)
                spans = offsets_from_biluo_tags(doc,biluo) 
                training_data.append((doc,GoldParse(doc,entities=spans)))
                del ners[:]
                del words[:]
        return training_data


@plac.annotations(
    model=("Model name. Defaults to blank 'en' model.", "option", "m", str),
    output_dir=("Optional output directory", "option", "o", Path),
    training_data=("IOB Training data", "option", "t", Path),
    n_iter=("Number of training iterations", "option", "n", int),
)
def main(model=None, output_dir=None,training_data=None, n_iter=100):
    """Load the model, set up the pipeline and train the entity recognizer."""
    if model is not None:
        nlp = spacy.load(model)  # load existing spaCy model
        print("Loaded model '%s'" % model)
    else:
        nlp = spacy.blank("sk")  # create blank Language class
        print("Created blank 'sk' model")

    # create the built-in pipeline components and add them to the pipeline
    # nlp.create_pipe works for built-ins that are registered with spaCy
    if "ner" not in nlp.pipe_names:
        ner = nlp.create_pipe("ner")
        nlp.add_pipe(ner, last=True)
    # otherwise, get it so we can add labels
    else:
        ner = nlp.get_pipe("ner")

    nlp3 = spacy.blank("sk")
    DATA =  read_iob(nlp3,training_data)
    random.shuffle(DATA)
    data_sz = len(DATA)
    test_sz = int(data_sz / 10)
    TRAIN_DATA = DATA[:-test_sz]
    TEST_DATA = DATA[-test_sz:]
    ents = ["LOC","ORG","PER","MISC"]
    for ent in ents:
        ner.add_label(ent)
    # add labels
    #for _, annotations in TRAIN_DATA:
    #    for ent in annotations.get("entities"):
    #        ner.add_label(ent[2])

    # get names of other pipes to disable them during training
    pipe_exceptions = ["ner", "trf_wordpiecer", "trf_tok2vec"]
    other_pipes = [pipe for pipe in nlp.pipe_names if pipe not in pipe_exceptions]
    # only train NER
    with nlp.disable_pipes(*other_pipes) and warnings.catch_warnings():
        # show warnings for misaligned entity spans once
        warnings.filterwarnings("once", category=UserWarning, module='spacy')

        # reset and initialize the weights randomly – but only if we're
        # training a new model
        #if model is None:
        nlp.begin_training()
        for itn in range(n_iter):
            random.shuffle(TRAIN_DATA)
            losses = {}
            # batch up the examples using spaCy's minibatch
            batches = minibatch(TRAIN_DATA, size=compounding(4.0, 32.0, 1.001))
            for batch in batches:
                texts, annotations = zip(*batch)
                nlp.update(
                    texts,  # batch of texts
                    annotations,  # batch of annotations
                    drop=0.5,  # dropout - make it harder to memorise data
                    losses=losses,
                )
            print("Losses", losses)

    # save model to output directory
    if output_dir is not None:
        output_dir = Path(output_dir)
        if not output_dir.exists():
            output_dir.mkdir()
        nlp.to_disk(output_dir)
        print("Saved model to", output_dir)

        # test the saved model
        print("Loading from", output_dir)
        nlp2 = spacy.load(output_dir)
        scorer = spacy.Scorer()
        for text, gold in TEST_DATA:
            doc = nlp2(text)
            scorer.score(doc,gold)
        print("Precision: {}".format(scorer.ents_p))
        print("Recall: {}".format(scorer.ents_r))
        print("F-measure: {}".format(scorer.ents_f))
        print(scorer.ents_per_type)


if __name__ == "__main__":
    plac.call(main)

