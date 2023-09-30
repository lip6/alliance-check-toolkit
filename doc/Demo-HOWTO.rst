

==============
Demo Guideline
==============

Or, how to make a nice demonstration with Coriolis.


Prerequisites
=============

You must have installed :

1. Coriolis https://github.com/lip6/coriolis
1. Alliance https://github.com/lip6/alliance
1. alliance-check-toolkit https://github.com/lip6/alliance-check-toolkit

For more informations you can refer to https://coriolis.lip6.fr/


The Arlet6502/sky130_c4m Demo
=============================

First, initialize the Coriolis environment with ``coriolisEnv.py``:

.. code-block:: bash

   ego@home:~> eval `~/coriolis-2.x/Linux.x86_64/Release.Shared/install/etc/coriolis2/coriolisEnv.py`
   [GUESSED] shellPath=/usr/bin/zsh
   Issuing commands for Bourne shell like interpreters
   Using script location Coriolis 2 (/dsk/l1/jpc/coriolis-2.x/Linux.x86_64/Release.Shared/install)
   Switching to Coriolis 2.x (Release.Shared)


.. note:: **Coriolis installation directory** may change according to your
	  OS or setup. The ``Linux.x86_64`` path component in particular

   
Next, go into the bench directory:

.. code-block:: bash

   ego@home:~> cd coriolis-2.x/src/alliance-check-toolkit/benchs/arlet6502/sky130_c4m
   ego@home:sky130_c4m:~>

The design flow relies on two Python files:

1. ``dodo.py``, the control file for ``doit`` containing the rules to execute
   (it is replacement for ``make``).

2. ``doDesign.py``, the Python script file to perform the P&R. It can work in
   pure text mode or in graphic mode (better for demos).


As checking step, you may ask ``doit`` to list the available targets:

.. code-block:: bash

   ego@home:sky130_c4m:sky130_c4m> doit list
   #
   # Lots of logging information & warnings here...
   #
   b2v          Run <blif2vst arlet6502 depends=[Arlet6502.blif]>.
   cgt          Run plain CGT (no loaded design)
   clean_flow   Clean all generated (targets) files.
   gds          Run <Alias "gds" for "pnr">.
   pnr          Run <pnr arlet6502_cts_r.gds depends=[arlet6502.vst,Arlet6502.spi]>.
   yosys        Run <yosys Arlet6502.v top=Arlet6502 blackboxes=[] flattens=[]>.

For the sake of the demo, we will perform in two steps:

1. Perform synthesis with Yosys and translate it's output (``blif`` file) into
   an Alliance VHDL netlist (aka ``vst``):

   .. code-block:: bash
   
      ego@home:sky130_c4m:sky130_c4m> doit b2v
      #
      # Log of Yosys here
      # Log of blif2vst here (b2v).


2. Perform the place & route stage in graphical mode.

   .. code-block:: bash
   
      ego@home:sky130_c4m:sky130_c4m> doit cgt
      # From now on, we are using the graphical interface of Coriolis...


The Place & Route in Graphical Mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Load the ``doDesign.py`` script into Coriolis:

   TopMenubar ==> Tools ==> Python Script  (or SHIFT+P SHIFT+S).

   In the popup widow, enter the name of the script, whithout
   extension: ``doDesign``.

   You will see the clock-tree appear, then the breakpoint popup.

   .. note:: To continue to the next breakpoint, click on the icon
	     of the yellow bird.

2. HFNS step, nothing graphic will be shown.

3. The placement step. You should see the cells slowly spread over the
   area until all overlap are solved. This an analytic placer, based on
   an analogy with a system of springs and weights (springs are wires,
   weight are cells). The objective is to minimize the *energy* of the
   whole system (minimize pulling forces) while still having no overlaps.
   The cell overlaps create a repulsive force.

3. Initialization of the router. A blotch of thick violet lines appears,
   they are the fly lines of the to-be-routed nets. Let's focus on one
   net in particular to better see the process of routing.

   a. Display the Controller window:

      TopMenuBar ==> Tools ==> Controller  (or CRTL-I).

   b. In the controller:

      * Select the "Netlist" tab.
      * Check "Sync Netlist" and "Sync Selection".
      * Sorts the nets by their number of RoutinPads (aka terminals),
        by clicking on the "RPs" header of the table.
      * In the filter pattern at the bottom of the window, enter "mos6502_i$".
	(the ending ``$`` is not a typo). Only one net should remain displayed
	in the table.
      * Select it, with a right-click on the mouse, select "Fit to net"
	(or CTRL+F). The display should now be focused on the net and we
	could clearly see the violet fly line representing the unrouted net.
      * Go to the next breakpoint...

4. The net has been globally routed. We see a "generic wire" (in a dummy metal)
   connecting the center of the GCell and some fly lines remaining between the
   *trunk* of the net and the RoutingPads (terminals).

   b. In the controller:

      If you wish, to better understand the global routing, in the "Layers&Gos"
      tab, uncheck "boundaries" (left column) and check "Anabatic::GCell"
      (on the bottom right, may need to scroll the tab).

        Then, you can see that the dummy metal wires goes center to center of
      the GCell. GCell being the regular grid with id number at their center.
 
5. Initial stage of the detailed router: complete the wiring and use real layers.
   The **only** remaining problem is that they overlap each other.

6. Solving the overlaps, this is the workhorse of the detailed router.
   The design is now finished. The last stage is only cleanup of the data-structures
   and write to the disk.

7. You may perform a "Fit" (TopMenubar ==> View ==> Fit to Contents, of key "F")
   to show the whole block.


The GmChamla Demo
=================

.. note:: This feature is only in a *dmonstrator* stage.


Go into the bench directory:

.. code-block:: bash

   ego@home:~> cd coriolis-2.x/src/alliance-check-toolkit/benchs/analog/gmChamla
   ego@home:gmChamla:~>


This bench do use ``doit``, so launch ``cgt`` directly:

.. code-block:: bash

   ego@home:gmChamla:~> cgt
   # From now on, we are using the graphical interface of Coriolis...

1. Load the ``gm.py`` script into Coriolis:

   TopMenubar ==> Tools ==> Python Script  (or SHIFT+P SHIFT+S).

   In the popup widow, enter the name of the script, whithout
   extension: ``gm``.

   The analog layout design will appear. It is placed and already global routed.


2. Display the slicing tree curve window:

   TopMenuBar ==> Analog ==> Slicing Tree ==> Slicing tree curve

   The curve shows the various size (abutment box) of the *complete* design  
   for each combination of size of the individual analog devices. Not all
   possibilities are plotted, some non-relevant one are pruned.

   You can then click on any blue triangle to select and resize on the
   fly the design.

3. Once a form factor has been choosen, you can finish the design by calling
   the detailed router (only that):

   TopMenuBar ==> P&R ==> Step by Step ==> Detailed Route

4. Using the netlist tab of the controller, you may show that some nets are
   routed simetrically.
