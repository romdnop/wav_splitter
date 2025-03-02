# About

A simple bash script to cut a monolithic \*.wav file into separate tracks with time codes provided in tracklist.txt

# Usage

- Make sure that the **tracklist.txt** is present and has the following format:

00:00 03:59 Mercury  
04:00 07:59 Saturn  
08:00 11:53 Venus  
11:54 15:54 Jupiter  
15:55 19:06 Mars  
19:07 22:23 Earth  
...

> Note: the **tracklist.txt** file must have an empty line at the end

- Specify correct ouput directory in **INPUT_FILE** variable of **split.sh** file
- The same applies to **TRACKLIST_FILE** variable and **OUTPUT_DIR**

---

# Dependencies

- [ffmpeg](https://ffmpeg.org/) is required
