#!/bin/bash

# Load variables from file
source ./vars_for_dv.sh

# Loop through all items in the directory
for folder in "$DVINPUTPUT_DIR"/*; do
	echo "folder $folder"
    # Check if it's a directory
    if [ -d "$folder" ]; then
        # Get the folder number
        folderNum=$(basename "$folder")
        echo "Processing folder: $folderNum"

        # Event file for processing in DV
        eventsFile="${ROOT_PATH}/SUREFIRE/DVoutput/${folderNum}/events.aedat4"
        # Output dir
        outputdir="${ROOT_PATH}/SUREFIRE/DVoutput/Varying_Frame_Rates/${folderNum}"
        # Make it if it doesn't exist
        mkdir -p "$outputdir/mkv"


        # loop through frame rates
        rates=(15 20 35 40 80)
        for rate in "${rates[@]}"; do
            output_full_filepath="${outputdir}/${folderNum}_frameRate_${rate}.mkv"
            echo set /mainloop/video_output/ fileName ${output_full_filepath}
            # DV-config
            dv-control <<EOF
set /mainloop/video_output/ fileName ${output_full_filepath}
set /mainloop/video_output/ running true
set /mainloop/video_output/ fps ${rate}

exit
EOF
            dv-control <<EOF
set /mainloop/vihara_frame_vary/ frameRate ${rate}
set /mainloop/vihara_frame_vary/ running true
set /mainloop/input_file/ file ${eventsFile}
set /mainloop/input_file/ running true
exit
EOF
            sleep 0.2
            echo "Now creating ${folderNum}_frameRate_${rate}.mkv"

            # Check if file is done being processed
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