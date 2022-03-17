#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar  3 10:55:40 2022

@author: kechun
"""

from glob import glob
import pandas as pd

# Child randomizer
files = glob("/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/questionnaire/child randomizer/*.csv")

all_df = []
for filename in files:
    df = pd.read_csv(filename)
    if len(df) != 1:
        df = df.iloc[:-1, :]
        # only keep the line that we might process
        df = df[~df['Response'].str.startswith('https://',na = False)] 
        df = df[~df['Response'].str.endswith('weba',na = False)]
        #df = df[df['Attempt'] == 1]
        #VIDEO STARTED; VIDEO PLAYING EVENT FIRED; VIDEO TIMEUPDATE EVENT FIRED;ADJUSTED START TIME based on TIMEUPDATE EVENT;VIDEO ENDED EVENT FIRED
        #df = df[df['Response'].str.startswith(('VIDEO','ADJUSTED'),na = False)]
        # Exclude the first recording for mic testing, with empty video name
        df = df[df['display'] != 'Mic_Test']
        df = df[df['display'] != 'Practice']
        # Only keep useful columns
        df = df[['Participant Public ID', 'Task Version','Spreadsheet','videoname','Response','Reaction Time','display', 'Attempt']]
        # Print size by group
        #df_filter = df.groupby(['Participant Public ID','videoname'])
        #print(df_filter.size())
        #df_filter = df_filter.filter(lambda x: len(x) != 6)
        #print(filename)
        #print(df_filter[['Participant Public ID','videoname']])
        df['filename'] = filename
        all_df.append(df)
merge_df = pd.concat(all_df)
print(len(merge_df))
#write to csv
merge_df.to_csv("child_gorillatime.csv", index = False)


# Adult randomizer
files = glob("/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/questionnaire/adult randomizer/*.csv")

all_df = []
for filename in files:
    df = pd.read_csv(filename)
    if len(df) != 1:
        df = df.iloc[:-1, :]
        # only keep the line with English labels
        df = df[~df['Response'].str.startswith('https://',na = False)] 
        df = df[~df['Response'].str.endswith('weba',na = False)]
        #VIDEO STARTED; VIDEO PLAYING EVENT FIRED; VIDEO TIMEUPDATE EVENT FIRED;ADJUSTED START TIME based on TIMEUPDATE EVENT;VIDEO ENDED EVENT FIRED
        #df = df[df['Response'].str.startswith(('VIDEO','ADJUSTED'),na = False)]
        # Exclude the first recording for mic testing, with empty video name
        df = df[df['display'] != 'Mic_Test']
        df = df[df['display'] != 'Practice']
        # Only keep useful columns
        df = df[['Participant Public ID', 'Task Version','Spreadsheet','videoname','Response','Reaction Time','display', 'Attempt']]
        # Print size by group
        #df_filter = df.groupby(['Participant Public ID','videoname'])
        #print(df_filter.size())
        #df_filter = df_filter.filter(lambda x: len(x) != 6)
        #print(filename)
        #print(df_filter[['Participant Public ID','videoname']])
        df['filename'] = filename
        all_df.append(df)
merge_df = pd.concat(all_df)
print(len(merge_df))
#write to csv
merge_df.to_csv("adult_gorillatime.csv", index = False)



