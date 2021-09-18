# Extract sound & intervals with 'r' marker
# Based on the selection of the two newly gegerated files "measure"
# The sound will be saved under a subfolder called "Chronset", make sure to set up corresponding participant folder beforehand
# By Katrina Li 12/9/2021

sound = selected("Sound")
textgrid = selected("TextGrid")

soundname$ = selected$("Sound")
parid$ = left$(soundname$,length(soundname$)-7)
dataname$ = parid$ + "inten.txt"

infortier = 1
annotier = 2
pointtier = 3

outdir$ = "./Chronset/" + parid$ + "/"

select 'textgrid'
num_interval = Get number of intervals... annotier

# extract wav files marked with 'r'
n=0
for i from 1 to num_interval
	select 'textgrid'
	label$ = Get label of interval: annotier, i
	if label$ == "r"
		n = n+1
		start = Get start time of interval: annotier, i
		end = Get end time of interval: annotier, i
		# special settings if r too short
		end = end + 0.5
		start = start - 0.5
		name = Get interval at time: infortier, start
		name$ = Get label of interval: infortier, name
		select 'sound'
		sound[n] = Extract part: start, end, "rectangular", 1, 0
		Rename: name$
		filename$ = outdir$ + name$ + ".wav"
		Save as WAV file: filename$
		select 'textgrid'
		textgrid[n] = Extract part: start, end, 0
		Rename: name$
	endif
endfor

nocheck selectObject: undefined
for i from 1 to n
	plusObject: textgrid[i]
endfor
newtextgrid = Concatenate

# write out r point time as a txt file
num_point = Get number of points: pointtier
writeFileLine: dataname$, "label", tab$, "time"
for i from 1 to num_point
	pointtime = Get time of point... pointtier i
	name = Get interval at time: infortier, pointtime
	name$ = Get label of interval: infortier, name
	appendFileLine: dataname$, name$, tab$, pointtime
endfor

# Extract the r point tier and save (later to be combined)
# select 'newtextgrid'
# Extract one tier... 3
# newtextgridname$ = parid$ + "onetier"
# Rename: newtextgridname$
# newtextgridnamefile$ = newtextgridname$ + ".TextGrid"
# Save as text file... 'newtextgridnamefile$'

nocheck selectObject: undefined
for i from 1 to n
	plusObject: sound[i]
	plusObject: textgrid[i]
endfor
plusObject: newtextgrid
Remove
