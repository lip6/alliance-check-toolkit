#!/bin/bash

   alcTkTop="../../../.."
 resultsDir="lepka/20211123"

 pushd "$resultsDir" > /dev/null 2>&1
 if [ ! -f "./results.tex" ]; then ln -s ../../results.tex .; fi
 ${alcTkTop}/bin/results2TeX.py --results-dir=.
 latex results.tex
 latex results.tex
 dvipdf results
 popd > /dev/null 2>&1
