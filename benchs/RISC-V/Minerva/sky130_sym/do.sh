#!/bin/sh
doit clean_flow
doit b2v
doit layout 2>&1 | tee layout.log
MBK_OUT_LO=al cougar -w minerva_cpu_cts_r
lvx  vst al minerva_cpu_cts_r minerva_cpu_cts_r -a |tee lvx.log
