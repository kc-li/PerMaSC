# 3.0 step 2 checking
# This file checks if
# - if tier 3 only contains 1 point in each interval
# - if the point is labelled 'check'
# - if label in the tier 4 start with 0 or 1 (so that accuracy can be extracted)

check_tier = 3
accuracy_tier = 4

soundID = selected("Sound")
textGridID = selected("TextGrid")

select 'textGridID'
num_sentence = Get number of intervals: 1

writeInfoLine: "Check the check points and accuracy interval for each interval:"
for i to num_sentence
  select 'textGridID'
  label$ = Get label of interval: 1, i
  start = Get start point: 1, i
  end = Get end point: 1, i
  part[i] = Extract part: start, end, 1
  selectObject: part[i]

  num_points = Get number of points: check_tier
  # there should be only 1 point in the interval, and marked with "check"
  if num_points != 1
    appendInfoLine: label$, tab$, "has", tab$, num_points, tab$, "point in that interval."
  else
    point1$ = Get label of point... check_tier 1
    if point1$ != "check"
      appendInfoLine: "Check the point tier of ", label$
    endif
  endif

  # accuracy tier should start with either 1 or 0
  accuracy$ = Get label of interval: accuracy_tier, 1
  if !startsWith(accuracy$, "1") & !startsWith(accuracy$,"0")
    appendInfoLine: "Check the accuracy tier of ", label$
  endif
endfor

nocheck selectObject: undefined
for i to num_sentence
  plusObject: part[i]
endfor
Remove
