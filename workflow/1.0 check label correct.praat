# 1.0 Checking whether the first step labelling is alright
# This will erase the existing point tier and generate a new point tier
# The script will check the following errors:
# 1. If the script stopped and says "check the b/r interval of **, which is too short", then expand the b or r interval a bit, so that the intensity curve could be generated
# 2. The final Information window lists if an interval contains not exactly 2 points; and if the first point is not b or the second point is not r.
# When all the errors are corrected, the final information window will only list the number of points in the tier 3 - you want to check this number plus the number of 'missing trials' is 128 (if you can't figure out further missing trials, you can note this down in the spreadsheet).
# You might need to rerun the script several times until the final information window is cleared.

# You could change the threshold here
int_threshold = 35

labeled_tier_number = 2
new_tier_number = 3

soundID = selected("Sound")
textGridID = selected("TextGrid")

select 'textGridID'
num_labels = Get number of intervals... labeled_tier_number
Remove tier... new_tier_number
Insert point tier... new_tier_number point

b = 0
r = 0

writeInfoLine: "b problem:"
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
    intensityb[b] = To Intensity: 100, 0, "yes"
    selectObject: intensityb[b]
    max_int_time = Get time of maximum... 0 0 parabolic

    selectObject: textGridID
    Insert point... new_tier_number max_int_time b
  endif

writeInfoLine: "r problem:"
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
    Insert point... new_tier_number onset_time r
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

## Check the content: whether there are two time points, whether the first is b and the second is r

writeInfoLine: "Check the number of points in point tier for each interval:"

select 'textGridID'
num_sentence = Get number of intervals... 1
num_points_all = Get number of points... new_tier_number
appendInfoLine: "There are ", num_points_all, " points in the tier 3, which means ", num_points_all/2, " interval are marked. "
appendInforLine: "There should be ", 128-num_points_all/2, " missing trials."

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
