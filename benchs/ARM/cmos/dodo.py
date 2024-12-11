
from coriolis.designflow.technos import setupCMOS

setupCMOS()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task import Tasks
from coriolis.designflow.copy import Copy
from coriolis.designflow      import pnrcheck

def getAllFileVariants ( source ):
    sourceVariants = []
    for ext in ('.ap', '.vst', '.spi'):
        if source == 'corona': suffixes = ('', '_cts_r')
        else:                  suffixes = ('', '_cts')
        for suffix in suffixes:
            if ext == '.vst' and suffix == '' and source != 'corona':
                continue
            print( source, suffix, ext )
            sourceVariants.append( source+suffix+ext )
    return sourceVariants

def setArmRtlRules ():
    vhdlSources = [ 'alu'
                  , 'arm_core'
                  , 'decod_model'
                  , 'decod'
                  , 'exec_model'
                  , 'exec'
                  , 'fifo129'
                  , 'fifo32_u01'
                  , 'fifo32'
                  , 'fifo72'
                  , 'ifetch_model'
                  , 'ifetch'
                  , 'mem'
                  , 'reg'
                  , 'shifter'
                  ]
    
    rtlFiles = []
    rtlRules = []
    for source in vhdlSources:
        rtlRules.append( Copy.mkRule( source, source+'.vst', 'uniquified/'+source+'.vst' ))
        globals()[ 'rule_'+source ] = rtlRules[-1]
        rtlFiles += getAllFileVariants( source )
    rtlFiles += getAllFileVariants( 'corona' )
    return rtlRules, rtlFiles

rtlRules, rtlFiles = setArmRtlRules()
pnrcheck.mkRuleSet( globals()
                  , 'arm_core'
                  , pnrcheck.NoSynthesis|pnrcheck.NoGDS|pnrcheck.UseClockTree|pnrcheck.IsChip
                  , extraRtlDepends=rtlRules
                  , extrasClean=rtlFiles
                  )
