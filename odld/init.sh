#!/bin/bash

BSTATES="--bstate initial,8.0"
TSTATES="--tstate bound,1.2"

conda run -n docker_westpa w_init $BSTATES $TSTATES | tee west_init.log
