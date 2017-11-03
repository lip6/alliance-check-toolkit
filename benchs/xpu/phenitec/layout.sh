#!bin/bash -eu
source ./env.sh
ocp -v -ioc gates  gates gates
ocp -v -rows 2 -ioc ring ring ring
ocp -v -ioc xpu_core xpu_core xpu_core
nero -p gates gates gates
nero -p ring ring ring
nero -p xpu_core xpu_core xpu_nero

