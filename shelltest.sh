#!/bin/bash

source ./folders.sh

# Loop through all items in the directory
for folder in "$DVINPUTPUT_DIR"/*; do
    # Check if it's a directory
    if [ -d "$folder" ]; then
        # Get the folder number
        folderNum=$(basename "$folder")
        echo "Processing folder: $folderNum"

        # event file for processing in DV
        eventsFile="/Volumes/SUREFIRE/DVoutput/${folderNum}/events.aedat4"
        # make output dir
        outputdir="${folder}/mkv"
        # make it if it doesn't exist
        #mkdir -p "$folder/mkv"

        # loop through decimation values
        for percent in $(seq 10 5 100); do
            ## TODO: PUT DV CONTROL CODE HERE!
            output_full_filepath="${outputdir}/${folderNum}_sampled_${percent}_percent.mkv"
            echo "Creating ${output_full_filepath}"
            ## TODO: PUT DV CONTROL CODE HERE!
            check_command=""
            while true; do
                result=$($check_command)
                if [ "$result" = "true" ]; then
                    echo "File processing is complete."
                    break
                else
                    echo "Still processing... ($result)"
                fi

                # Wait before checking again
                sleep 10   # check every 10 seconds
            done
        done
       
    fi
done

