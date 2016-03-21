.. -*- Mode: rst -*-

.. role:: ul
.. role:: cb
.. role:: sc
.. role:: fboxtt

.. role:: raw-html(raw)
   :format: html

.. role:: raw-latex(raw)
   :format: latex


.. HTML/LaTeX Mixed Macros.
.. |br|                replace:: :raw-latex:`\linebreak` :raw-html:`<br/>`
.. |newpage|           replace:: :raw-latex:`\newpage`
.. |linebreak|         replace:: :raw-latex:`\smallskip`
.. |bigskip|           replace:: :raw-latex:`\bigskip`
.. |noindent|          replace:: :raw-latex:`\noindent`

.. Acronyms & Names
.. |Si2|               replace:: :sc:`Si2`
.. |Cadence|           replace:: :sc:`Cadence`
.. |EDI|               replace:: :sc:`edi`
.. |NanoRoute|         replace:: :sc:`NanoRoute`
.. |TCL|               replace:: :sc:`tcl`
.. |Alliance|          replace:: :sc:`Alliance`
.. |Coriolis|          replace:: :sc:`Coriolis`
.. |Python|            replace:: :sc:`Python`
.. |RHEL6|             replace:: :sc:`rhel6`
.. |MOSIS|             replace:: :sc:`mosis`
.. |GDSII|             replace:: :sc:`gdsii`
.. |VHDL|              replace:: :sc:`vhdl`
.. |RDS|               replace:: :sc:`rds`
.. |API|               replace:: :sc:`api`
.. |LVS|               replace:: :sc:`lvs`
.. |adder|             replace:: ``adder``
.. |AM2901|            replace:: :sc:`am2901`
.. |alliance-run|      replace:: ``alliance-run``
.. |cpu|               replace:: :sc:`cpu`
.. |SNX|               replace:: :sc:`snx`
.. |MIPS|              replace:: :sc:`mips`
.. |FPGA|              replace:: :sc:`fpga`
.. |ISPD05|            replace:: :sc:`ispd05`
		       
.. |encounter|         replace:: ``encounter``
.. |devtoolset-2|      replace:: ``devtoolset-2``
.. |git|               replace:: ``git``
.. |Makefile|          replace:: ``Makefile``
.. |gds|               replace:: ``gds``
.. |ring|              replace:: ``ring``
.. |sxlib|             replace:: ``sxlib``
.. |dp_sxlib|          replace:: ``dp_sxlib``
.. |ramlib|            replace:: ``ramlib``
.. |rflib|             replace:: ``rflib``
.. |rf2lib|            replace:: ``rf2lib``
.. |padlib|            replace:: ``padlib``
.. |pxlib|             replace:: ``pxlib``
.. |nsxlib|            replace:: ``nsxlib``
.. |mpxlib|            replace:: ``mpxlib``
.. |msplib|            replace:: ``msplib``
.. |scn6m_deep_09|     replace:: ``scn6m_deep_09.rds``
.. |rules_mk|          replace:: ``rules.mk``
.. |px2mpx|            replace:: ``px2mpx.py``
.. |doChip|            replace:: ``doChip.py``
.. |go|                replace:: ``go.sh``
.. |cougar|            replace:: ``cougar``
.. |yagle|             replace:: ``yagle``
.. |proof|             replace:: ``proof``
.. |vasy|              replace:: ``vasy``
.. |avt_shell|         replace:: ``avt_shell``
.. |extractCell.tcl|   replace:: ``extractCell.tcl``

.. |layout-alc|        replace:: ``layout-alc``
.. |layout|            replace:: ``layout``
.. |chip_clk|          replace:: ``$(CHIP)_crl_clocked``
.. |chip_clk_kite|     replace:: ``$(CHIP)_crl_clocked_kite``
.. |druc|              replace:: ``druc``
.. |druc-alc|          replace:: ``druc-alc``
.. |lvx|               replace:: ``lvx``
.. |lvx-alc|           replace:: ``lvx-alc``
.. |graal|             replace:: ``graal``
.. |dreal|             replace:: ``dreal``
.. |view|              replace:: ``view``
.. |cgt_interactive|   replace:: ``cgt-interactive``
.. |cgt|               replace:: ``cgt``


:raw-html:`<br/>`

=========================================
|Alliance| & |Coriolis| Checker Toolkit
=========================================

:raw-html:`<br/>`

.. contents::


Toolkit Purpose
=================

This toolkit has been created to allow developpers to share through |git| a set
of benchmarks to validate their changes in |Alliance| & |Coriolis| before commiting
and pushing them in their central repositories. A change will be considered as
validated when all the developpers can run successfully all the benchs in their
respective environments.

As a consequence, this repository is likely to be *very* unstable and the commits
not well documenteds as they will be quick corrections made by the developpers.


Toolkit Contents
==================

The toolkit provides:

* Eleven benchmark designs:

=============================  ==========================  =======================================
Design                         Technology                  Cell Libraries
=============================  ==========================  =======================================
|adder|                        |MOSIS|                     |nsxlib|, |mpxlib|, |msplib|
|AM2901| (standard cells)      |Alliance| dummy            |sxlib|, |pxlib|
|AM2901| (datapath)            |Alliance| dummy            |sxlib|, |dp_sxlib|, |pxlib|
|alliance-run| (|AM2901|)      |Alliance| dummy            |sxlib|, |dp_sxlib|, |padlib|
|cpu|                          |MOSIS|                     |nsxlib|, |mpxlib|, |msplib|
|SNX|                          |MOSIS|                     |nsxlib|, |mpxlib|, |msplib|
|MIPS| (microprogrammed)       |Alliance| dummy            |sxlib|, |dp_sxlib|, |rf2lib|
|MIPS| (pipeline)              |Alliance| dummy            |sxlib|, |dp_sxlib|, |rf2lib|
|MIPS| (pipeline+chip)         |Alliance| dummy            |sxlib|, |dp_sxlib|, |rf2lib|, |pxlib|
|FPGA| (``Moc4x4_L4C12``)      |Alliance| dummy            |sxlib|
|ISPD05| (``bigblue1``)        Aucune                      Genérée à la volée.
=============================  ==========================  =======================================

* Three cell libraries.

  All thoses libraries are for use with the |MOSIS| technology. We provides them
  as part of the toolkit as we are still in the process of validating that
  technology, and we may have to perform quick fixes on them. The design are
  configured to use them instead of those supplied by the |Alliance| installation.

  * |nsxlib| : Standard Cell library.
  * |mpxlib| : Pad library, compliant with |Coriolis|.
  * |msplib| : Pad library, compliant with |Alliance| / |ring|. Cells in this
    library are *wrappers* around their counterpart in |mpxlib|, they provides
    an outer layout shell that is usable by |ring|.

* The |RDS| file for the |MOSIS| technology |scn6m_deep_09|, for the same
  reason as the cell libraries.

* Miscellenous helper scripts.


Benchmark Makefiles
=====================

The main body of the |Makefile| has been put into ``benchs/etc/rules.mk``.

The |Makefile| provides some or all of the following targets. If the place
and route stage of a bench can be done by both |Coriolis| and |Alliance|
an ``alliance/`` subdirectory will be present.


+--------------+----------------------+---------------------------------------------------------------+
|  |Coriolis|  |  |layout|            |  The complete symbolic layout of the design (P&R).            |
|              +----------------------+---------------------------------------------------------------+
|              |  |gds|               |  Generate the real layout (|GDSII|)                           |
|              +----------------------+---------------------------------------------------------------+
|              |  |druc|              |  Symbolic layout checking                                     |
|              +----------------------+---------------------------------------------------------------+
|              |  |lvx|               |  Perform |LVS|.                                               |
|              +----------------------+---------------------------------------------------------------+
|              |  |graal|             |  Launch |graal| in the |Makefile| 's environement             |
|              +----------------------+---------------------------------------------------------------+
|              |  |dreal|             |  Launch |dreal| in the |Makefile| 's environement, and load   |
|              |                      |  the |gds| file of the design.                                |
|              +----------------------+---------------------------------------------------------------+
|              |  |view|              |  Launch |cgt| and load the design (chip)                      |
|              +----------------------+---------------------------------------------------------------+
|              |  |cgt|               |  Launch |cgt|  in the |Makefile| 's environement              |
+--------------+----------------------+---------------------------------------------------------------+


|newpage|

A top |Makefile| in a bench directory must looks like: ::

                     BOOMOPT = -A
                     BOOGOPT =
                     LOONOPT =
                   NSL2VHOPT = -vasy
              LIBRARY_FAMILY = nsxlib
               USE_SYNTHESIS = Yes
               USE_CLOCKTREE = No
                   USE_DEBUG = No

                    NETLISTS = cla16       \
                               inc16       \
                               reg4        \
                               type_dec    \
                               alu16_model \
                               snx_model
   
    include ../etc/rules.mk

    lvx:       lvx-chip_kite
    druc:      druc-chip_kite
    view:      cgt-chip_kite

    layout:    chip_kite.ap
    gds:       chip_kite.gds

Where variables have the following meaning:

=======================  ===========================================================
Variable                 Usage
=======================  ===========================================================
``NETLISTS``             The list of *netlists* that are requireds to perform the
                         place and route stage. The files must we given *without*
                         extension. According to the value of ``USE_SYNTHESIS`` they
                         are user supplied or generated. In the later case, be aware
                         that calling the ``clean`` target will remove the generated
                         files.
``LIBRARY_FAMILY``       Tells which library set to use. Legal values are ``sxlib``
                         (default) and ``nsxlib`` (|MOSIS| technology).
``USE_SYNTHESIS``        If set to ``Yes``, then the files given in the ``NETLISTS``
                         variables will be synthetised from the reference ``vhdl``
                         or ``nsl`` description, if this tool is available.
                         Note that the clean will remove all generated files.
``USE_CLOCKTREE``        Adds a clock-tree to the design (|Coriolis|).
``USE_DEBUG``            Activate debug support on |cgt|.
=======================  ===========================================================


|Coriolis| Configuration Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Unlike |Alliance| which is entirely configured through environement variables
or system-wide configuration file, |Coriolis| uses configuration files in
the current directory. They are present for each bench:

* ``<cwd>/.coriolis2/techno.py`` : Select which symbolic and real technology
  to use.
* ``<cwd>/.coriolis2/settings.py`` : Override for any system configuration,
  except for the technology.


|Coriolis| and Clock Tree Generation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When |Coriolis| is used, it create a clock tree which modificate the original
netlist. The new netlist, with a clock tree, has a postfix of ``_clocked``.

.. note:: **Trans-hierarchical Clock-Tree.** As |Coriolis| do not flatten the
   designs it creates, not only the top-level netlist is modificated. All the
   sub-blocks connected to the master clock are also duplicateds, whith the
   relevant part of the clock-tree included.


|RHEL6| and Clones
~~~~~~~~~~~~~~~~~~~~

Under |RHEL6| the developpement version of |Coriolis| needs the |devtoolset-2|.
|rules_mk| tries, based on ``uname`` to switch it on or off.


Benchmarks Special Notes
==========================

|alliance-run|
~~~~~~~~~~~~~~~~

This benchmark comes mostly with it's own rules and do not uses the ones supplieds
by |rules_mk|. It uses only the top-level configuration variables.

It a sligtly modified copy of the |alliance-run| found in the |Alliance| package
(modification are all in the |Makefile|). It build an |AM2901|, but it is
splitted in a control and an operative part (data-path). This is to also check
the data-path features of |Alliance|.

And lastly, it provides a check for the |Coriolis| encapsulation of |Alliance|
through |Python| wrappers. The support is still incomplete and should be used
only by very experienced users. See the ``demo*`` rules.


Libraries Makefiles
=====================

The ``bench/etc/rules.mk`` provides rules to perform the check of a library
as a whole or cell by cell. To avoid too much clutter in the library directory,
all the intermediate files generated by the verification tools are kept in a
``./check/`` subdirectory. Once a cell has been validated, a ``./check/<cell>.ok``
is generated too prevent it to be checked again in subsequent run. If you
want to force the recheck of the cell, do not forget to remove this file.

The checking procedure:

* DRC with |druc|.
* Formal proof between the layout and the behavioral description. This is a
  somewhat long chain of tools:

  #. |cougar|, extract the spice netlist (``.spi``).
  #. |yagle|, rebuild a behavioral description (``.vhd``) from the spice
     netlist.
  #. |vasy|, convert the ``.vhd`` into a ``.vbe`` (Alliance |VHDL| subset
     for behavioral descriptions).
  #. |proof|, perform the formal proof between the refence ``.vbe`` and the
     extracted one.

|newpage|


=========================  ===================================================
Rule or File               Action
=========================  ===================================================
``check-lib``              Validate every cell of the library
``clean-lib-tmp``          Remove all intermediate files in the ``./check``
                           subdirectory **except** for the ``*.ok`` ones.
                           That is, cells validated will not be rechecked.
``clean-lib``              Remove all files in ``./check``, including ``*.ok``
``./check/<cell>.ok``      Use this rule to perform the individual check of 
                           ``<cell>``. If the cell is validated, a file of
                           the same name will be created, preventing the cell
                           to be checked again.
=========================  ===================================================


Tools & Scripts
=================

One script to run them all: |go|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To call all the bench's ``Makefile`` sequentially and execute one or more rules on
each, the small script utility |go| is available. Here are some examples: ::

    dummy@lepka:bench$ ./bin/go.sh clean
    dummy@lepka:bench$ ./bin/go.sh lvx


Command Line |cgt|: |doChip|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As a alternative to |cgt|, the small helper script |doChip| allows to
perform all the P&R tasks, on an stand-alone block or a whole chip.


Pad Layout Converter |px2mpx|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The |px2mpx| script convert pad layout from the |pxlib| (|Alliance| dummy
technology) into |mpxlib| (|MOSIS| compliant symbolic technology).

Basically it multiplies all the coordinate by two as the source technology
is 1µ type and the target one a 2µ. In addition it performs some adjustement
on the wire extension and minimal width and the blockage sizes.

As it is a one time script, it is heavily hardwired, so before using it
do not forget to edit it to suit your needs.

The whole conversion process is quite tricky as we are cheating with the
normal use of the software. The steps are as follow:

1. Using the |Alliance| dummy technology and in an empty directory, run
   the script. The layouts of the converted pads (``*_mpx.ap``) will be
   created.

2. In a second directory, this time configured for the |MOSIS| technology
   (see ``.coriolis2_techno.conf``) copy the converted layouts. In addition
   to the layouts, this directory **must also contain** the behavioral
   description of the pads (``.vbe``). Otherwise, you will not be able to
   see the proper layout.

3. When you are satisfied with the new layout of the pads, you can copy
   them back in the official pad cell library.

.. note:: **How Coriolis Load Cells.**
   Unlike in |Alliance|, |Coriolis| maintain a much tighter relationship
   between physical and logical (structural or behavioral) views. The
   loading process of a cell try *first* to load the logical view, and
   if found, keep tab of the directory it was in. *Second* it tries to
   load the physical view from the same directory the logical view was
   in. If no logical view is found, only the physical is loaded.

   Conversely, when saving a cell, the directory it was loaded from
   is kept, so that the cell will be overwritten, and not duplicated
   in the working directory as it was in |Alliance|.

   This explains why the behavioral view of the pad is needed in
   the directory the layouts are put into. Otherwise you would only see
   the pads of the system library (if any).


Yagle Cell Extraction Script |extractCell.tcl|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A small |TCL| script for |avt_shell| to perform a cell extraction with
|yagle|. Cell which name starts by ``sff`` will be treated as D flip-flop.


|Cadence| Support
===================

To perform comparisons with |Cadence| |EDI| tools (i.e. |encounter|
|NanoRoute|), some benchmarks have a sub-directory ``encounter``
holding all the necessary files. Here is an example for the design
named ``<fpga>``.

===========================  =================================================
                     ``encounter`` directory
------------------------------------------------------------------------------
File Name                    Contents
===========================  =================================================
``fpga_export.lef``          Technology & standard cells for the design
``fpga_export.def``          The design itself, flattened to the standard
                             cells.
``fpga_nano.def``            The placed and routed result.
``fpga.tcl``                 The |TCL| script to be run by |encounter|
===========================  =================================================

The LEF/DEF file exported or imported by Coriolis are *not* true physical
files. They are pseudo-real, in the sense that all the dimensions are
directly taken from the symbolic with the simple rule ``1 lambda = 1 micron``.

.. note:: **LEF/DEF files:** Coriolis is able to import/export in those
   formats only if it has been compiled against the |Si2| relevant libraries
   that are subjects to specific license agreements. So in case we don't
   have access to thoses we supplies the generated LEF/DEF files.

The ``encounter`` directory contains the LEF/DEF files and the |TCL|
script to be run by |encounter|: ::

    ego@home:encounter> . ../../etc/EDI1324.sh
    ego@home:encounter> encounter -init ./fpga.tcl

|newpage|


Example of |TCL| script for |encounter|: ::
    
    set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
    suppressMessage ENCEXT-2799
    win
    loadLefFile fpga_export.lef
    loadDefFile fpga_export.def
    floorPlan -site core -r 0.998676319592 0.95 0.0 0.0 0.0 0.0
    getIoFlowFlag
    fit
    setDrawView place
    setPlaceMode -fp false
    placeDesign
    generateTracks
    generateVias
    setNanoRouteMode -quiet -drouteFixAntenna 0
    setNanoRouteMode -quiet -drouteStartIteration 0
    setNanoRouteMode -quiet -routeTopRoutingLayer 5
    setNanoRouteMode -quiet -routeBottomRoutingLayer 2
    setNanoRouteMode -quiet -drouteEndIteration 0
    setNanoRouteMode -quiet -routeWithTimingDriven false
    setNanoRouteMode -quiet -routeWithSiDriven false
    routeDesign -globalDetail
    global dbgLefDefOutVersion
    set dbgLefDefOutVersion 5.7
    defOut -floorplan -netlist -routing fpga_nano.def


Technologies
==============

We provides configuration files for the publicly available |MOSIS|
technology ``SCN6M_DEEP``.

* ``./bench/etc/scn6m_deep_09.rds``, |RDS| rules for symbolic to real
  transformation.
* ``./bench/etc/scn6m_deep.hsp``, transistor spice models for |yagle|.

References:

* `MOSIS Scalable CMOS (SCMOS) <https://www.mosis.com/files/scmos/scmos.pdf>`_
* `MOSIS Wafer Acceptance Tests <ftp://ftp.mosis.com/pub/mosis/vendors/tsmc-018/t92y_mm_non_epi_thk_mtl-params.txt>`_

|newpage|


Technical informations: ::

                               MOSIS WAFER ACCEPTANCE TESTS
                                             
              RUN: T92Y (MM_NON-EPI_THK-MTL)                    VENDOR: TSMC
       TECHNOLOGY: SCN018                                FEATURE SIZE: 0.18 microns
                                      Run type: DED
    
    
    INTRODUCTION: This report contains the lot average results obtained by MOSIS
                  from measurements of MOSIS test structures on each wafer of
                  this fabrication lot. SPICE parameters obtained from similar
                  measurements on a selected wafer are also attached.
    
    COMMENTS: DSCN6M018_TSMC
    
    
    TRANSISTOR PARAMETERS     W/L       N-CHANNEL P-CHANNEL  UNITS
                                                            
     MINIMUM                  0.27/0.18                     
      Vth                                    0.50     -0.49  volts
                                                            
     SHORT                    20.0/0.18                     
      Idss                                 572      -276     uA/um
      Vth                                    0.52     -0.49  volts
      Vpt                                    4.7      -5.2   volts
                                                            
     WIDE                     20.0/0.18                     
      Ids0                                  20.8     -15.2   pA/um
                                                            
     LARGE                    50/50                         
      Vth                                    0.42     -0.41  volts
      Vjbkd                                  3.7      -4.4   volts
      Ijlk                                 &lt;50.0     &lt;50.0   pA
                                                            
     K' (Uo*Cox/2)                         171.0     -37.0   uA/V^2
     Low-field Mobility                    406.07     87.86  cm^2/V*s
                                                            
    COMMENTS: Poly bias varies with design technology. To account for mask
               bias use the appropriate value for the parameters XL and XW
               in your SPICE model card.
                           Design Technology                   XL (um)  XW (um)
                           -----------------                   -------  ------
                           SCN6M_DEEP (lambda=0.09)             0.00    -0.01
                                         thick oxide            0.00    -0.01
                           SCN6M_SUBM (lambda=0.10)            -0.02     0.00
                                         thick oxide           -0.02     0.00
    
    
    FOX TRANSISTORS           GATE      N+ACTIVE  P+ACTIVE  UNITS
     Vth                      Poly         &gt;6.6     &lt;-6.6   volts
    
    
    PROCESS PARAMETERS     N+    P+    POLY  N+BLK  PLY+BLK    M1     M2   UNITS
     Sheet Resistance       7.0   8.1  8.3    59.5   306.6    0.08   0.08  ohms/sq
     Contact Resistance     8.3   8.8  8.1                           4.83  ohms
     Gate Oxide Thickness  41                                              angstrom
                                                                          
    PROCESS PARAMETERS     M3   POLY_HRI     M4      M5       M6    N_W     UNITS
     Sheet Resistance     0.08              0.08    0.07     0.01    951    ohms/sq
     Contact Resistance   9.74             15.36   21.50    23.45           ohms
                                                                           
    COMMENTS: BLK is silicide block.
    
    
    CAPACITANCE PARAMETERS  N+   P+  POLY M1 M2 M3 M4 M5 M6 R_W  D_N_W  M5P N_W  UNITS
     Area (substrate)      969 1234  101  34 14  9  7  5  4        129       130 aF/um^2
     Area (N+active)                8517  53 20 14 11  9  8                      aF/um^2
     Area (P+active)                8275                                         aF/um^2
     Area (poly)                          64 17 10  7  5  4                      aF/um^2
     Area (metal1)                           35 14  9  6  5                      aF/um^2
     Area (metal2)                              36 14  9  6                      aF/um^2
     Area (metal3)                                 37 14  9                      aF/um^2
     Area (metal4)                                    36 14                      aF/um^2
     Area (metal5)                                       35            1039      aF/um^2
     Area (r well)         953                                                   aF/um^2
     Area (d well)                                           562                 aF/um^2
     Area (no well)        140                                                   aF/um^2
     Fringe (substrate)    196  229       53 36 29 24 21 19                      aF/um
     Fringe (poly)                        68 38 29 23 19 18                      aF/um
     Fringe (metal1)                         49 34    22 20                      aF/um
     Fringe (metal2)                            45 35 27 23                      aF/um
     Fringe (metal3)                               54 34 30                      aF/um
     Fringe (metal4)                                  63 43                      aF/um
     Fringe (metal5)                                     66                      aF/um
    
    CIRCUIT PARAMETERS                            UNITS      
     Inverters                     K                         
      Vinv                        1.0       0.74  volts      
      Vinv                        1.5       0.79  volts      
      Vol (100 uA)                2.0       0.08  volts      
      Voh (100 uA)                2.0       1.62  volts      
      Vinv                        2.0       0.83  volts      
      Gain                        2.0     -24.67             
     Ring Oscillator Freq.                                   
      D1024_THK (31-stg,3.3V)             302.91  MHz        
      DIV1024 (31-stg,1.8V)               377.13  MHz        
     Ring Oscillator Power                                   
      D1024_THK (31-stg,3.3V)               0.07  uW/MHz/gate
      DIV1024 (31-stg,1.8V)                 0.02  uW/MHz/gate
                                                             
    COMMENTS: DEEP_SUBMICRON
    
