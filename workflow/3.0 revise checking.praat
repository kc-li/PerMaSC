# The file will facilitate the checking process
# It runs on the pre-generated 'check' files.
# It will puts the 'correct answer' in the tier 2
# You will be able to specify accuracy, determine the speech onset, as well as adding notes.
# When checking speech onset, it reads into previously saved two data files (based on intensity and chronset respectively), as well as allowing you to manually set up a time point
# Zoom in function added to facilitate spotting.
# Move cursor to zero crossing added.
# Updated by Katrina Li (7/10/2021): codeword added; the boudary will always choose the zero crossing

form Specify participant name
  real empty_space 0.5
endform

newsound = selected("Sound")
newtextgrid = selected("TextGrid")

newname$ = selected$("Sound")

# If the file has been generated, we could avoid regenerate files, and continue working on it



# Start manual check process
select 'newtextgrid'
num_of_interval = Get number of intervals... 1
num_of_points = Get number of points... 3

select 'newsound'
plus 'newtextgrid'
View & Edit

for point to num_of_points
  select 'newtextgrid'
  check = Get time of point: 3, point
  Remove point: 3, point
  interval = Get interval at time: 1, check
  start = Get starting point... 1 interval
  end = Get end point... 1 interval
  new_start = start + empty_space
  new_end = end - empty_space
  label$ = Get label of interval... 1 interval

  editor TextGrid 'newname$'
    Move cursor to... check
	Move cursor to nearest zero crossing
	zerocursor = Get cursor
  endeditor
	nocheck Insert point... 3 zerocursor check
  editor TextGrid 'newname$'
    Zoom... new_start new_end
  endeditor

  repeat
    beginPause("Check onset")
    clicked = endPause("Play", "In","Out","Add","Next",5)
    # IF THEY CLICKED "PLAY"
    if clicked = 1
      editor TextGrid 'newname$'
		Zoom... new_start new_end
        Play... new_start new_end
      endeditor

    # IF THEY CLICKED "In"
    elif clicked = 2
      editor TextGrid 'newname$'
		    zerocursor_start = zerocursor - 0.03
		    zerocursor_end = zerocursor + 0.03
		    Zoom... zerocursor_start zerocursor_end
      endeditor

	# IF THEY CLICKED "Out"
    elif clicked = 3
      editor TextGrid 'newname$'
        Zoom out
      endeditor

    #IF THEY CLICKED "Add"
    elif clicked = 4
      editor TextGrid 'newname$'
		Move cursor to nearest zero crossing
        confirmed_point = Get cursor
      endeditor
	  Remove point: 3, point
      nocheck Insert point... 3 confirmed_point check
    endif
  until clicked =5
  # mark on tier 4 with accuracy
  # END OF THE PAUSE U.I.
  # Since you have confirmed the correct boundary, add the textgrid
endfor
