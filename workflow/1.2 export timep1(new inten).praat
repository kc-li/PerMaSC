# Regenerate intensity file and find maximum
# Based on original files are fine
# Export timep1.txt only
# You don't need to save the sound&textgrid files


labeled_tier_number = 2
new_tier_number = 3

soundID = selected("Sound")
textGridID = selected("TextGrid")
name$ = selected$("TextGrid")
parid$ = name$

select 'soundID'
intensityID = To Intensity: 100, 0.001, "yes"

select 'textGridID'
num_labels = Get number of intervals... labeled_tier_number

b = 0
r = 0

dataname$ = "datafile/" + parid$ + "timep1.txt"
writeFileLine: dataname$, "label", tab$, "timetype", tab$, "timepoint"

for i to num_labels
  select 'textGridID'
  label$ = Get label of interval: labeled_tier_number, i

  if label$ == "b"
    b = b+1
    start = Get start point: labeled_tier_number, i
    end = Get end point: labeled_tier_number, i
    select 'intensityID'
    max_int_time = Get time of maximum: start, end, "parabolic"
	select 'textGridID'
    sentence_label = Get interval at time: 1, max_int_time
    sentence_label$ = Get label of interval: 1, sentence_label
    appendFileLine: dataname$, sentence_label$, tab$, "b", tab$, max_int_time
  endif

  if label$ == "r"
    r = r+1
    rstart = Get start point: labeled_tier_number, i
    sentence_label = Get interval at time: 1, rstart
    sentence_label$ = Get label of interval: 1, sentence_label
    appendFileLine: dataname$, sentence_label$, tab$, "rstart", tab$, rstart

  endif
endfor

select 'intensityID'
Remove
