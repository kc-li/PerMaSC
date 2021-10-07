# Extract sound & intervals with 'r' marker
# Based on the selection of the two newly gegerated files "measure"
# The sound will be saved under a subfolder called "Chronset", make sure to set up corresponding participant folder beforehand
# Allowing you to add in some space before uploading to Chronset - but you should remember this space, and substract it at the final extracting step
# By Katrina Li 12/9/2021

# These parameters should be kept the same in the step 3 script file.
start_space = 0.5
end_space = 0.5

sound = selected("Sound")
textgrid = selected("TextGrid")

soundname$ = selected$("Sound")
parid$ = left$(soundname$,length(soundname$)-7)
dataname$ = parid$ + "inten.txt"

infortier = 1
annotier = 2
pointtier = 3

outdir$ = "Chronset/" + parid$ + "/"

select 'textgrid'
num_interval = Get number of intervals... annotier
finalend = Get end time

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
		new_end = end + end_space
		new_start = start - start_space
		name = Get interval at time: infortier, start
		name$ = Get label of interval: infortier, name
		select 'sound'

		# if exceeds the final end, then we'll use the original time scale
		if new_end < finalend
			sound[n] = Extract part: new_start, new_end, "rectangular", 1, 0
		else
			sound[n] = Extract part: new_start, finalend, "rectangular", 1, 0
		endif
		Rename: name$

		filename$ = outdir$ + name$ + ".wav"
		Save as WAV file: filename$

		select 'textgrid'
		if new_end < finalend
			textgrid[n] = Extract part: new_start, new_end, 0
		else
			textgrid[n] = Extract part: new_start, finalend, 0
		endif
		Rename: name$

	endif
endfor

# Generate this new textgrid so that we could extract intensity measurement based on this. It should be aligned with the Chronset data.
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
