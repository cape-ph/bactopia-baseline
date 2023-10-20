#!/usr/bin/env bash
# This script is meant to run through the bactopia (v3) tutorial found here:
# https://bactopia.github.io/v3.0.0/tutorial/ for the purposes of poking it to
# see what it does such that we can get a little idea of an estimate of what it
# may cost to run in various AWS architectures. It is not meant to be the best
# exmaple of how to write bash or do any other things well.

# run with `sudo bash -l -c /home/vagrant/run-bactopia-local.sh`

# Run bactopia
bactopia -profile docker \
    --max_cpus 4 \
    --max_memory 6 \
    --accession SRX4563634 \
    --coverage 100 \
    --genome_size 2800000 \
    --outdir /output
