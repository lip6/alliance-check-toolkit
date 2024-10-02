mer. 02 oct. 2024 18:32:57 CEST
This directory is used to place automatically the connectors uniformally for a block level (core not chip)
In order to use it, go inside a technology directory, copy your .v, change in the dodo.py and  doDesign.py the name of the design.
There are two variables to tune in the doDesign.py:
h,v= ( u(146), u(146) )
That are the the length and the widh of the segments where you place connectors
and:
conf.coreSize            = ( u( 150), u(150) )
That are the dimensions of the core.
Here the connectors are placed uniformally on a size of u(146) when the side has a length of  u(150)
You have also to change the name of the clk and the reset to the one of yout design if you want to build Htrees.
