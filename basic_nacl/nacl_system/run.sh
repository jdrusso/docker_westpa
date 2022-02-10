#!/bin/bash

source env.sh

# Clean up
rm -f west.log

# Run w_run
# conda run -n docker_westpa_nacl w_run --work-manager processes | tee west.log
conda run --no-capture-output -n docker_westpa_nacl w_run --work-manager processes 2>&1 | tee west.log
