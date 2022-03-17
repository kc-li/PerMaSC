# This script read all textgrid files in the folder, and extract the start of interval time
#dir$ = "/Volumes/S8/Mask project/Processing/processed_step3_26_26_final"
#dir$ = "/Volumes/S8/Mask project/Processing/processed_step1_26_26_c71_missing/"
dir$ = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/interspeech/soundstart_stimuli/"
dirtext$ = dir$ + "/" + "*.TextGrid"
outdir$ = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/interspeech/soundstart_stimuli"
textgridlist = Create Strings as file list: "textgridlist", dirtext$

selectObject: textgridlist
numfiles = Get number of strings
starttier = 1
for filenum from 1 to numfiles
  selectObject: textgridlist
  filename$ = Get string: filenum
  file = Read from file: dir$ + "/" + filename$
  textgrid = selected("TextGrid")
  textgrid_name$ = selected$("TextGrid")
  output_name$ = outdir$ + "/" + textgrid_name$ - ".TextGrid" + "_start.txt"
  writeFileLine: output_name$, "label", tab$, "start_time"


  # Deal with the textgrid
  select 'textgrid'
  numintervals = Get number of intervals: starttier
  for i from 1 to numintervals
    start = Get start time of interval: starttier, i
    label$ = Get label of interval: starttier, i
    appendFileLine: output_name$, label$, tab$, start
  endfor
endfor
