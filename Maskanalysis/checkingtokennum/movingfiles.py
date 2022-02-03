#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  2 17:28:14 2022

@author: kechun
"""
import shutil, os
import glob
import re

namelist = ["210719_a25", "210719_a41", "210719_c12", "210719_c26", "210719_c29", 
"210719_c47", "210719_c53", "210719_c66", "210719_c71", "210723_a76", 
"210723_a78", "210723_a79", "210725_a120", "210725_a156", "210725_a176", 
"210725_a185", "210725_a90", "210725_a96", "210725_c122", "210725_c130", 
"210725_c135", "210725_c76", "210725_c81", "210725_c84", "210725_c86", 
"210725_c94", "210823_c177", "210823_c179", "210719_a09", "210719_c08", 
"210719_c27", "210719_c51", "210725_a130", "210725_a132", "210725_a138", 
"210725_a152", "210725_a81", "210725_a84", "210725_a98", "210725_c124", 
"210725_c125", "210725_c128", "210725_c133", "210725_c141", "210823_c180", 
"210725_a139", "210725_a147", "210725_a165", "210719_a08", "210719_a40", 
"210725_a133", "210725_a177"]

src = "/Volumes/S8/Mask project/Processing/checkfile generated"
dest = "/Volumes/S8/Mask project/processed step 1"
src_files = glob.glob(os.path.join(src,"*measure*"))

# len(namelist)
# 52
# print(src_files)

matchingfiles = [s for s in src_files if any(xs in s for xs in namelist)]
print(matchingfiles)
len(matchingfiles)
# 102. Two were missing

# Check which two 
matchingnames = []
for filename in matchingfiles:
    matchingname = filename.split("checkfile generated/")[1].split("measure")[0]
    #print(matchingname)
    matchingnames.append(matchingname)
set(namelist)^set(matchingnames)
#210719_c71 - check the file independently

#python move files
for file_name in matchingfiles:
    shutil.copy(file_name, dest)

############################
# Similarly, remove textgrid files
dest = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/datafile/26_26final"
batch1 = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/datafile_first_batch"
batch1files = os.listdir(batch1)
matchingfiles1 = [s for s in batch1files if any(xs in s for xs in namelist)]
print(matchingfiles1)
for file_name in matchingfiles1:
    shutil.copy(os.path.join(batch1,file_name), dest)
batch2 = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/datafile_second_batch"
batch2files = os.listdir(batch2)
matchingfiles2 = [s for s in batch2files if any(xs in s for xs in namelist)]
for file_name in matchingfiles2:
    shutil.copy(os.path.join(batch2,file_name), dest)
