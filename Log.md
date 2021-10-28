Jasper suggested that we need analyse whether the token length are compatible across context and mask condition - some work later on!

**28/10/2021 Process the firstbatch of data (17 adult + children)**

About the cleaning codes:

- The big progress is to read all files in a folder - but without using for loop and assgin function.

  ```R
  p1files <-tibble(File = timep1files) %>%
    extract(File, "parid","([0-9]{6}_[A-Za-z0-9]*time)",remove = FALSE) %>% # From the File name extract the useful part as a new variabel 'parid'
    mutate(Data = lapply(File, read.delim, sep = "\t")) %>%
    unnest(Data)%>%
    select(-File)%>%
    mutate(label = str_replace_all(label,"\\.","")) %>% # Replace extra '.' symbol at the end
    mutate(label = str_replace_all(label,"\\_$","")) # Replace extra '_' symbol at the end
  ```

- In reading the files a big issue occured - c29timep2, a120timep1&a120 timep2 are not encoded in the same way as others and they cannot be read! My solution is to to open the file in Numbers, copy it to excel, and save as txt (tab-delimited files) and it worked.
- The cleaning codes use quite some regular expressions to remove extra symbols added in the annotation process (like "_"".", which are likely to appear at the end)
- For a few files, because the errors in step 1 are not identified timely, the check files missed some responses. There are seven tokens which can be seen in timep1 but not timep2. See [Maskanalysis/checkfiles error.csv]

About the initial analysis:

- React2 is what we first use, which takes absolute end of sentence

- When analysing reaction time, it is important to filter out non-accurate responses, and outliers (react time > 5000) - Some reaction time is larger than 10000, which might imply problems in the data.

The spreadsheet and the initial codes are handed to Julia.