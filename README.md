# hires-qfed-process
Processing QFED version 2.6 R1 fire emissions, created by NASA, for use in CESM simulations with atmospheric chemistry. \
This code converts QFED created emissions of CO<sub>2</sub> at 0.1 degree resolution, into all species required for CESM/MUSICA simulations of atmospheric chemistry with full chemistry.
Processing is currently set up for ACOM internal computer modeling1, change paths as necessary.

## Step 1:
Download the base emissions of CO<sub>2</sub>.
Use ``get_tracer.sh`` to download the CO<sub>2</sub> emissions for the dates of interest.
This downloads from 
https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED
Remember to change paths as necessary.

## Step 2:
Convert CO<sub>2</sub> emissions to all other species needed, using emission ratios determined from FINN emission factor tables and VOC speication tables. These have been aggregated into the four QFED vegetation types:\
;         1: Savanna Grasslands\
;         2: Shrublands/Savanna\
;         3: Tropical Forest\
;         4: Extratropical Forest

Requires: \
The downloaded QFED CO2 emissions from **Step 1**, and:\
``BASEEmissionFactors_20221227.csv`` \
``VOC_EmissionSpeciation_20190318.csv`` \
``species_molwts.txt`` 

Use ``combine_qfed_finn_ers_hires.ncl`` to combine QFED CO2 with emission ratios. \
;   To run type {options in curly braces}: \
;         ncl {year=<value>} combine_qfed_finn_ers_hires.ncl

## Step 3:
Redistribute species based on distribution factors.\
;   To run type:\
;        ncl  year=$year 'tracer="BC"' 'outres="0.9x1.25"'  \\ \
;             'emiss_type="from_co2"' $codehome/redistribute_emiss.ncl 

## Step 4:
Upload to glade filesystem.
