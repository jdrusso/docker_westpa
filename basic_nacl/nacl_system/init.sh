#!/bin/bash

source env.sh

# Clean up from previous/ failed runs
rm -rf traj_segs seg_logs istates west.h5 
mkdir   seg_logs traj_segs istates

# Set pointer to bstate and tstate
BSTATE_ARGS="--bstate-file $WEST_SIM_ROOT/sbstates/bstates.txt"
TSTATE_ARGS="--tstate-file $WEST_SIM_ROOT/tstate.file"
SSTATE_ARGS="--sstate-file $WEST_SIM_ROOT/sbstates/sstates.txt"

# Run w_init
conda run --no-capture-output -n docker_westpa_nacl w_init \
  $BSTATE_ARGS \
  $TSTATE_ARGS \
  $SSTATE_ARGS \
  --segs-per-state 5 \
  --work-manager=threads
