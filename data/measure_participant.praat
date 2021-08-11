# Extract participant parameter

tier = 3
sentence_tier = 1

textGridID = selected("TextGrid")
name$ = selected$("TextGrid")
filename$ = name$ + ".txt"

select 'textGridID'
num_labels = Get number of points... tier
writeFileLine: filename$, "label", tab$, "sentence", tab$, "time"

for i to num_labels
  select 'textGridID'
  time = Get time of point... tier i
  label$ = Get label of point... tier i
  sentence = Get interval at time: sentence_tier, time
  sentence$ = Get label of interval: sentence_tier, sentence
  appendFileLine: filename$, label$, tab$, sentence$, tab$, time
endfor