# Package model
mkdir -p dist
rm -rf ./dist/*
spacy package $1 dist
DNAME=`ls dist`
cd dist/$DNAME
python ./setup.py sdist --dist-dir ../
