# -*- explicit-buffer-name: "Makefile<RingOscillator>" -*-

               DESIGN_TOP  = ../..

       PHYSICAL_SYNTHESIS  = Coriolis
               DESIGN_KIT  = sxlib

            USE_CLOCKTREE  = No
                USE_DEBUG  = No
                 USE_KITE  = No

                 NETLISTS  = ringoscillator
                 PATTERNS  = ringoscillator
                ASIMUTOPT  =

 include ./mk/design-flow.mk

          CLEAN_SYNTHESIS += ringoscillator.vst

ringoscillator.ap  ringoscillator.vst: ringoscillator.py
	-$(call scl_dts2,eval `$(CORIOLIS_TOP)/etc/coriolis2/coriolisEnv.py $(DEBUG_OPTION)`; cgt --text --script=ringoscillator)

layout: ringoscillator.ap
lvx:    lvx-1-ringoscillator
druc:   druc-ringoscillator
sim:    asimut-ringoscillator
