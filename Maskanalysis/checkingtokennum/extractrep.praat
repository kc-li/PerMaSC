num_of_intervals = Get number of intervals: 6
m = 0

for i from 1 to num_of_intervals
	label$ = Get label of interval: 6,i
	if label$ == "rep"
		m +=1
		start = Get start time of interval: 6,i
		end = Get end time of interval: 6,i
		mid = (start+end)/2
		sessioninterval = Get interval at time: 1,mid
		sessionID$ = Get label of interval: 1,sessioninterval
		appendInfoLine: sessionID$
	endif
endfor
appendInfoLine: "m= ",m
		
		