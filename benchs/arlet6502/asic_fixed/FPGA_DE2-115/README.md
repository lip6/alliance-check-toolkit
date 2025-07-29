lun. 07 juil. 2025 16:17:20 CEST
This directory is used to implement the cpu 6502 on FPGA. This version uses the ../rtl_corrected version.

For this work you need a top level that intantiate a processor, a RAM model (to be synthetized in the FPGA), and one segement (it instantiate th 7segement of the FPGA to observe the output). The RAM_loader is used to initialize the RAM.
The top level include also the self test of the cpu. Several instructions are tested, at the end it implementes a counter that stops after a defined number of cycles. The output value is observed on the 7 segements. 
you can simulate it before implementing it on the FPGA:
iverilog -o test tb_top_cpu_fpga.v top_cpu_fpga.v  RAM_model.v  RAM_loader.v one_seg.v cpu_syncreset.v ALU.v
vvp test
gtkwave dump.vcd signals.gtkw
The value observed on the 7segment is the DO in binary.
In order to implement it on the FPGA: include top_cpu_fpga.v  RAM_model.v  RAM_loader.v one_seg.v cpu_syncreset.v ALU.v
Set the top level to top_cpu_fpga.v
assign the pins with pin.qsf
Compile
program the fpga
set the switch sw0 to 1.

 
