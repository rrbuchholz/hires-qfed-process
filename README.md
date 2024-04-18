# hires-qfed-process
Processing QFED fire emissions for use in CESM. \
This code converts QFED created emissions of CO<sub>2<\sub> at 0.1 degree resolution, into all species required for CESM/MUSICA simulations of atmospheric chemistry with full chemistry.
Processing is currently set up for ACOM internal computer modeling1, change paths as necessary.

## Step 1:
Download the base emissions of CO2.
Use get_tracer.sh to download the CO2 emissions for the dates of interest.
This downloads from 
https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED

## Step 2:

