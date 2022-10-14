from nmigen import *
from nmigen.cli import main
from nmigen.back import verilog 


class SARlogic(Elaboratable):
    def __init__(self, N):
    
        #inputs
        self.SOC = Signal()
        self.cmp = Signal()
        
        #outputs
        self.EOC = Signal()
        self.res = Signal(unsigned(N))
        self.DAC_control = Signal(unsigned(N))
        self.SE = Signal()
        
        self.N = N
        
    def elaborate(self, platform):
    
        m = Module()
        
        res_intern = Signal(self.N) # on enregistre le résultat
        bitToConvert = Signal(self.N, reset = 1) # pour savoir quel bit nous sommes en train de convertir (dans l'état "conversion")
        i = Signal(range(0, self.N)) # variable opur tester la fin de la conversion, initialisée à 1 car léger problème de range avec (0, self.N-1)
        
        with m.FSM() as fsm:
            with m.State('IDLE'):
            
                with m.If(self.SOC == 1):
                    m.next = 'SAMPLING'
                    
                    #outputs
                    m.d.sync += [
                    self.EOC.eq(0),
                    res_intern.eq(0),
                    self.DAC_control.eq(0),
                    self.SE.eq(1),
                    i.eq(0)
                    ]
                with m.Else():
                    m.next = 'IDLE'
                    
                    #outputs
                    m.d.sync += [
                    self.EOC.eq(0),
                    res_intern.eq(0),
                    self.DAC_control.eq(0),
                    self.SE.eq(0),
                    i.eq(0)
                    ]
            
            with m.State('SAMPLING'):
                m.next = 'HOLD'
                
                m.d.sync += self.SE.eq(0)
                m.d.sync += self.EOC.eq(0)
                m.d.sync += bitToConvert.eq(1)
            
            with m.State('HOLD'):
                m.next = 'CONVERSION'
                
                m.d.sync += self.DAC_control.eq(1)
                m.d.sync += bitToConvert.eq(bitToConvert << 1)

                with m.If(self.cmp):
                    m.d.sync += res_intern.eq(res_intern | bitToConvert)
            
            with m.State('CONVERSION'):
                with m.If(i < self.N):
                    with m.If(self.cmp):
                        m.d.sync += res_intern.eq(res_intern | bitToConvert)
                        
                    m.d.sync += bitToConvert.eq(bitToConvert << 1)
                    
                    m.d.sync += self.DAC_control.eq(res_intern | bitToConvert)
                
                    m.d.sync += i.eq(i+1)
                        
                    m.d.sync += self.res.eq(res_intern)

                with m.If(i == self.N-1): #fin de la conversion
                    m.d.sync += i.eq(0)
                    m.d.sync += bitToConvert.eq(1)
                    m.d.sync += self.EOC.eq(1)

                    with m.If(self.SOC): # veut-on recommencer une conversion ?
                        m.next = 'HOLD'
                        m.d.sync += self.SE.eq(1) #on veut re-échantilloner directement
                    with m.Else():
                        m.next = 'IDLE'
                        m.d.sync += self.SE.eq(0)

        return m
               
    def ports(self):
        return [self.SOC, self.cmp, self.EOC, self.res, self.DAC_control, self.SE]

if __name__ == "__main__":
	sarlogic = SARlogic(8)
	#main(sarlogic, ports=[sarlogic.SOC, sarlogic.cmp, sarlogic.EOC, sarlogic.res, sarlogic.DAC_control, sarlogic.SE])	

	file = open("SARlogic_step1.v", "w")
	
	file.write(verilog.convert(sarlogic, ports=sarlogic.ports()))

	file.close()
