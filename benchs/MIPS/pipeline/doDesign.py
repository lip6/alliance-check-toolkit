#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import re
import traceback
import os.path
import optparse
from   coriolis.Hurricane     import DbU, DataBase, UpdateSession, Breakpoint, \
                                     Transformation, Instance
from   coriolis               import Cfg, Viewer, CRL, Etesian, Anabatic, Katana, \
                                     Unicorn
from   coriolis.helpers       import ErrorMessage, overlay, l, u, n
from   coriolis.plugins.rsave import rsave


def scriptMain ( **kw ):
    #Breakpoint.setStopLevel( 100 )
    with overlay.CfgCache(priority=Cfg.Parameter.Priority.UserFile) as cfg:
        # Common settings for all runs.
        cfg.misc.catchCore              = False
        cfg.misc.info                   = False
        cfg.misc.paranoid               = False
        cfg.misc.bug                    = False
        cfg.misc.logMode                = True
        cfg.misc.verboseLevel1          = True
        cfg.misc.verboseLevel2          = True
        #cfg.misc.minTraceLevel          = 110
        #cfg.misc.maxTraceLevel          = 120
        cfg.katana.searchHalo           = 1
        cfg.katana.eventsLimit          = 1000000
        cfg.anabatic.topRoutingLayer    = 'METAL5'
        cfg.katana.hTracksReservedLocal = 5 
        cfg.katana.vTracksReservedLocal = 5 
        cfg.katana.hTracksReservedMin   = 1 
        cfg.katana.vTracksReservedMin   = 4 
    
        Viewer.Graphics.setStyle( 'Alliance.Classic [black]' )
        af  = CRL.AllianceFramework.get()
        env = af.getEnvironment()
        env.setCLOCK( 'do_not_recognize_ck' )

    editor = None
    if 'editor' in kw and kw['editor']:
      editor = kw['editor']
  
    af  = CRL.AllianceFramework.get()
    env = af.getEnvironment()
    env.setCLOCK( 'do_not_recognize_ck' )
  
    cell = CRL.AllianceFramework.get().getCell( 'mips_r3000_1m_core_flat', CRL.Catalog.State.Views )
    if editor: editor.setCell( cell )
  
    katana = Katana.KatanaEngine.create( cell )
    katana.setViewer( editor )
    katana.digitalInit          ()
    #katana.runNegociatePreRouted()
    katana.runGlobalRouter      ( Katana.Flags.NoFlags )
    katana.loadGlobalRouting    ( Anabatic.EngineLoadGrByNet )
    Breakpoint.stop( 100, 'Global routing has been loaded.' )
    katana.layerAssign          ( Anabatic.EngineNoNetLayerAssign )
    katana.runNegociate         ( Katana.Flags.NoFlags )
    katana.finalizeLayout()
    katana.destroy()
    cell.setName( cell.getName()+'_r' )
    rsave( cell, CRL.Catalog.State.Logical|CRL.Catalog.State.Physical )
  
    return cell
