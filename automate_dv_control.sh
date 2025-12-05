#!/bin/bash

source ./folders.sh
# Loop through all items in the directory
for folder in "$DVINPUTPUT_DIR"/*; do
	echo "folder $folder"
    # Check if it's a directory
    if [ -d "$folder" ]; then
        # Get the folder number
        folderNum=$(basename "$folder")
        echo "Processing folder: $folderNum"

        # event file for processing in DV
        eventsFile="${ROOT_PATH}/SUREFIRE/DVoutput/${folderNum}/events.aedat4"
        # make output dir
        outputdir="${folder}/mkv"
        # make it if it doesn't exist
        #mkdir -p "$folder/mkv"

        # loop through decimation values
        for percent in $(seq 10 5 100); do
            output_full_filepath="${outputdir}/${folderNum}_sampled_${percent}_percent.mkv"
            # DV-config
            dv-control <<EOF
set /mainloop/decimation/ percentage ${percent}
set /mainloop/decimation/ running true
set /mainloop/dvsnoisefilter/ running true
set /mainloop/dvsnoisefilter/ hotPixelEnable true
set /mainloop/dvsnoisefilter/ hotPixelLearn true
set /mainloop/event_visualizer/ running true
set /mainloop/event_visualizer/ backgroundColor ${BG_COLOR}
set /mainloop/event_visualizer/ positiveColor ${PS_COLOR}
set /mainloop/event_visualizer/ negativeColor ${NG_COLOR}
set /mainloop/input_file/ file ${eventsFile}
set /mainloop/input_file/ running true
exit
EOF
            sleep 0.2
            echo "Now creating ${folderNum}_sampled_${percent}_percent.mkv"

            #check if file is done being processed
            while true; do
                result=$(dv-control <<EOF
get /mainloop/input_file/ isRunning
exit
EOF
)
                if [ "$result" = "false" ]; then
                    echo "File has been processed. Output is at: ${output_full_filepath}"
                    break
                fi

                echo "Still processing..."
                sleep 30
            done
            
        done
       
    fi

done