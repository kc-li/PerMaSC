# The file will facilitate the checking process
# It runs on the pre-generated 'check' files.
# It will puts the 'correct answer' in the tier 2
# You will be able to specify accuracy, determine the speech onset, as well as adding notes.
# When checking speech onset, it reads into previously saved two data files (based on intensity and chronset respectively), as well as allowing you to manually set up a time point
# Zoom in function added to facilitate spotting.
# Move cursor to zero crossing added.
# Updated by Katrina Li (7/10/2021): codeword added; the boudary will always choose the zero crossing

form Specify participant name
  word parid 210723_a76
  real empty_space 0.5
  comment By default you don't need to change this parameter.
  comment Katrina will specify the parameter in the "work assignment" spreadsheet if needed.
endform

newname$ = parid$ + "check"
newsoundfile$ = newname$ + ".wav"
newtextgridfile$ = newname$ + ".TextGrid"

# If the file has been generated, we could avoid regenerate files, and continue working on it
if fileReadable(newsoundfile$)
  Read from file... 'newsoundfile$'
  newsound = selected("Sound")
  Read from file... 'newtextgridfile$'
  newtextgrid = selected("TextGrid")
else
  exitScript: "There's no checking files for the participant."
endif

# Export new Chronset time

dataname$ = parid$ + "inten.txt"
dataname2$ = parid$ + "chronset.txt"
inten_list = Read Strings from raw text file: dataname$
Remove string... 1
chron_list = Read Strings from raw text file: dataname2$
Remove string... 1

# Start manual check process
select 'newtextgrid'
num_of_interval = Get number of intervals... 1

select 'newsound'
plus 'newtextgrid'
View & Edit

for interval to num_of_interval
  select 'newtextgrid'
  start = Get starting point... 1 interval
  end = Get end point... 1 interval
  label$ = Get label of interval... 1 interval

  chron_point$ = extractLine$(object$[chron_list, interval],tab$)
  chron_point = number(chron_point$)
  inten_point$ = extractLine$(object$[inten_list, interval],tab$)
  inten_point = number(inten_point$)

  editor TextGrid 'newname$'
	new_start = start + empty_space
	new_end = end - empty_space
    Zoom... new_start new_end
    #default cursor position: determined by chronset
    Move cursor to... chron_point
  endeditor

  repeat
    beginPause("Check onset & accuracy")
    boolean: "Correct", 1
	optionMenu: "Codeword", 1
		option: ""
		option: "unsure"
		option: "discard"
    comment: "If wrong, what is the participant's response?"
    text: "Note", ""
    clicked = endPause("Play", "ChronP","IntenP","Out","Add","Next",5)
    # IF THEY CLICKED "PLAY"
    if clicked = 1
      editor TextGrid 'newname$'
		Zoom... new_start new_end
        Play... new_start new_end
      endeditor

    # IF THEY CLICKED "ChronP"
    elif clicked = 2
      editor TextGrid 'newname$'
		    chronP_start = chron_point - 0.03
		    chronP_end = chron_point + 0.03
		    Zoom... chronP_start chronP_end
        Move cursor to... chron_point
		Move cursor to nearest zero crossing
      endeditor

    #IF THEY CLICKED "IntenP"
    elif clicked = 3
      editor TextGrid 'newname$'
		    intenP_start = inten_point - 0.03
		    intenP_end = inten_point + 0.03
		    Zoom... intenP_start intenP_end
        Move cursor to... inten_point
		Move cursor to nearest zero crossing
      endeditor

    elif clicked = 4
      editor TextGrid 'newname$'
        Zoom out
      endeditor

    #IF THEY CLICKED "Add"
    elif clicked = 5
      editor TextGrid 'newname$'
		Move cursor to nearest zero crossing
        confirmed_point = Get cursor
      endeditor
      nocheck Insert point... 3 confirmed_point check
      correct$ = string$(correct)
      content$ = correct$+"_" + codeword$ + "_" +note$
      select 'newtextgrid'
      Set interval text... 4 interval 'content$'
    endif
  until clicked =6
  # mark on tier 4 with accuracy
  # END OF THE PAUSE U.I.
  # Since you have confirmed the correct boundary, add the textgrid
endfor
