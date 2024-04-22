#!/bin/bash

#-------------------
# Redistributes emissions using a ncl script
# cycling through options because of high
# data content due to high resolution (0.1 degree)
#-------------------

arr=(OC BC SO4 VBS SOAG)       # options
#arr=(OC BC SO4 VBS SOAG SOAG1.5)       # options
year_arr=(2023)     # options
echo ${arr[@]}
echo ${year_arr[@]}

for y in ${year_arr[@]} ; do
    echo "-----------------------------------------"
    echo "processing" ${y}

    for x in ${arr[@]} ; do
        echo "processing" ${x}

        # 4 files for each OC and BC 
        if [[ ${x} == "OC" || ${x} == "BC" ]]; then
          echo "----------------${x}"
          for z in {1..4}; do
            echo "ncl 'tracer="${x}"' 'outres = "hires"' 'year="${y}"' 'PROCESSNUM=${z}' redistribute_emiss_hires.ncl"
            ncl 'tracer="'${x}'"' 'outres = "hires"' 'year="'${y}'"' 'PROCESSNUM="'${z}'"' redistribute_emiss_hires.ncl
          done

        # 3 files for SO4
        elif [[ ${x} == "SO4" ]]; then 
          echo "----------------${x}"
          for z in {1..3}; do
            echo "ncl 'tracer="${x}"' 'outres = "hires"' 'year="${y}"' 'PROCESSNUM=${z}' redistribute_emiss_hires.ncl"
            ncl 'tracer="'${x}'"' 'outres = "hires"' 'year="'${y}'"' 'PROCESSNUM="'${z}'"' redistribute_emiss_hires.ncl
          done

        # Subset files for IVOC then 1 file, 1 file for SVOC
        elif [[ ${x} == "VBS" ]]; then
          for z in {1..2}; do
            if [[ ${z} == 1 ]]; then
              for s in SUBSETA SUBSETB; do
      	        echo "ncl 'tracer="${x}"' 'outres = "hires"' 'year="${y}"' 'PROCESSNUM=${z}' '"${s}"="True"' redistribute_emiss_hires.ncl"
                ncl 'tracer="'${x}'"' 'outres = "hires"' 'year="'${y}'"' 'PROCESSNUM="'${z}'"' '"${s}"="True"' redistribute_emiss_hires.ncl
              done
            else
      	        echo "ncl 'tracer="${x}"' 'outres = "hires"' 'year="${y}"' 'PROCESSNUM=${z}' redistribute_emiss_hires.ncl"
                ncl 'tracer="'${x}'"' 'outres = "hires"' 'year="'${y}'"' 'PROCESSNUM="'${z}'"' redistribute_emiss_hires.ncl
            fi
          done

        # 1 file for SOAG
        elif [[ ${x} == "SOAG" ]]; then
          echo "----------------${x}"
      	  echo "ncl 'tracer="${x}"' 'outres = "hires"' 'year="${y}"' redistribute_emiss_hires.ncl"
          ncl 'tracer="'${x}'"' 'outres = "hires"' 'year="'${y}'"' redistribute_emiss_hires.ncl

        else
            echo "skipping"
        fi

    done

    echo "-----------------------------------------"
    echo "DONE"

done


