Artificial dependency trees in the Universal Dependencies v2 style, focused
on gapping (the 'orphan' relation in UD). For motivation and description of
the data, see the paper cited below. Please cite the paper if you use the data
in your academic work.

@inproceedings{droganova2018,
  title     = {Parse Me if You Can: Artificial Treebanks for Parsing Experiments on Elliptical Constructions},
  author    = {Kira Droganova and Daniel Zeman and Jenna Kanerva and Filip Ginter},
  year      = {2018},
  booktitle = {Proceedings of the 11th International Conference on Language Resources and Evaluation ({LREC} 2018)},
  publisher = {European Language Resources Association},
  organization = {European Language Resource Association},
  address   = {Paris, France},
  location  = {Miyazaki, Japan},
  venue     = {Phoenix Seagaia Conference Center}
}

Permanent URI of the dataset:
http://hdl.handle.net/11234/1-2616

*-crawled-* data are crawled from the web, parsed by two parsers, filtered so
    that only those trees survive where the two parsers agree, then proceesed
    to create artificial gapping
*-{train,dev,test}-* data are based on Universal Dependency treebanks release
    2.1 (November 2017)
English and Finnish data were manually checked and modified after gapping
    structures had been automatically drafted.
Czech, Slovak and Russian data were processed only automatically.

