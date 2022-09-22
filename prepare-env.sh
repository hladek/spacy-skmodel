conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
pip install -U spacy[cuda113,transformers,lookups]==3.4
rm -r ./input/*
