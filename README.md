# hires-qfed-process
Processing QFED version 2.6 R1 fire emissions, created by NASA, and applying conversion factors for use in CESM simulations with atmospheric chemistry. This code converts QFED created emissions of CO<sub>2</sub> at 0.1 degree resolution, into all species required for CESM/MUSICA simulations of atmospheric chemistry with full chemistry.

Processing is currently set up for the ACOM internal computer system ``modeling1``. Please change paths as necessary.

## Step 1:
Download the base emissions of CO<sub>2</sub>.
Use ``get_tracer.sh`` to download the CO<sub>2</sub> emissions for the dates of interest.
This downloads from 
https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED
. Remember to change paths as necessary.

## Step 2:
Convert CO<sub>2</sub> emissions to all other species needed, using emission ratios determined from FINN emission factor tables and VOC speication tables. These have been aggregated into the four QFED vegetation types:\
;         1: Savanna Grasslands\
;         2: Shrublands/Savanna\
;         3: Tropical Forest\
;         4: Extratropical Forest

Requires: \
The downloaded QFED CO<sub>2</sub> emissions from **Step 1**, and:\
``BASEEmissionFactors_20221227.csv`` \
``VOC_EmissionSpeciation_20190318.csv`` \
``species_molwts.txt`` 

Use ``combine_qfed_finn_ers_hires.ncl`` to combine QFED CO<sub>2</sub> with emission ratios. \
To run type {options in curly braces}:
   >     ncl {year=\<value\>} combine_qfed_finn_ers_hires.ncl

Default year is 2023. The timing takes about **5 minutes per species**. Plan on this step taking about 4 hours.\
Emission factor method: CO2, CO, CH4, NH3, SO2, OC, BC, NO, NO2, NMHC, BENZENE, C2H2, C2H4, C2H6, C3H6, C3H8, CH2O, CH3CHO, CH3COCH3, CH3COOH, CH3OH, DMS, GLYALD, HCN, HCOOH, ISOP, MACR, MEK, MVK, TOLUENE, XYLENES \
VOC speciation method: BIGALD, BIGALK, BIGENE, TERPENES, C2H5OH, CH3CN, CH3COCHO, CRESOL, HYAC

At the end of this step, you should have XX emission files.

## Step 3:
Redistribute species based on distribution factors.\
To run type:
   >     ncl  year=$year '{tracer="\<value\>"}' 'outres="hires"'  \\ 
   >         'emiss_type="from_co2"' $codehome/redistribute_emiss_hires.ncl 

There are 5 tracer types this needs to happen for:\
OC, BC, VBS, SOAG, SO4

Summary of this processing step depending on tracer choice:
|   split OC or BC into 2 files:  |     tracer choice |
| --------------------------------|-------------------|
|           OC1 50%, OC2 50%      |       OC          |
|           CB1 80%, CB2 20%      |       BC          |

|   create combined species       |     tracer choice |
| --------------------------------|-------------------|
|           bc_a4       = BC      |       BC          |
|           num_bc_a4             |       BC          |
|           pom_a4      = 1.4 * OC|       OC          |
|           num_pom_a4            |       OC          |
|           SVOC        = combined|       VBS ***     |
|           IVOC        = combined|       VBS ***     |
|           SOAG        = combined|       SOAG        |
|           so4_a1                |       SO4         |
|           num_so4               |       SO4         |

*** Needs to be split into 2 processing parts for highres for the SVOC.

At the end of this step, you should have XX emission files.

## Step 4:
Upload the 0.1 degree files to glade filesystem:
   > scp /data16b/\<username\>/emissions/qfed_v2.6/cam_hires/from_co2/2023/*
   >      \<username\>\@data-access.ucar.edu:/glade/campaign/acom/acom-weather/MUSICA/emissions/qfed2.6_finn/f0.1/

Process further with MUSICA regridding tools if needed in other resolutions (e.g. MPAS, SE regional refinement, etc.) See the MUSICA Wiki: https://wiki.ucar.edu/display/MUSICA/Regridding+emissions.
