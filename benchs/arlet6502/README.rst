Arlet's MOS6502 core
====================

This is using `Arlet's MOS 6502 core`_. The code has been adapted
to remove asynchronous reset flops.

.. _`Arlet's MOS 6502 core`: https://github.com/Arlet/verilog-6502

RTL original files are available in rtl/ 

Corrected RTL files with proper RDY handling and fixes are in corrected/
See corrected/README.md for details.

serialized contains a serialized version of the CPU. DO [7:0] and AB[15:0]
are serialized into DO_PAD [7:0]. See serialized/README.md for details.




This bench provide a wide range of target technologies:

* The ``layout`` rule generate a *symbolic* layout that is, an ``.ap`` file.

* The ``gds`` rule generate a *real* layout that is, an ``.gds`` file.

* The ``druc`` rule perform a *symbolic* DRC check.

* The ``lvx`` rule perform a *layoux vs. exctracted* check (LVS).

On real technologies, we cannot perform the DRC checks with Alliance/Coriolis.
But Magic/KLayout may in some cases.

Depending on the availability of the I/O pads in each technology, we either
provides the P&R for a core block or a full chip.

This directory also includes FPGA implementations:

corrected/FPGA_DE2-115/ contains files to implement the arlet6502 on FPGA DE2-115.
It can be used to emulate the cpu before an ASIC implementation

serialized/FPGA_DE2-115_serialized is the version implementing the serialized cpu.


.. note:: For ``freepdk45_c4m``, the PDK master from Chips4Makers must be
	  installed under ``../../../libre-soc/c4m-pdk/freepdk45``, relative
	  to the node bench directory.

+----------------+-----------+------------+-------+---------------------------+
|                |           |            |       |     Makefile rules        |
|                |           |            |       +--------+------+-----+-----+
| Node           |  Type     |  Full chip | NDA   | layout | druc | lvx | gds |
+================+===========+============+=======+========+======+=====+=====+
| cmos           |  Symbolic |  No        | No    | X      | X    | X   | -   |
+----------------+-----------+------------+-------+--------+------+-----+-----+
| cmos45         |  Symbolic |  Yes       | No    | X      | -    | X   | -   |
+----------------+-----------+------------+-------+--------+------+-----+-----+
| freepdk45_c4m  |  real     |  Yes       | No    | -      | -    | -   | X   |
+----------------+-----------+------------+-------+--------+------+-----+-----+
| sky130_c4m     |  real     |  No        | No    | -      | -    | -   | X   |
+----------------+-----------+------------+-------+--------+------+-----+-----+
| tsmc_c018      |  real     |  Yes       | Yes   | -      | -    | -   | X   |
+----------------+-----------+------------+-------+--------+------+-----+-----+



