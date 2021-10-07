# 1.0 Checking whether the first step labelling is alright
# This will erase the existing point tier and generate a new point tier
# The script will check the following errors:
# 1. If each interval contains two points. 
## Error message: ***(label of the interval in tier 1) has 0 points/3 points in the interval". Then you can search the corresponding label in the interval.
# 2. If the first point is 'b' and the if the second point is 'r. 
## Error message: Check the 'b'/'r' interval of ***(label of the interval in tier 1)
# When all the errors are corrected, the final information window will list:
## - There are *** points in the new tier, which means ***/2 interval are marked. 
## - There should be *** missing trials.
# This is an indicator of the number of trials that you should note down in the spreadsheet.
# You might need to rerun the script several times until there is no error messages, and the number of missing trials is correct. 

# You could change the threshold here
int_threshold = 56

labeled_tier_number = 2
new_tier_number = 3

soundID = selected("Sound")
textGridID = selected("TextGrid")

select 'soundID'
intensityID = To Intensity: 100, 0.001, "yes"

select 'textGridID'
num_labels = Get number of intervals... labeled_tier_number
Remove tier... new_tier_number
Insert point tier... new_tier_number point

b = 0
r = 0

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
  endif
endfor

select 'intensityID'
Remove

## Check the content: whether there are two time points, whether the first is b and the second is r

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
