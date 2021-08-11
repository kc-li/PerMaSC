# Check how many point labels for each sentence

new_tier_number = 3

writeInfoLine: "Check the number of points in point tier for each interval:"
textGridID = selected("TextGrid")
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
