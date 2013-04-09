#!/bin/bash
cd ~/Projects
cd CMake
cmakemake.sh
cmakeinstall.sh
cd ../include
cmakemake.sh
cmakeinstall.sh
