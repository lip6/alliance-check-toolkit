yosys read_verilog  eth_clockgen.v
yosys read_verilog  eth_cop.v
yosys read_verilog  eth_crc.v
yosys read_verilog  eth_fifo.v
yosys read_verilog  eth_maccontrol.v
yosys read_verilog  ethmac_defines.v
yosys read_verilog  eth_macstatus.v
yosys read_verilog  ethmac.v
yosys read_verilog  eth_miim.v
yosys read_verilog  eth_outputcontrol.v
yosys read_verilog  eth_random.v
yosys read_verilog  eth_receivecontrol.v
yosys read_verilog  eth_registers.v
yosys read_verilog  eth_register.v
yosys read_verilog  eth_rxaddrcheck.v
yosys read_verilog  eth_rxcounters.v
yosys read_verilog  eth_rxethmac.v
yosys read_verilog  eth_rxstatem.v
yosys read_verilog  eth_shiftreg.v
yosys read_verilog  eth_spram_256x32.v
yosys read_verilog  eth_top.v
yosys read_verilog  eth_transmitcontrol.v
yosys read_verilog  eth_txcounters.v
yosys read_verilog  eth_txethmac.v
yosys read_verilog  eth_txstatem.v
yosys read_verilog  eth_wishbone.v
yosys read_verilog  timescale.v
yosys hierarchy -check -top ethmac
yosys synth            -top ethmac
yosys memory
yosys dfflibmap -liberty    /dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018/FlexLib.lib
yosys abc       -liberty    /dsk/l1/jpc/crypted/soc/techno/etc/coriolis2/NDA/node180/tsmc_c018/FlexLib.lib
yosys clean
yosys write_blif ethmac.blif
