# 4 Write Out final data
# Based on selected files with "check" suffix, and extract data file
# It also check if there is an interval that has more than 1 point

soundid = selected("Sound")
textgridid = selected("TextGrid")
soundname$ = selected$("Sound")
parid$ = soundname$ - "check"
finalfilename$ = "datafile/"+parid$ +"timep2.txt"

writeFileLine: finalfilename$, "label", tab$, "correctans",tab$, "note", tab$, "duration2"

select textgridid
num_of_points = Get number of points... 3
for i from 1 to num_of_points
  pointlabel$ = Get label of point... 3 i
  if pointlabel$ == "check"
    confirmed_point = Get time of point... 3 i
    interval = Get interval at time... 1 confirmed_point
    label$ = Get label of interval... 1 interval
    correctans$ = Get label of interval... 2 interval
    note$ = Get label of interval... 4 interval
    start = Get starting point... 1 interval
    duration2 = confirmed_point - start
    appendFileLine: finalfilename$, label$, tab$, correctans$, tab$, note$, tab$, duration2
  endif
endfor

# Check if the numsber of points in point tier
writeInfoLine: "Check the number of points in point tier for each interval:"
select 'textgridid'
num_sentence = Get number of intervals... 1
for i to num_sentence
  select 'textgridid'
  label$ = Get label of interval: 1, i
  start = Get start point: 1, i
  end = Get end point: 1, i
  part[i] = Extract part: start, end, 1
  selectObject: part[i]
  num_points = Get number of points... 3
  if num_points !=1
    appendInfoLine: label$, tab$, "has", tab$, num_points, tab$, "point in that interval."
  endif
endfor

nocheck selectObject: undefined
for i to num_sentence
  plusObject: part[i]
endfor
Remove
