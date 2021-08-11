# Steps
## Preprocessing the data (Katrina)
1. Python: rename audio files in the folder
2. Praat (specify file name): combine the audio files into one 'sound' and one 'textgrid' file

## Annotation (Sharedwork)
### 1. Praat: Do the annotation

The textgrid file contains three tiers:
[picture]

-  For the 'beep' sound, you should select the range of sound (no need to be accurate, but make sure the peak is in), and add interval on tier 2, with a marker 'b'

-  For the reponse sound, you could either

  -  i. (Recommended) mark its range in tier 2 (better to be a narrow range, especially concerning the intensity contour at the beginning), add interval on tier 2, with marker 'r'

  -  ii. mark the onset point in tier 3 directly withan a marker 'r'.

  - But note: Either use i. or ii., otherwise there will be multiple 'r's. The praat script in the next step (also an separate file) could be used to quickly check whether the number of point labels are right.

- Save the sound & textgrid files!!!

### 2. Praat: Run the script 'add point label.praat'
[script](./add point label.praat)

- The script will generate a sound file '\*measure' and a textgrid '\*measure', with point labels added to tier 3.

- You may need to run the script one or two times to find a suitable threshold parameter.

- The information window will show a list the intervals that contains more than 2 labels. You want to change those in the newly generated textgrid file.

- Save the new sound&textgird files. These files will be used to extract duration parameters.

### 3. Check the label:
- Are there exactly two points for each interval now? You can run 'checkpoint.praat' to check again.

  [script](./checkpoint.praat)

- Check if the onset of the speech is correct

- （Check the accuracy of the pronunciation）

## Data extraction & analysis (Katrina)
- Praat: run 'measure_participant.praat'

  [script](./data/measure_participant.praat)

- R: analysis


## Futhur examination work

- What is the start point of calculating the response time? （should check the DARLA segmentation)

- Check if the recording the same as specified in the spreadsheet
