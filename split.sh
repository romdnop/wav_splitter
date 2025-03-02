#!/bin/bash

# Input file (change this to the actual file path)
INPUT_FILE="Hyperdrive_Boogie.wav"
TRACKLIST_FILE="tracklist.txt"
OUTPUT_DIR="tracks"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Read tracklist and process it
while read -r START_TIME END_TIME TITLE; do
    # Convert timestamps to decimal format by removing leading zeros manually
    START_MIN=$(echo "$START_TIME" | cut -d':' -f1 | sed 's/^0*//')
    START_SEC=$(echo "$START_TIME" | cut -d':' -f2 | sed 's/^0*//')
    END_MIN=$(echo "$END_TIME" | cut -d':' -f1 | sed 's/^0*//')
    END_SEC=$(echo "$END_TIME" | cut -d':' -f2 | sed 's/^0*//')
    
    # Handle edge case where numbers become empty (i.e., "00" turns into empty)
    START_MIN=${START_MIN:-0}
    START_SEC=${START_SEC:-0}
    END_MIN=${END_MIN:-0}
    END_SEC=${END_SEC:-0}
    
    START_SEC_TOTAL=$((START_MIN * 60 + $START_SEC))
    END_SEC_TOTAL=$((END_MIN * 60 + $END_SEC))
    DURATION=$((END_SEC_TOTAL - $START_SEC_TOTAL))
    
    # Ensure TITLE is safe for filenames
    #SAFE_TITLE=$(echo "$TITLE" | tr -cd '[:alnum:]_-')
    
    # Handle case where SAFE_TITLE is empty
    #if [[ -z "$SAFE_TITLE" ]]; then
    #    SAFE_TITLE="track_$START_SEC_TOTAL"
    #fi
    echo "Processing track $TITLE. Start: $START_SEC_TOTAL Stop: $END_SEC_TOTAL"
    # Extract the track using ffmpeg
    ffmpeg -y -nostdin -i "${INPUT_FILE}" -ss "${START_SEC_TOTAL}" -t "${DURATION}" -c copy "$OUTPUT_DIR/${TITLE}.wav" &>/dev/null

done < "$TRACKLIST_FILE"

echo "Tracks have been successfully split and saved in $OUTPUT_DIR"
