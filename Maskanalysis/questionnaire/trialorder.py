#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan  5 20:48:29 2022

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
        # only keep the line with recording link
        df = df[df['Response'].str.startswith('https://',na = False)] 
        # Exclude the first recording for mic testing, with empty video name
        df = df[df['display'] != 'Mic_Test']
        # Only keep useful columns
        df = df[['Participant Public ID', 'Task Version','Spreadsheet','videoname','Response','display','randomise_blocks']] 
        # We need to drop duplicates, otherwise trial number not right
        df = df.drop_duplicates(subset=['Response'],keep = "last")
        # check duplicates
        #print(filename)
        #print(df.Response.duplicated().sum())
        #dup = df.loc[df.Response.duplicated(), ['Participant Public ID','videoname']]
        #print(dup,'\n')
        # Generate row number
        # Generate row number
        df['row_number'] = df.groupby(['Participant Public ID','display']).cumcount()+1
        df['filename'] = filename
        all_df.append(df)
merge_df = pd.concat(all_df)
#print(len(merge_df))
#write to csv
merge_df.to_csv("child_trial.csv", index = False)

# Adult randomizer
files = glob("/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/questionnaire/adult randomizer/*.csv")

all_df = []
for filename in files:
    df = pd.read_csv(filename)
    if len(df) != 1:
        df = df.iloc[:-1, :]
        df = df[df['Response'].str.startswith('https://',na = False)] 
        df = df[df['display'] != 'Mic_Test']
        df = df[['Participant Public ID', 'Task Version','Spreadsheet','videoname','Response','display','randomise_blocks']]  
        # We need to drop duplicates, otherwise trial number not right
        df = df.drop_duplicates(subset=['Response'],keep = "last")
        # check duplicates
        #print(filename)
        #print(df.Response.duplicated().sum())
        #dup = df.loc[df.Response.duplicated(), ['Participant Public ID','videoname']]
        #print(dup,'\n')
        # Generate row number
        df['row_number'] = df.groupby(['Participant Public ID','display']).cumcount()+1
        df['filename'] = filename
        all_df.append(df)
merge_df = pd.concat(all_df)
#write to csv
merge_df.to_csv("adult_trial.csv", index = False)

