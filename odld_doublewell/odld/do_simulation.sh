#!/bin/bash

BSTATES="--bstate initial,8.0"
#TSTATES="--tstate drift,10.01 --tstate bound,1.3"
TSTATES="--tstate bound,1.2"

conda run -n docker_westpa w_init $BSTATES $TSTATES

conda run -n docker_westpa w_run