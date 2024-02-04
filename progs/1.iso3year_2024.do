/*****************************************************************************************************************
A do-file to form every pairwise combination of countries with years (from 1948 to 2023).
First version: 4th March 2009
This version: 2nd February 2024
Jose de Sousa (https://sites.google.com/site/josedesousauniv/home)
*
If you use these do-files in your work, please cite: 
De Sousa, Jose (2012), "The currency union effect on trade is decreasing over time", Economics Letters 117(3), pp. 917-920.
*
* Disclaimer 
These data are to the best of my knowledge correct. If you double check them to ensure their accuracy and find errors I would appreciate it if you would inform me at jose.de-sousa@u-paris2.fr. Thank you.
******************************************************************************************************************/
*
clear*
*
** Choose your first and last years
global fstyr "1948"
global lstyr "2023"  
*
** Create the year dta
global nobs = $lstyr - $fstyr + 1
set obs $nobs
gen year = ($fstyr-1)+_n
save tempyear, replace
scalar nyear = _N
*
** Mege to iso3.dta
use ../data/iso3_2024.dta, clear // data set of ISO 3166-1 alpha-3 codes 
scalar ncty = _N
duplicates report iso3 	
cross using tempyear 
*
* Important note: this cross is made for simplification but creates countries that may not exist in some years, such as Aruba (ABW) which was created in 1986. However, this should not be a problem when you merge back into your dataset, as there will be no data for these countries in the years prior to their creation.
*
** sample expected 
assert _N == ncty*nyear
sort iso3 year
save tempcty, replace
*
exit





