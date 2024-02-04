/* 
A master do-file for creating a bilateral currency union dataset and executing all of the individual do-files in the appropriate order. 
*
First version: 4th March 2009
This version: 4th February 2024
Jose De Sousa (https://sites.google.com/site/josedesousauniv/home)
*
If you use these do-files in your work, please cite: 
De Sousa, Jose (2012), "The currency union effect on trade is decreasing over time", Economics Letters 117(3), pp. 917-920.
*
* Acknowledgements
I am indebted to Keith Head (UBC) for much helpful advice and insightful discussions in the construction of this file 

and to Laura Lebastard (a former PhD student now an economist at the European Central Bank) for her help in revising the data. 

I would also like to thank Antoine Chaney (ENS) for his excellent research assistance in allowing me to update an earlier version of this dataset. 

A special thanks to Yoto Yotov (Drexel) for encouraging me to keep updating this dataset.
*
* Disclaimer 
These data are to the best of my knowledge correct. If you double check them to ensure their accuracy and find errors, I would appreciate it if you would inform me. Thank you.
*/
*
******************************************************************************************************************/
*
** Enter the path to the "progs" folder
global Path ""

cd $Path
clear* 

** If you are using a Stata version lower than 13, allocate memory and matsize because the dyadic dataset is huge.
set mem 500M
set matsize 800

/* A do-file to form every pairwise combination of countries with years (from 1948 to 2023)*/
do 1.iso3year_2024.do

/* A do-file to determine which "multinational currency" (e.g. US$, euro, ...) a country is using between 1948 and 2023. */
do 2.currency_2024.do

/* A do-file to determine a bilateral currency union dummy (comcur).*/
do 3.dummycu_2024.do
*
export delimited ..\data\comcur_2024.txt, delimiter(tab) replace
*
