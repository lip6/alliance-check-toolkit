#!/bin/bash
for i in check/*.spi; do if [ ! -f check/`basename $i .spi`.ok ]; then echo `basename $i .spi`; fi; done
