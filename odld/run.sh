#!/bin/bash

rm -f west.log
conda run -n docker_westpa w_run | tee west_run.log