# CompanyNames2URL_CSVs_Clearbit
This builds a CSV of Name,URL,Logo from text list using free Clearbit AutoComplete API

Reads text file from StartList. 
Extracts any lines that start with COMPANY: to a new company list (StartList.new).
Runs against the ClearBit API to get URL for each company. 
Saves completed list as StartList.csv

All files are saved in the RENAME_FILES/RENAME folder.
A ruby script is included to add a prefix to the files and save a renamed copy of each in the RENAME_FILES/COMPLETE folder
The RENAME folder is then cleared for the next run.
