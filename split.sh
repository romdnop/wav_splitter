#!/bin/bash

# Input file (change this to the actual file path)
INPUT_FILE="Hyperdrive_Boogie.wav"
TRACKLIST_FILE="tracklist.txt"
OUTPUT_DIR="tracks"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Read tracklist and process it
PREV_TIME=0
INDEX=1
FIRST_TRACK=1

# Extract timestamps and names from the tracklist
awk 'NR>1 {print substr($0, 1, 5), substr($0, 7)}' "$TRACKLIST_FILE" | while read -r TIME TITLE; do
    # Convert timestamp to seconds
    IFS=':' read -r MIN SEC <<< "$TIME"
    START_TIME=$((MIN * 60 + SEC))
    
    # Ensure TITLE is safe for filenames
    SAFE_TITLE=$(echo "$TITLE" | tr -cd '[:alnum:]_-')
    
    # If not the first track, determine duration of previous track
    if [[ $FIRST_TRACK -eq 0 ]]; then
        DURATION=$((START_TIME - PREV_TIME))
        #ffmpeg -i "$INPUT_FILE" -ss "$PREV_TIME" -t "$DURATION" -c copy "$OUTPUT_DIR/${PREV_SAFE_TITLE}.wav"
    else
        FIRST_TRACK=0
    fi
    
    PREV_TIME=$START_TIME
    PREV_TITLE="$TITLE"
    PREV_SAFE_TITLE="$SAFE_TITLE"
    INDEX=$((INDEX + 1))

done

# Handle last track (from last start time to the end)
#ffmpeg -i "$INPUT_FILE" -ss "$PREV_TIME" -c copy "$OUTPUT_DIR/${PREV_SAFE_TITLE}.wav"

echo "Tracks have been successfully split and saved in $OUTPUT_DIR"
