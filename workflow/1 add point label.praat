# Based on selected sound & textgrid
# The script is composed of three parts
# 1.Compress the intensity of the non-marked intervals, for a cleaer intensity curve
# 2. For intervals with 'b', add the point at the maximum intensity; for intervals with 'r', add the point at speech onset according to instensity
# 3. Check the number of point labels
# 4. Read the first part of reaction time
# By Katrina Li 13/7/2021

form
real int_threshold 40
endform

labeled_tier_number = 2
new_tier_number = 3

sound_original = selected("Sound")
textGrid_original = selected("TextGrid")
name$ = selected$("TextGrid")
newname$ = name$ + "measure"

select 'textGrid_original'
textGridID = Copy... 'newname$'
num_labels = Get number of intervals... labeled_tier_number

# Generate compressed sound files
n=0
for i to num_labels
  select 'textGridID'
  label$ = Get label of interval: labeled_tier_number, i
  start = Get start point: labeled_tier_number, i
  end = Get end point: labeled_tier_number, i
  select 'sound_original'
  n = n+1
  sound[n] = Extract part: start, end, "rectangular", 1, 1
  if label$ != "b" & label$ != "r"
    selectObject: sound[n]
    Scale intensity... 1
  endif
endfor

nocheck selectObject: undefined
for m from 1 to n
  plusObject: sound[m]
endfor
soundID = Concatenate
Rename... 'newname$'

nocheck selectObject: undefined
for m from 1 to n
  plusObject: sound[m]
endfor
Remove

b = 0
r = 0

dataname$ = "datafile/" + name$ + "timep1.txt"
writeFileLine: dataname$, "label", tab$, "timetype", tab$, "timepoint"
for i to num_labels
  select 'textGridID'
  label$ = Get label of interval: labeled_tier_number, i

  if label$ == "b"
    start = Get start point: labeled_tier_number, i
    end = Get end point: labeled_tier_number, i
    b = b+1
	  select 'soundID'
    soundb[b] = Extract part: start, end, "rectangular", 1, 1

    selectObject: soundb[b]
    intensityb[b] = To Intensity... 100 0
    selectObject: intensityb[b]
    max_int_time = Get time of maximum... 0 0 parabolic

    selectObject: textGridID
    nocheck Insert point... new_tier_number max_int_time b
	sentence_label = Get interval at time... 1 max_int_time
	sentence_label$ = Get label of interval... 1 sentence_label

	appendFileLine: dataname$, sentence_label$, tab$, "b", tab$, max_int_time
  endif

  if label$ == "r"
    start = Get start point: labeled_tier_number, i
    end = Get end point: labeled_tier_number, i
    r = r+1
	   select 'soundID'
    soundr[r] = Extract part: start, end, "rectangular", 1, 1
    selectObject: soundr[r]
    intensityr[r] = To Intensity... 100 0
    f = Get number of frames

    p = 1
    int = Get value in frame: p
    while int < int_threshold
      p = p+1
      int = Get value in frame: p
    endwhile
    onset_time = Get time from frame: p

	selectObject: textGridID
    nocheck Insert point... new_tier_number onset_time r
	sentence_label = Get interval at time... 1 onset_time
	sentence_label$ = Get label of interval... 1 sentence_label
	appendFileLine: dataname$, sentence_label$, tab$, "rstart", tab$, start
  endif
endfor

nocheck selectObject: undefined
for i from 1 to b
	plusObject: intensityb[i]
	plusObject: soundb[i]
endfor
Remove

nocheck selectObject: undefined
for i from 1 to r
	plusObject: intensityr[i]
	plusObject: soundr[i]
endfor
Remove

## Check the content

writeInfoLine: "Check the number of points in point tier for each interval:"
select 'textGridID'
num_sentence = Get number of intervals... 1
for i to num_sentence
  select 'textGridID'
  label$ = Get label of interval: 1, i
  start = Get start point: 1, i
  end = Get end point: 1, i
  part[i] = Extract part: start, end, 1
  selectObject: part[i]
  num_points = Get number of points... new_tier_number
  if num_points !=2
    appendInfoLine: label$, tab$, "has", tab$, num_points, tab$, "point in that interval."
  endif
endfor

nocheck selectObject: undefined
for i to num_sentence
  plusObject: part[i]
endfor
Remove
