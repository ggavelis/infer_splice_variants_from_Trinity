#!/usr/bin/bash

module load bioinfo PIPITS # this module loads pandas
cd /scratch/brown/ggavelis/all_dinos/
python ./count_splicing.py $library
echo "sbatch running"