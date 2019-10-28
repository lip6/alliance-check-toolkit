#!/usr/bin/env python

from helpers import l
from stratus import *


class corona ( Model ) :

  def Interface ( self ) :
    # Pin terminals associated with ALU.
    self.cin        = SignalIn  ( "cin",        1 )
    self.cout       = SignalOut ( "cout",       1 )
    self.np         = SignalOut ( "np",         1 )
    self.ng         = SignalOut ( "ng",         1 )
    self.over       = SignalOut ( "over",       1 )
    self.zero       = SignalOut ( "zero",       1 )
    
    # Pin terminals associated with the RAM and ACCU shifter.
    # RAM and ACCU I/O plots controls.
    self.sh_right   = SignalOut ( "sh_right",   1 )
    self.sh_left    = SignalOut ( "sh_left",    1 )
    
    # RAM shifter I/O.
    self.ram_o_down = SignalOut ( "ram_o_down", 1 ) # alu_f[0]
    self.ram_o_up   = SignalOut ( "ram_o_up",   1 ) # alu_f[3]
    self.ram_i_down = SignalIn  ( "ram_i_down", 1 )
    self.ram_i_up   = SignalIn  ( "ram_i_up",   1 )
    
    # ACC shifter I/O.
    self.acc_o_down = SignalOut ( "acc_o_down", 1 )
    self.acc_o_up   = SignalOut ( "acc_o_up",   1 )
    self.acc_i_down = SignalIn  ( "acc_i_down", 1 )
    self.acc_i_up   = SignalIn  ( "acc_i_up",   1 )
    
    # ACCU controls terminals.
    self.ck         = SignalIn  ( "ck",         1 )
    
    # Data bus terminals.
    self.a          = SignalIn  ( "a",          4 )
    self.b          = SignalIn  ( "b",          4 )
    self.d          = SignalIn  ( "d",          4 )
    self.i          = SignalIn  ( "i",          9 )
    self.y          = SignalOut ( "y",          4 )
    self.noe        = SignalIn  ( "noe",        1 )
    self.oe         = SignalIn  ( "oe",         1 )
    
    # Power suplies terminals.
    self.vdd = VddIn ( "vdd" )
    self.vss = VssIn ( "vss" )
    return


  def Netlist ( self ) :

    # Core.
    self.core = Inst ( "amd2901_core", "core"
                     , map = { 'cin'        : self.cin        
                             , 'cout'       : self.cout       
                             , 'np'         : self.np         
                             , 'ng'         : self.ng         
                             , 'over'       : self.over       
                             , 'zero'       : self.zero       
                             , 'sh_right'   : self.sh_right   
                             , 'sh_left'    : self.sh_left    
                             , 'ram_o_down' : self.ram_o_down
                             , 'ram_o_up'   : self.ram_o_up
                             , 'ram_i_down' : self.ram_i_down 
                             , 'ram_i_up'   : self.ram_i_up   
                             , 'acc_o_down' : self.acc_o_down 
                             , 'acc_o_up'   : self.acc_o_up   
                             , 'acc_i_down' : self.acc_i_down 
                             , 'acc_i_up'   : self.acc_i_up   
                             , 'ck'         : self.ck         
                             , 'a'          : self.a          
                             , 'b'          : self.b          
                             , 'd'          : self.d          
                             , 'i'          : self.i          
                             , 'y'          : self.y          
                             , 'noe'        : self.noe        
                             , 'oe'         : self.oe         
                             , 'vdd'        : self.vdd
                             , 'vss'        : self.vss
                             }
                    )
    return

