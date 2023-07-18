
# Alliance Check Toolkit: Tests and Benchmarks for Alliance and Coriolis

This repository contains examples, benchmarks and tests for the [Coriolis](https://github.com/lip6/coriolis) VLSI toolchain and its older counterpart [Alliance](https://github.com/lip6/alliance).

It contains all kinds of designs using Coriolis for physical design (typically placement and routing).

For any question, you may contact the team on [Matrix](https://app.element.io/#/room/#coriolis:matrix.org).


# Installation

You should clone the repository in `~/coriolis-2.x/src/`, and install Coriolis and Alliance.

``` bash
# Clone the repositories
mkdir -p ~/coriolis-2.x/src/
git clone https://github.com/lip6/coriolis.git
git clone https://github.com/lip6/alliance.git
git clone https://github.com/lip6/alliance-check-toolkit.git

# Install Alliance and Coriolis
cd coriolis
bootstrap/allianceInstaller.sh
make install
```


## Example design

As an example, you can look at the Arlet6502 design in `benchs/arlet6502/cmos`. It uses [pydoit](https://github.com/pydoit/doit) to define build steps in `dodo.py`.

You can build it with:
``` bash
cd benchs/arlet6502/cmos
# Cleaning step
doit clean_flow
# Run each step individually
doit yosys
doit pnr
# You can just run this one, as it depends on the others
doit lvx
```



