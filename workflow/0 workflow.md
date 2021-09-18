# Workflow
## Step 1 (labor)

- Marking 'b' and 'r' in the TextGrid (15-20mins)
  - Shortcut: command +,. (to move to zero crossing), command + 2 (add on boundaries in tier2)
  - response: try to keep some space before the response, but not too much (we want the intensity curve to be a monotoneous increasing line)
  - If there is a missing response (i.e., each recording contains only 1 point label), note down the interval in another file, then erase the 'b' interval as well.

- Save the textgrid file, with the **original filename** (only participant id)

  *Note: The textgrid will contain 3 tiers*

## Step 2

- Select the sound + textgrid file with the original name

Run [1 add point label.praat](1 add point label.praat), it will: 

1. It add point label based on intensity
2. It also checks whether you have enough/missing marks (you should note down the missing responses)
3. Read point b- start of r interval -> generate "**timep1.txt**"

- First, read the message in the infor window, to see if there is an interval that does not generate two points. It could be that you accidentally add a space before/after the symbol.  

- Rerun the script until  1) there are correct number of points in each interval. 2) the onset seems reasonable for most cases (especially for fricatives th,s,f, which is the weakness of Chronset)

- Save the sound+textgrid file. They will end in **suffix "measure"**

  *Note: The textgrid will contain 3 tiers*

## Step 3

- Set up a new folder with the participant id in the folder named 'Chronset'
- Select the sound & textgrid files with suffix "measure"

Run [2 extract rpart.praat](2 extract rpart.praat), it will: 

1. Extract r part sound, which will feed into Chronset  -> the files will be saved to the newly created folder
3. Extract intensity-based timepoint -> generate "**inten.txt**"

## Step 4

Directly compress the generated files (not the folder!), and upload the zip to [Chronset](https://www.bcbl.eu/databases/chronset).

You will receive a txt file in your email box, and save it to the same folder. 

## Step 5 (labor)
- make sure you have put the file 'correctans.csv' in the folder

Run [3 check accuracy and onset.praat](3 check accuracy and onset.praat), it will: 

1. Extract Chronset-based timepoint -> generate '**chronset.txt**'
2. Walk you through the checking process. You will be able to specify whether the response is correct, and if not, what is the alternative, as well as other notes. You will also determine a most suitable speech onset (from inten.txt or chronset.txt), or specify a new point manually (shortcut: command 0 to move to the nearest zero crossing).

- Save the newly generated sound+textgrid ending in "**check**".
- You could also stop in the middle and save the files. Next time rerun the script, it will read the saved files, and you can click 'next' to the interval where you stop.
- If you prefer manually mark the speech onset, you could also not follow the walk through process.

## Step 6

- Select the sound+textgrid files ending in "check"

Run [4 Write out final data.praat](4 Write out final data.praat), it will

1. Read the second particial reaction time into ''**timep2.txt**"
2. Check if you are missing a point mark

- Rerun the script until the information window is cleared

  

**Do follow the workflow, you can make modification within a step and rerun the script multiple times - but later on if you want to modify a previous step, you need to rerun the following steps as well. **

## Other works to do

- Not correctly named files
- Check the DARLA marking for stimuli files



