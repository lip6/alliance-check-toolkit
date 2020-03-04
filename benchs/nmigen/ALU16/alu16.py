from nmigen import *
from nmigen.cli import rtlil


class Adder(Elaboratable):
    def __init__(self, width):
        self.a   = Signal(width)
        self.b   = Signal(width)
        self.o   = Signal(width)

    def elaborate(self, platform):
        m = Module()
        m.d.comb += self.o.eq(self.a + self.b)
        return m


class Subtractor(Elaboratable):
    def __init__(self, width):
        self.a   = Signal(width)
        self.b   = Signal(width)
        self.o   = Signal(width)

    def elaborate(self, platform):
        m = Module()
        m.d.comb += self.o.eq(self.a - self.b)
        return m


class ALU(Elaboratable):
    def __init__(self, width):
        self.op  = Signal()
        self.a   = Signal(width)
        self.b   = Signal(width)
        self.o   = Signal(width)

        self.add = Adder(width)
        self.sub = Subtractor(width)

    def elaborate(self, platform):

        m = Module()
        #m.domains.sync = ClockDomain()
        #m.d.comb += ClockSignal().eq(self.m_clock)

        m.submodules.add = self.add
        m.submodules.sub = self.sub
        m.d.comb += [
            self.add.a.eq(self.a),
            self.sub.a.eq(self.a),
            self.add.b.eq(self.b),
            self.sub.b.eq(self.b),
        ]
        with m.If(self.op):
            m.d.sync += self.o.eq(self.sub.o)
        with m.Else():
            m.d.sync += self.o.eq(self.add.o)
        return m


def create_ilang(dut, ports, test_name):
    vl = rtlil.convert(dut, name=test_name, ports=ports)
    with open("%s.il" % test_name, "w") as f:
        f.write(vl)

if __name__ == "__main__":
    alu = ALU(width=16)
    create_ilang(alu, [#alu.m_clock, alu.p_reset,
                       alu.op, alu.a, alu.b, alu.o], "alu16")
