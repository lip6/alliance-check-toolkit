
===============
Ring Oscillator
===============


Implementation
==============

This design is in the form of a Python script. Is is a demonstrator
of what you can do in mixing the Coriolis Python interface and
Python programming. It is a **layout and netlist** generator,
after running it you end up with a ``.vst`` (Alliance structural
netlist) and ``.ap`` (Alliance symbolic layout).

It is important to note that in addition to the loop there is one
``nand 3`` gate. So for example the ``inv_x1`` ring do have 101
inversions on it when active. So it do oscillate.

=========  =====================================================
sel 2 1 0  Ring type
=========  =====================================================
``000``    ``inv_x1``  (100 stages)
``001``    ``inv_x4``  (74  stages)
``010``    ``inv_x1`` with RC load (50  stages)
``011``    ``buf_x2``  (75  stages)
``100``    ``buf_x8``  (37  stages)
``101``    ``na2_x1``  (76  stages)
``110``    ``no2_x1``  (76  stages)
``111``    ``nxr2_x1`` (34  stages)
=========  =====================================================


Makefile rules
==============

Before running any other rule, you must call ``layout`` to generate
the nelist and the layout:

.. code-block:: sh

   ego@home:cmos> make layout


The Coriolis GUI will show up for you to inspect the layout. You can
exit it by hitting ``CTRL+Q``.

You can then perform various checks:

.. code-bclock:: sh

   ego@home:cmos> make lvx   # Run the LVS
   ego@home:cmos> make druc  # Run the DRC (symbolic)
   ego@home:cmos> make sim   # Perform a simulation

Thoses checks ensure that the layout is DRC correct and that the layout is
coherent with the nelist. The simulation ensure that the implemented
functionality is correct.


A Note About Simulation
=======================

Due to the very nature of this design, loops of combinatorial gates and
ordinary signals used as clock for D flip-flop, it is quite tricky to make
``asimut`` simulate it. Here are some hints of how I did it:

#. Of course we must **not** run in zero-delay mode. The combinatorial loops
   won't be able to simulate.

   We use the delays provideds by the basic SxLib library.

#. As all signals starts in the **`u`** state, before making a ring to oscillate
   we must wait for the zero signals to propagate from the output of ``na3``
   through all the ring and loop back at the input to that same ``na3``.
   The ``na3`` cannot work properly until all it's input are in a known
   state.

#. Initialializing the registers of the DFF in the divider is quite tricky.
   The register starts in **u** mode, and as it is looped on it's own data
   through an inverter, even if the clock ticks, it will stay that way.
   We must force the state of the register **just after** the edge of the
   clock. We have to it on all 14 registers in sequence as the clock propagates...

#. We only did simulate the basic ``inv_x1`` ring.

#. It seems that if we try to simulate more than 32768 patterns something is going
   haywire in ``genpat`` or ``asimut``.
