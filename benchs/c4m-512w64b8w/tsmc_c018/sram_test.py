

from nmigen     import Elaboratable, Cat, Module, Signal, ClockSignal, Instance
from nmigen.cli import rtlil


class SRAM_TEST ( Elaboratable ):

    def __init__( self ):
        self.a        = Signal(  9 )
        self.we       = Signal(  8 )
        self.byte_in  = Signal(  8 )
        self.byte_out = Signal(  8 )

    def elaborate(self, platform):
        m = Module()
        q      = Signal( 64 )
        d      = Signal( 64 )
        result = Signal( 64 )
        m.d.sync += result.eq(q + self.byte_in)

        # 64k SRAM instance
        sram = Instance("spblock_512w64b8w", i_a=self.a
                                           , o_q=q
                                           , i_d=d
                                           , i_we=self.we
                                           , i_clk=ClockSignal() )
        m.submodules += sram

        # connect up some arbitrary signals
        m.d.comb += d.eq( result )
        m.d.comb += self.byte_out.eq( q[56:63] )

        return m


def create_ilang(dut, ports, test_name):
    vl = rtlil.convert(dut, name=test_name, ports=ports)
    with open("%s.il" % test_name, "w") as f:
        f.write(vl)

if __name__ == "__main__":
    sram = SRAM_TEST()
    create_ilang(sram, [sram.a, sram.we, sram.byte_in, sram.byte_out], "sram_test")
