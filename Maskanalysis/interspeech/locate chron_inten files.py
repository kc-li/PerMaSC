#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 28 21:35:40 2022

@author: kechun
"""
import os
import shutil
dir_original = "/Volumes/GoogleDrive/Shared drives/Mask project/Data processing/checkfile generated/"
destination = "/Users/kechun/Documents/GitHub/PerMaSC/Maskanalysis/interspeech/chron_inten/"
parid = ['210719_a25','210719_a41','210719_c12','210719_c26','210719_c29','210719_c47','210719_c53','210719_c66','210719_c71','210723_a76','210723_a78','210723_a79','210725_a120','210725_a139','210725_a147','210725_a156','210725_a165','210725_a176','210725_a185','210725_a90','210725_a96','210725_c122','210725_c130','210725_c135','210725_c76','210725_c81','210725_c84','210725_c86','210725_c94','210823_c177','210823_c179','210719_a08','210719_a09','210719_a40','210719_c08','210719_c27','210719_c51','210725_a130','210725_a132','210725_a133','210725_a138','210725_a152','210725_a177','210725_a81','210725_a84','210725_a98','210725_c124','210725_c125','210725_c128','210725_c133','210725_c141','210823_c180']
for i in parid:
    file_int = dir_original + i + "inten.txt"
    file_chron = dir_original + i + "chronset.txt"
    if not os.path.isfile(file_int):
        print(i, "inten.txt doesn't exist")
    else:
        shutil.copy(file_int,destination)
    if not os.path.isfile(file_chron):
        print(i, "chron.txt doesn't exist")
    else:
        shutil.copy(file_chron,destination)
        