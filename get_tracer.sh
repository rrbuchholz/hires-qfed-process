#!/bin/bash

for i in {2023..2023}
do
  export year=$i
  for t in co2;
  do
    export tracer=$t
    mkdir -p /data16b/buchholz/emissions/qfed_v2.6/orig_0.1/$year
    cd /data16b/buchholz/emissions/qfed_v2.6/orig_0.1/$year

    for m in {1..9}
    do
      for d in {1..9}
      do
        wget --no-check-certificate -nd -r --no-parent https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED/Y$year/M0$m/qfed2.emis_$tracer.061.${year}0${m}0$d.nc4 
      done
      for d in {10..31}
      do
        wget --no-check-certificate -nd -r --no-parent https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED/Y$year/M0$m/qfed2.emis_$tracer.061.${year}0${m}$d.nc4 
      done
    done

    for m in {10..12}
    do
      for d in {1..9}
      do
        wget --no-check-certificate -nd -r --no-parent https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED/Y$year/M$m/qfed2.emis_$tracer.061.${year}${m}0$d.nc4
      done
      for d in {10..31}
      do
        wget --no-check-certificate -nd -r --no-parent https://portal.nccs.nasa.gov/datashare/iesa/aerosol/emissions/QFED/v2.6r1/0.1/QFED/Y$year/M$m/qfed2.emis_$tracer.061.${year}${m}$d.nc4 
      done
    done

  done
done

exit 0

