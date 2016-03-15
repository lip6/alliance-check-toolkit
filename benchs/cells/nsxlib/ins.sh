#!/bin/sh
ref=`basename $1 .ap`.ref
ed $1 << EOF
3r $ref
w
q
EOF

