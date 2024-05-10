#!/bin/sh
doit clean_flow
doit b2v
doit layout 2>&1 | tee layout.log

if [ "x$1" = "xcheck" ]; then
	MBK_OUT_LO=al cougar -w adder_r
	lvx  vst al adder_r adder_r -a |tee lvx.log
fi
