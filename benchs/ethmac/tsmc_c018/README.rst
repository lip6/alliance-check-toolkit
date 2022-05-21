

=====================
Notes on Ethmac block
=====================


Yosys
=====

Direct synthesis from the top level Verilog ``ethmac.v`` file do not
seems to work, even when including the sub-block description in it.

As a temporary workaround we patch the TCL Yosys script ``ethmac.tcl``
by loading the Verilog files manually one by one. This way we can
generate an ``ethmac.blif``. Once generated we keep a copy in the
``./non_generateds/`` directory.

So the ``make vst`` rule will work only if the ``blif`` file is
copied in the current directory first.

You can also completely skip the ``make vst`` stage by copying the
pre-generated ``vst`` files directly.
