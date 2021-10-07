# Based on selected sound & textgrid (original name)
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

select 'textGridID'
num_labels = Get number of intervals... labeled_tier_number
Remove tier... new_tier_number
Insert point tier... new_tier_number point


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

# Based on the modified intensity curve, the estimation of intensity should be better
select 'soundID'
intensityID = To Intensity: 100, 0.001, "yes"

b = 0
r = 0

dataname$ = "datafile/" + name$ + "timep1.txt"
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

    selectObject: textGridID
    Insert point: new_tier_number, max_int_time, "b"
    sentence_label = Get interval at time... 1 max_int_time
  	sentence_label$ = Get label of interval... 1 sentence_label
	  appendFileLine: dataname$, sentence_label$, tab$, "b", tab$, max_int_time
  endif

  if label$ == "r"
    r = r+1
    start = Get start point: labeled_tier_number, i
    end = Get end point: labeled_tier_number, i
    select 'intensityID'
    p = Get frame number from time: start
    # frames should be an interval
    p = ceiling(p)
    p_end = Get frame number from time: end
    int = Get value in frame: p
    while int < int_threshold & p < p_end
      p = p+1
      int = Get value in frame: p
    endwhile
    onset_time = Get time from frame: p

	  selectObject: textGridID
    Insert point: new_tier_number,onset_time,"r"
	  sentence_label = Get interval at time... 1 onset_time
	  sentence_label$ = Get label of interval... 1 sentence_label
	  appendFileLine: dataname$, sentence_label$, tab$, "rstart", tab$, start
  endif
endfor

select 'intensityID'
Remove

## Check the content
writeInfoLine: "Check the number of points in point tier for each interval:"

select 'textGridID'
num_sentence = Get number of intervals: 1
num_points_all = Get number of points... new_tier_number

appendInfoLine: "There are ", num_sentence, " intervals (recording files)."
appendInfoLine: "There are ", num_points_all, " points in the tier 3, which means ", num_points_all/2, " intervals are marked. "
appendInfoLine: "Missing trials: There should be ", num_sentence-num_points_all/2, " missing trials."

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
  else
    point1$ = Get label of point... new_tier_number 1
    point2$ = Get label of point... new_tier_number 2
    if point1$ != "b"
      appendInfoLine: "Check the b interval of ", label$
    endif
    if point2$ != "r"
      appendInfoLine: "Check the r interval of ", label$
    endif
  endif
endfor

nocheck selectObject: undefined
for i to num_sentence
  plusObject: part[i]
endfor
Remove
