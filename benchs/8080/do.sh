#!/bin/sh
doit clean_flow
doit b2v
doit layout 2>&1 | tee layout.log
MBK_OUT_LO=al cougar -w my80core_cts_r
lvx  vst al my80core_cts_r my80core_cts_r -a |tee lvx.log
