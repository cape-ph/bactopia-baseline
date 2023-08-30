#!/usr/bin/env bash
# This script is meant to run through the bactopia (v2) tutorial found here:
# https://bactopia.github.io/v2.2.0/tutorial/ for the purposes of poking it to 
# see what it does such that we can get a little idea of an estimate of what it
# may cost to run in various AWS architectures. It is not meant to be the best 
# exmaple of how to write bash or do any other things well. 

# run with sudo for now

hdatasetdir=/var/bactopia/datasets
cdatasetdir=/datasets
hamrdir=${hdatasetdir}/antimicrobial-resistance

houtdir=/var/bactopia/output
coutdir=/output

echo "Creating the dataset directory if needed."
if [[ ! -e ${hdatasetdir} ]]; then
    mkdir -p ${hdatasetdir}
fi

echo "Creating the output directory if needed."
if [[ ! -e ${houtdir} ]]; then
    mkdir -p ${houtdir}
fi

# hack around a bug in the AMRFinder+ tutorial stuff for bactopia version 2
# NOTE: this is fixed in version 3 and is not necessary
echo "Doing hack stuff for AMRFinder+ bug in bactopia 2"
if [[ ! -e ${hdatasetdir}/antimicrobial-resistance ]]; then
    mkdir -p ${hdatasetdir}/antimicrobial-resistance
fi

curl https://datasets.bactopia.com/datasets/v2.2.0/amrfinderdb.tar.gz \
    -o ${hamrdir}/amrfinderdb.tar.gz

date -u +"%Y-%m-%dT%H:%M:%SZ" >${hamrdir}/amrfinderdb-updated.txt

# symlinks don't work here if made for the host and then mounted into the
# container. so cp just to make things happen. a touch may be sufficient for the
# tar.gz (instead of copy) as it appears that only the existence of the file is
# checked for in the buggy code
cp ${hamrdir}/amrfinderdb-updated.txt ${hamrdir}/amrfinder-updated.txt
cp ${hamrdir}/amrfinderdb.tar.gz ${hamrdir}/amrfinder.tar.gz
echo "END hack stuff for AMRFinder+ bug in bactopia 2"

echo "Building datasets"
docker run --volume ${hdatasetdir}:${cdatasetdir} \
    --name bactopia-datasets-container \
    bactopia/bactopia /bin/bash -c "
        printf '==== Updating ncbi-genome-download ====\n' &&
        conda install -y -c bioconda ncbi-genome-download=0.3.3 &&
        printf '\n\n==== Pulling bactopia datasets ====\n' &&
        bactopia datasets \
            --outdir ${cdatasetdir} \
            --species 'Staphylococcus aureus' \
            --include_genus \
            --limit 100 \
            --cpus 1"

docker logs -f bactopia-datasets-container

echo "cloning the repo of staphylococcus-aureus datasets"
git clone https://github.com/bactopia-datasets/staphylococcus-aureus.git

echo "copying staphylococcus-aureus datasets to previously built datasets"
cp -r staphylococcus-aureus/species-specific/ ${hdatasetdir}/
rm -rf staphylococcus-aureus/

echo "running bactopia on datasets"
docker run --volume ${hdatasetdir}:${cdatasetdir} --volume ${houtdir}:${coutdir} \
    --name bactopia-run-container \
    bactopia/bactopia bactopia --accession SRX4563634 \
    --datasets ${cdatasetdir} \
    --species "Staphylococcus aureus" \
    --coverage 100 \
    --genome_size median \
    --outdir ${coutdir}/ena-single-sample \
    --max_cpus 1

docker logs -f bactopia-run-container

echo "complete"
