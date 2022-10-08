READMEsimu.rst
==================

execute the simulation:
ngspice file.cir (interactive mode)
NB:  to plot/print internal signals: the name of the highest hierarchy level where they appear should be used.

use for example
gnuplot compall v(soc) v(eoc) v(H) 
gnuplot MSBPall v(soc) v(eoc) v(H) v(xsar_saradc1.xnandp.n1) v(xsar_saradc1.msbp) 


files * .data are generated
to post process these data with gnuplot use the script:
postcomp.plt or postMSBP.plt, ... with :

gnuplot -persist postcomp.plt   (batch mode)
gnuplot -persist postMSB.plt   (batch mode)

