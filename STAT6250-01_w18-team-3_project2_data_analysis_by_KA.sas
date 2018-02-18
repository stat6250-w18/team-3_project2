*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduation numbers and rates for various California High
Schools

Dataset Name: Graduates_analytic_file created in external file
STAT6250-02_w18-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset cde_2014_analytic_file;
%include '.\STAT6250-01_w18-team-3_project2_data_preparation.sas'


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What is the difference of white students graduating compared to all students in each year?'
;

title2
'Rationale: This help identifies the progress of students in terms of education depending on their ethnicity.'
;


*Note: This compares the column "WHITE" from Grads1314to the column of the same 
name from Grads1415.
*
Methodology: When combining the files Grads1314 and Grads1415 in data
preparation, take the difference of values of the column WHITE for each school
and create a new variable called Total_Graduation. After, use proc
sort to create a temporary sorted table in descending order by
Total_Graduation and then proc print to display the first ten rows
of the sorted dataset
Limitations: We don't really know if schools kept the same amount of students 
per year. It's possible that a school could have increased the number of
students it instructs which could increase the amount of graduates even if
it's at a lower rate.
Followup Steps: Possibly check if the total number of graduates increased for
the schools in terms of total graduates.
;

proc print 
        data=Graduates_analytic_file_Total
    ;
    id 
        CDS_CODE
    ;
    var 
        SCHOOL COUNTY GRADRATE TOTAL
    ;
run; 

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What is the percentage of dropouts compared to graduates?'
;

title2
'Rationale: This would generate a ranking of schools based on dropouts vs. graduation.'
;

*
Methodology: Use PROC PRINT to print out the percentage of dropouts from 
GradRates file using columnsD9,D10,D11,D12 in the temporary dataset created 
in the data prep file. Then compare the dropout vs. graduation rates.
Limitations: This data is for only 1 academic year. This does not give us an
overall idea 
Followup Steps: Check the bottom ten schools with the lowest gradution rates.
;

proc print 
        data=Graduates_analytic_file_GradRate(obs=20)
    ;
    id 
        CDS_CODE
    ;
    var 
        SCHOOL GRADRATE
    ;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question:vWhat is the number of schools in each county? ?'
;

title2
'Rationale: Rationale: Get a population estimate of graduating students in each county so as to acquire related resources.'
;

*
Methodology: Use proc means to find the sum for the columns D9, D10, D11, and 
D12 in the Graduates_analytic_file file created in data.
preparation. Then see which one has the highest number.
Limitations: None
Followup Steps: See which high schools have the highest number of dropouts,
which would demonstrate that these schools maybe need to improve their
teaching/counseling services or something.
;

proc means 
        data=Graduates_analytic_file
        sum
    ;
    id
        CDS_CODE
    ;
    var
        D9 D10 D11 D12
    ;
run;
;
