/****************************************************************************************************
A do-file to determine which "multinational currency" (e.g., US$, Euro, ...) a country is using between 1948 and 2023.

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
These data are to the best of my knowledge correct. If you double check them to ensure their accuracy and find errors I would appreciate it if you would inform me at jose.de-sousa@u-paris2.fr. Thank you.
*****************************************************************************************************
*/
*
/* Notes:
1. We only present `multinational currencies', which are used in at least two countries. Single-country currencies, such as the Brazilian Real, are marked  as "_".

2. For each country in the sample, we specify the multinational currency used, if any. 

3. A country may use multiple multinational currencies simultaneously. The code allows for this multi-use.

4. The multinational currencies reported are mainly those tabulated in the Appendix B of Glick and Rose (2002, pp. 1141-1149) [hereafter GR] and used to form currency unions. 

5. GR use an annual panel data set from 1948 through 1997. They identify "16 switches into and 130 switches out of currency unions (for which we have data)". "Switches into a currency union" means that a country uses a new multinational currency. I was able to identify 13 "switches into" out of the 16 mentioned. These switches into are not tabulated in Appendix B but reported in their dataset. 

6. I updated Glick and Rose's data until 2023. 

7. I also added few multinational currencies: 
* The Dollar of Singapour (SGD) at par with the Brunei dollar (BND) (see CU 11) thanks to Markus Hauschel (Trier U.)
* The New Zealand Dollar (see CU 22)
* The Deutsch Mark Zone (see CU 23)

8. I have also included a number of currency unions that are sufficiently integrated that trade data might not be available. For instance, I have added the "South Africa Rand" currency union. While some of these currencies are not listed in Appendix B of GR, they are referenced in Footnote 9 on page 1129.  

9. Additionally, I have expanded the dataset to include small islands to existing currency unions such as the Federated States of Micronesia, the Turks and Caicos Islands or the Norfolk Island. However, trade data might not be available for these relationships.

10. I have also incorporated the Euro, which was introduced to world financial markets as an accounting currency on January 1, 1999. However, not that other changes that may have occurred between 1997 (date of the first Gick and Rose paper) and 2023, may not be reflected here.

11. For country identifiers, I use the latest ISO 3166-1 alpha-3 codes (See https://en.wikipedia.org/wiki/ISO_3166-1). E.g., COD for the Democratic Republic of the Congo (formerly ZAR, not to be confused with the currency code ZAR), and ROU for Romania (previously ROM). Additionally, I introduced two codes "BLX" to collectively represent Belgium and Luxembourg and "XKK" to represent Kosovo (see https://en.wikipedia.org/wiki/XK_(user_assigned_code)).

12. The sample spans from 1948 to 2023. Thus, all country identifiers are applied retrospectively since 1948, even for territories that gained formal recognition later, such as Aruba (ABW), which was established in 1986.
*/
*
clear*
use tempcty.dta, clear // created with 1.iso3year.do
codebook iso3 year, compact
ta year
*
****************************************************************
* Variables: iso_o iso_d year
* 235 country identifiers, 76 years (1948-2023)
* Observations: 17,860
* Note: If you want to reduce the size dimension of the data set, 
* please modify the 1.iso3year do file
****************************************************************
*
*** I generate the possibility that a country uses simultaneously three multinational currencies
gen str3 currency1="_"
gen str3 currency2="_"
gen str3 currency3="_"
*
*** According to the previous notes, I identify 21 multinational currencies:

********************************************************************************
**** 1. the British West Indies dollar (BWI) ****
* known today as Eastern Caribbean Currency Union
* with the Eastern Caribbean Dollar (XCD)
* https://en.wikipedia.org/wiki/Eastern_Caribbean_dollar
********************************************************************************

** 1. Antigua and Barbuda
replace currency1= "BWI" if (iso3=="ATG")

** 2. Dominica
replace currency1= "BWI" if (iso3=="DMA")

** 3. Grenada
replace currency1= "BWI" if (iso3=="GRD")

** 4. St. Kitts and Nevis
replace currency1= "BWI" if (iso3=="KNA")

** 5. St. Lucia
replace currency1= "BWI" if (iso3=="LCA")

** 6. St. Vincent
replace currency1= "BWI" if (iso3=="VCT")

** 7. Montserrat
replace currency1= "BWI" if (iso3=="MSR")

** 8. Trinidad and Tobago
replace currency1= "BWI" if (iso3=="TTO") & (year<1976)

** 9. Barbados 
replace currency1= "BWI" if (iso3=="BRB") & (year<1975)

** 10. Guyana
replace currency1= "BWI" if (iso3=="GUY") & (year<1971)

** 11. Anguilla
replace currency1= "BWI" if (iso3=="AIA") & (year>=1967)
*
tab currency1
codebook iso3 if currency1=="BWI"


*********************************************************************************************************
**** 2. The "Central America and the Caribbean" Currency (ANG) **** 
**** a.k.a Netherlands Antillean Guilder					   ****
* https://en.wikipedia.org/wiki/Netherlands_Antillean_guilder
* At some point, it should be replaced by the Caribbean guilder ***		
*********************************************************************************************************

*** 1. Aruba
replace currency1= "ANG" if (iso3=="ABW") 
/*Note: The Aruba florin was introduced in 1986, following separation with ANT,
replacing the ANG at par. */

*** 2. Suriname 
replace currency1= "ANG" if (iso3=="SUR") & (year<1994)

*** 3. Netherlands Antilles
replace currency1= "ANG" if (iso3=="ANT")
/* Note: The Netherlands Antilles was dissolved on October 10, 2010. 
Following this, Curaçao and Sint Maarten became separate constituent countries 
within the Kingdom of the Netherlands. Please note that if you are handling data 
for Sint Maarten (SXM) and Curaçao (CUW) prior to 2011, it's essential to adjust 
the code to reflect that they shared a common currency during that period.*/
 
*** 4. Sint Maarten 
replace currency1= "ANG" if (iso3=="SXM") & (year>2010)

*** 5. Curacao
replace currency1= "ANG" if (iso3=="CUW") & (year>2010)

tab currency1
codebook iso3 if currency1=="ANG"


*********************************************************************************************************
**** 3. The "Commonwealth of Australia" Currency (AUD) **** 
*********************************************************************************************************

** 1. Australia
replace currency1= "AUD" if (iso3=="AUS")

** 2. Kiribati
replace currency1= "AUD" if (iso3=="KIR") 

** 3. Nauru
replace currency1= "AUD" if (iso3=="NRU") 

** 4. Solomon Islands 
replace currency1= "AUD" if (iso3=="SLB") & (year<1979)

** 5. Tonga
replace currency1= "AUD" if (iso3=="TON") & (year<1991)

** 6. Tuvalu
replace currency1= "AUD" if (iso3=="TUV")

** 7. Norfolk Island
replace currency1= "AUD" if (iso3=="NFK")

tab currency1
codebook iso3 if currency1=="AUD"


*********************************************************************************************************
**** 4. The "Indian Rupee" Currency (INR) ****
* https://en.wikipedia.org/wiki/Indian_rupee
*********************************************************************************************************

** 1. India
replace currency1= "INR" if (iso3=="IND")

** 2. Bangladesh
replace currency1= "INR" if (iso3=="BGD") & (year<1974)

** 3. Bhutan
replace currency1= "INR" if (iso3=="BTN") 

** 4. Kuwait
replace currency1= "INR" if (iso3=="KWT") & (year<1961)

** 5. Oman
replace currency1= "INR" if (iso3=="OMN") & (year<1970)

** 6. Qatar
replace currency1= "INR" if (iso3=="QAT") & (year<1966)

** 7. Yemen Arab Republic 
replace currency1= "INR" if (iso3=="YEM") & (year<1951)

** 8. Pakistan 
replace currency1= "INR" if (iso3=="PAK") & (year<1966)

** 9. Myanmar (Burma)
replace currency1= "INR" if (iso3=="MMR") & (year<1966) 

** 10. Maldives
replace currency1= "INR" if (iso3=="MDV") & (year<1966)

** 11. Mauritius
replace currency1= "INR" if (iso3=="MUS") & (year<1966)

** 12. Seychelles
replace currency1= "INR" if (iso3=="SYC") & (year<1966)

** 13. Sri Lanka
replace currency1= "INR" if (iso3=="LKA") & (year<1966)

** 14. United Arab Emirates  (as the Trucial States)
replace currency1= "INR" if (iso3=="ARE") & (year<1966)

tab currency1
codebook iso3 if currency1=="INR"


*********************************************************************************************************
**** 5. The "Pakistan Rupee" Currency (PKR) ****
*********************************************************************************************************

** 1. Pakistan
replace currency2= "PKR" if (iso3=="PAK") & (year<1971)

** 2. Myanmar (Burma)
replace currency2= "PKR" if (iso3=="MMR") & (year<1971)

** 3. Maldives 
replace currency2= "PKR" if (iso3=="MDV") & (year<1971)

tab currency2
codebook iso3 if currency2=="PKR"


*********************************************************************************************************
**** 6. The "Mauritius Rupee" Currency (MUR) ****
*********************************************************************************************************

** 1. Mauritius 
replace currency2= "MUR" if (iso3=="MUS") & (year<1976)

** 2. Seychelles
replace currency2= "MUR" if (iso3=="SYC") & (year<1976)			 

** 3. Maldives 
replace currency3= "MUR" if (iso3=="MDV") & (year<1967)			 

** 4. Pakistan 
replace currency3= "MUR" if (iso3=="PAK") & (year<1967)

** 5. Sri Lanka
replace currency2= "MUR" if (iso3=="LKA") & (year<1967)

tab currency2
tab currency3	
codebook iso3 if currency2=="MUR" | currency3=="MUR"
		 

*********************************************************************************************************
**** 7. The "Belgian Franc" currency (BEF) ****
*********************************************************************************************************

** 1. & 2. Belgium
replace currency1= "BEF" if (iso3=="BEL") & (year<1999)
replace currency1= "BEF" if (iso3=="BLX") & (year<1999) // with Luxembourg

** 3. Burundi
replace currency1= "BEF" if (iso3=="BDI") & (year<1964)

** 4. Rwanda
replace currency1= "BEF" if (iso3=="RWA") & (year<1966) 

** 5. Congo 
replace currency1= "BEF" if (iso3=="COD") & (year<1961)

** 6. Luxembourg
replace currency1= "BEF" if (iso3=="LUX") & (year<1999)

tab currency1
codebook iso3 if currency1== "BEF"

*********************************************************************************************************
*** 8. The CFA Franc currency (CFA) ***
*********************************************************************************************************

** 1. Benin
replace currency1= "CFA" if (iso3=="BEN") 

** 2. Burkina Faso
replace currency1= "CFA" if (iso3=="BFA")

** 3. Cameroon
replace currency1= "CFA" if (iso3=="CMR") 

** 4. Central African Rep
replace currency1= "CFA" if (iso3=="CAF") 

** 5. Chad
replace currency1= "CFA" if (iso3=="TCD") 

** 6. Comores 
replace currency1= "CFA" if (iso3=="COM") & (year<1994)

** 7. Congo
replace currency1= "CFA" if (iso3=="COG") 

** 8. Djibouti 
replace currency1= "CFA" if (iso3=="DJI") & (year<1949)

** 9. Equatorial Guinea (switch into cu #1)
replace currency1= "CFA" if (iso3=="GNQ") & (year>=1985) 

** 10. Gabon
replace currency1= "CFA" if (iso3=="GAB") 

** 11. Guinea (GIN)
replace currency1= "CFA" if (iso3=="GIN") & (year<1969)

** 12. Guinea Bissau (GNB) (switch into cu #2) 
replace currency1= "CFA" if (iso3=="GNB") & (year>=1997)

** 13. Ivory Coast
replace currency1= "CFA" if (iso3=="CIV")

** 14. Madagascar
replace currency1= "CFA" if (iso3=="MDG") & (year<1982)

** 15. Mali (switch into cu #3)
replace currency1= "CFA" if (iso3=="MLI") & (year<1962)
replace currency1= "CFA" if (iso3=="MLI") & (year>=1984)

** 16. Mauritania 
replace currency1= "CFA" if (iso3=="MRT") & (year<1974)

** 17. Niger
replace currency1= "CFA" if (iso3=="NER")

** 18. Senegal
replace currency1= "CFA" if (iso3=="SEN")

** 19. Reunion 
replace currency1= "CFA" if (iso3=="REU") & (year<1976) 

*** 20. St. Pierre and Miquelon
replace currency1= "CFA" if (iso3=="SPM") & (year<1976)

** 21. Togo (switch into cu #4)
replace currency1= "CFA" if (iso3=="TGO") & (year<1962) 
replace currency1= "CFA" if (iso3=="TGO") & (year>=1963) 			

tab currency1
codebook iso3 if currency1== "CFA"


*********************************************************************************************************
**** 9. The "South Africa Rand" currency (ZAR) ****
*********************************************************************************************************

* 1. South Africa
replace currency1= "ZAR" if (iso3=="ZAF")

* 2. Botswana
replace currency1= "ZAR" if (iso3=="BWA") & (year<1977)

* 3. Lesotho 
replace currency1= "ZAR" if (iso3=="LSO") 

* 4. Swaziland 
replace currency1= "ZAR" if (iso3=="SWZ") 

* 5. Namibia (mentionned in footnote 9)
replace currency1= "ZAR" if (iso3=="NAM")  

tab currency1
codebook iso3 if currency1== "ZAR" 

*********************************************************************************************************
**** 10. The "Malaya dollar" currency (MYR) ****
*********************************************************************************************************

* 1. Malaysia
replace currency1= "MYR" if (iso3=="MYS") & (year<1967) 

* 2. Singapore
replace currency1= "MYR" if (iso3=="SGP") & (year<1967)

* 3. Brunei
replace currency1= "MYR" if (iso3=="BRN") & (year<1967)

tab currency1
codebook iso3 if currency1== "MYR" 

*********************************************************************************************************
**** 11. The Dollar of Singapour (SGD) at par with the Brunei dollar (BND) ****
* https://en.wikipedia.org/wiki/Singapore_dollar
*** NOT CONSIDERED IN Glick and Rose (2002) ***
*********************************************************************************************************

* 1. Singapore
replace currency2= "SGD" if (iso3=="SGP")& (year>=1967)

* 2. Brunei
replace currency2= "SGD" if (iso3=="BRN") & (year>=1967)

tab currency2
codebook iso3 if currency2== "SGD" 


*********************************************************************************************************
**** 12. The "Danish Krone" currency (DKK) ****
*********************************************************************************************************

* 1. Denmark
replace currency1= "DKK" if (iso3=="DNK") 

* 2. Faroe Islands
replace currency1= "DKK" if (iso3=="FRO") 

* 3. Greenland
replace currency1= "DKK" if (iso3=="GRL") 

tab currency1
codebook iso3 if currency1== "DKK" 


*********************************************************************************************************
**** 13. The "French Franc" currency (FRF) ****
*********************************************************************************************************

** 1. France
replace currency1= "FRF" if (iso3=="FRA") & (year<1999)

** 2. French Guiana
replace currency1= "FRF" if (iso3=="GUF") & (year<1999)

** 3. Guadeloupe
replace currency1= "FRF" if (iso3=="GLP") & (year<1999)

** 4. Martinique
replace currency1= "FRF" if (iso3=="MTQ") & (year<1999)

** 5. Monaco
replace currency1= "FRF" if (iso3=="MCO") & (year<1999)

** 6. Andorra (considered in Footnote 9)
replace currency1= "FRF" if (iso3=="AND") & (year<1999)

** 7. Algeria
replace currency1= "FRF" if (iso3=="DZA") & (year<1969)

** 8. Reunion (switch into cu #5) 
replace currency1= "FRF" if (iso3=="REU") & (year>=1976 & year<1999)

** 9. St. Pierre and Miquelon (switch into cu #6)
replace currency1= "FRF" if (iso3=="SPM") & (year>=1976 & year<1999)

** 10. Morocco
replace currency1= "FRF" if (iso3=="MAR") & (year<1959)

** 11. Tunisia
replace currency1= "FRF" if (iso3=="TUN") & (year<1958)

** 12. Saint Martin (French part)
replace currency1= "FRF" if (iso3=="MAF") & (year<1999)	
/* Note: Before 2007, the French part of Saint Martin was a commune belonging 
to the French overseas department and region of Guadeloupe.*/		

tab currency1
codebook iso3 if currency1== "FRF" 


*********************************************************************************************************
**** 14. The CFP Franc (XPF) ****
*********************************************************************************************************

** 1. French Polynesia
replace currency1= "XPF" if (iso3=="PYF") 

** 2. New Caledonia 
replace currency1= "XPF" if (iso3=="NCL") 

** 3. Wallis and Futuna
replace currency1= "XPF" if (iso3=="WLF")

** 4. Vanuatu (GR: CU stopped in 1971)
replace currency1= "XPF" if (iso3=="VUT") & (year<1971)

tab currency1
codebook iso3 if currency1== "XPF" 


*********************************************************************************************************
**** 15. The "Escudo" currency (PTE) ****
*********************************************************************************************************

** 1. Portugal
replace currency1= "PTE" if (iso3=="PRT") & (year<1999)

** 2. Cape Verde
replace currency1= "PTE" if (iso3=="CPV") & (year<1977)

** 3. Angola
replace currency1= "PTE" if (iso3=="AGO") & (year<1977)

** 4. Guinea-Bissau
replace currency2= "PTE" if (iso3=="GNB") & (year<1977)

** 5. Mozambique
replace currency1= "PTE" if (iso3=="MOZ") & (year<1977)

** 6. Sao Tome & Principe
replace currency1= "PTE" if (iso3=="STP") & (year<1977)

tab currency1
codebook iso3 if currency1== "PTE" | currency2== "PTE"


*********************************************************************************************************
**** 16. The "Saudi Riyal" currency (SAR) ****
*** Note: Here I follow Glick and Rose. Currencies of the following two countries have fluctuated only
*** moderately. However, their diplomatic relationships are detoriating since 2017.
*********************************************************************************************************

** 1. Qatar (switch into cu #7)
replace currency1= "SAR" if (iso3=="QAT") & (year>=1981) 	

** 2. United Arab Emirates  (switch into cu #8)
replace currency2= "SAR" if (iso3=="ARE") & (year>=1981)

tab currency1
tab currency2
codebook iso3 if currency1== "SAR" | currency2== "SAR"

*********************************************************************************************************
**** 17. The "Peseta" currency (ESP) ****
*********************************************************************************************************

** 1. Spain
replace currency1= "ESP" if (iso3=="ESP") & (year<1999)			

** 2. Andorra
replace currency2= "ESP" if (iso3=="AND") & (year<1999)			

** 3. Equatorial Guinea
replace currency1= "ESP" if (iso3=="GNQ") & (year<1969)

tab currency1
tab currency2
codebook iso3 if currency1== "ESP" | currency2== "ESP"


*********************************************************************************************************
**** 18. The "East African Currency Area" currency (EAS) ****
*********************************************************************************************************

** 1. Kenya
replace currency1= "EAS" if (iso3=="KEN") & (year<1978)

** 2. Uganda
replace currency1= "EAS" if (iso3=="UGA") & (year<1978)

** 3. Tanzania 
replace currency1= "EAS" if (iso3=="TZA") & (year<1978)

** 4. Somalia
replace currency1= "EAS" if (iso3=="SOM") & (year<1971)

** 5. Yemen Arab Republic (switch into cu #9)
replace currency1= "EAS" if (iso3=="YEM") & (year>1950 & year<1972)

tab currency1
codebook iso3 if currency1== "EAS"

*********************************************************************************************************
**** 19. The "Pound Sterling" curreny, called GBP ****
*********************************************************************************************************

** 1. GBR
replace currency1= "GBP" if (iso3=="GBR") 

** 2. Bahamas 
replace currency1= "GBP" if (iso3=="BHS") & (year<1966)

** 3. Bermuda 
replace currency1= "GBP" if (iso3=="BMU") & (year<1970)

** 4. Cyprus 
replace currency1= "GBP" if (iso3=="CYP") & (year<1972)

** 5. Falkland Islands
replace currency1= "GBP" if (iso3=="FLK")

** 6. Gambia
replace currency1= "GBP" if (iso3=="GMB") & (year<1971)

** 7. Ghana 
replace currency1= "GBP" if (iso3=="GHA") & (year<1965)

** 8. Gibraltar
replace currency1= "GBP" if (iso3=="GIB") 

** 9. Iraq
replace currency1= "GBP" if (iso3=="IRQ") & (year<1967)

** 10. Ireland
replace currency1= "GBP" if (iso3=="IRL") & (year<1979)

** 11. Israel
replace currency1= "GBP" if (iso3=="ISR") & (year<1954)

** 12. Jamaica 
replace currency2= "GBP" if (iso3=="JAM") & (year<1969)

** 13. Jordan
replace currency1= "GBP" if (iso3=="JOR") & (year<1967)

** 14. Kenya
replace currency2= "GBP" if (iso3=="KEN") & (year<1967)

** 15. Kuwait (switch into cu #10)
replace currency1= "GBP" if (iso3=="KWT") & (year>=1961 & year<1967)

** 16. Lybia
replace currency1= "GBP" if (iso3=="LBY") & (year<1967)

** 17. Malawi
replace currency1= "GBP" if (iso3=="MWI") & (year<1971)

** 18. Malta
replace currency1= "GBP" if (iso3=="MLT") & (year<1971)

** 19. New Zealand
replace currency1= "GBP" if (iso3=="NZL") & (year<1967)   		
	* Tokelau (a dependent territory of New Zealand)	
replace currency1= "GBP" if (iso3=="TKL") & (year<1967)   			
	* Niue (self-governing island country in free association with NZL)
replace currency1= "GBP" if (iso3=="NIU") & (year<1967)   			
	* Cook Islands (self-governing island country in free association with NZL)
replace currency1= "GBP" if (iso3=="COK") & (year<1967)   			

** 20. Nigeria
replace currency1= "GBP" if (iso3=="NGA") & (year<1967)

** 21 Oman (switch into cu #11)
replace currency1= "GBP" if (iso3=="OMN") & (year==1970) 

** 22. Samoa
replace currency1= "GBP" if (iso3=="WSM") & (year<1967) 

** 23. Sierra Leone
replace currency1= "GBP" if (iso3=="SLE") & (year<1965)

** 24. Somalia
replace currency2= "GBP" if (iso3=="SOM") & (year<1967)

** 25. South Africa
replace currency2= "GBP" if (iso3=="ZAF") & (year<1961) 		  

** 26. St. Helena
replace currency1= "GBP" if (iso3=="SHN") 

** 27. Tanzania
replace currency2= "GBP" if (iso3=="TZA") & (year<1967)

** 28. Uganda
replace currency2= "GBP" if (iso3=="UGA") & (year<1967)

** 29. Yemen Arab Republic
replace currency2= "GBP" if (iso3=="YEM") & (year<1972)			 

** 30. Zambia
replace currency1= "GBP" if (iso3=="ZMB") & (year<1967)

** 31. Zimbabwe
replace currency1= "GBP" if (iso3=="ZWE") & (year<1967)

tab currency1
tab currency2
codebook iso3 if currency1== "GBP" | currency2== "GBP" 


*********************************************************************************************************
**** 20. The United States "Currency Union", called USA ****
*********************************************************************************************************

** 1. United States				
replace currency1= "USD" if (iso3=="USA")

** 2. American Samoa 
replace currency1= "USD" if (iso3=="ASM")

** 3. Bahamas (switch into cu #12)
replace currency1= "USD" if (iso3=="BHS") & (year>=1966) 

** 4. Belize 
replace currency1= "USD" if (iso3=="BLZ") & (year<1949) 

** 5. Bermuda (switch into cu #13)
replace currency1= "USD" if (iso3=="BMU") & (year>=1970)

** 6. Dominican Republic
replace currency1= "USD" if (iso3=="DOM") & (year<1985) 

** 7. Guam
replace currency1= "USD" if (iso3=="GUM") 

** 8. Guatemala
replace currency1= "USD" if (iso3=="GTM") & (year<1986)
/* According to the USDA exchange rate data set the quetzal was at par (and domestically equal)
to the United States dollar until May 1986
https://www.ers.usda.gov/data-products/agricultural-exchange-rate-data-set/
*/

** 9. Liberia
replace currency1= "USD" if (iso3=="LBR") 
/* note from the Central Bank of Liberia https://www.cbl.org.lr/general/currency: 
``The Liberian Dollar is the official currency of the Republic of Liberia. 
 However, the United States Dollar is a legal tender in Liberia and is used 
 along side the Liberian Dollar currency. */
* 
** 10. Panama 
replace currency1= "USD" if (iso3=="PAN") 

** 11. Ecuador 
replace currency1= "USD" if (iso3== "ECU") & (year>2000)

** 12. El Salvador
replace currency1= "USD" if (iso3== "SLV") & (year>=2001)
/* From the Central Bank of El Salvador; ``The US Dollar becomes the unit of account for the Financial System. All the financial System's operations and accounting will be denominated in US Dollars. All deposits, credits, pensions and other operations of the financial system will beautomatically converted into US dollars on January 1st 2001.''
https://web.archive.org/web/20070708094105/http://www.bcr.gob.sv/ingles/integracion/ley.html
*/
  
** 13. East Timor
replace currency1= "USD" if (iso3=="TLS") & (year>2002)

** 14. Federated States of Micronesia
replace currency1= "USD" if (iso3=="FSM") 

** 15. Palau
replace currency1= "USD" if (iso3=="PLW") 

** 16. Turks and Caicos Islands
replace currency1= "USD" if (iso3=="TCA") & (year>=1973)
* Note: https://www.visittci.com/nature-and-history/history/currency

** 17. Northern Mariana Islands
replace currency1= "USD" if (iso3=="MNP") 

** 18. Argentina
* Following the definition of Glick and Rose (2002), we could characterize Argentina as dollarized with a fixed 1:1 exchange rate from February 1995 to December 2001. The key question is whether this 83-month period should be considered an "extended period."
* Glick and Rose (2002): ``By `currency union' we mean essentially that money was interchangeable between the two countries at a 1 : 1 par for an extended period of time, so that there was no need to convert prices when trading between a pair of countries.''
* replace currency1= "USD" if (iso3=="ARG") & (year>=1995 & year<=2001)

tab currency1
codebook iso3 if currency1== "USD"


*********************************************************************************************************
*** 21. The European Monetary Union, called EUR *** NOT CONSIDERED IN Glick and Rose (2002)
*********************************************************************************************************

** 1. Andorra
replace currency3= "EUR" if (iso3=="AND") & (year>=1999)			

** 2. Austria
replace currency1= "EUR" if (iso3=="AUT") & (year>=1999)			

** 3.& 4. Belgium
replace currency2= "EUR" if (iso3=="BEL") & (year>=1999)			
replace currency2= "EUR" if (iso3=="BLX") & (year>=1999)			

** 5. Finland
replace currency1= "EUR" if (iso3=="FIN") & (year>=1999)			

** 6. France
replace currency2= "EUR" if (iso3=="FRA") & (year>=1999)			

** 7. French Guiana
replace currency2= "EUR" if (iso3=="GUF") & (year>=1999)			

** 8. Guadeloupe
replace currency2= "EUR" if (iso3=="GLP") & (year>=1999)			

** 9. Germany
replace currency2= "EUR" if (iso3=="DEU") & (year>=1999)			

** 10. Ireland
replace currency2= "EUR" if (iso3=="IRL") & (year>=1999)			

** 11. Italy
replace currency1= "EUR" if (iso3=="ITA") & (year>=1999)			

** 12. Luxembourg
replace currency2= "EUR" if (iso3=="LUX") & (year>=1999)			

** 13. Martinique
replace currency2= "EUR" if (iso3=="MTQ") & (year>=1999)			

** 14. Monaco
replace currency2= "EUR" if (iso3=="MCO") & (year>=1999)			

** 15. Netherlands
replace currency1= "EUR" if (iso3=="NLD") & (year>=1999)			

** 16. Portugal
replace currency2= "EUR" if (iso3=="PRT") & (year>=1999)			

** 17. Reunion 
replace currency2= "EUR" if (iso3=="REU") & (year>=1999)			

** 18. San Marino
replace currency1= "EUR" if (iso3=="SMR") & (year>=1999)			

** 19. Spain
replace currency2= "EUR" if (iso3=="ESP") & (year>=1999)			

** 20. St. Pierre and Miquelon
replace currency2= "EUR" if (iso3=="SPM") & (year>=1999)			

** 21. Greece
replace currency1= "EUR" if (iso3=="GRC") & (year>=2001)			

** 22. Montenegro 
replace currency2= "EUR" if (iso3=="MNE") & (year>=2002)			

** 23. Slovenia
replace currency1= "EUR" if (iso3=="SVN") & (year>=2007)			

** 24. Cyprus
replace currency2= "EUR" if (iso3=="CYP") & (year>=2008)			

** 25. Malta
replace currency2= "EUR" if (iso3=="MLT") & (year>=2008)

** 26. Slovakia
replace currency2= "EUR" if (iso3=="SVK") & (year>=2009)

** 27. Estonia
replace currency2= "EUR" if (iso3=="EST") & (year>=2011)

** 28. Latvia
replace currency2= "EUR" if (iso3=="LVA") & (year>=2014)	
	
** 29. Lithuania
replace currency2= "EUR" if (iso3=="LTU") & (year>=2015)	

** 30. Saint Martin (French part)
replace currency2= "EUR" if (iso3=="MAF") & (year>=1999)			

** 31. Kosovo
replace currency2= "EUR" if (iso3=="XKK") & (year>=2002)			
* Kosovo adopted the euro as its de facto legal tender in 2002 despite the territory not being a member of the Eurozone or the European Union. 
* https://en.wikipedia.org/wiki/Kosovo_and_the_euro
*
** 32. Croatia
replace currency2= "EUR" if (iso3=="HRV") & (year>=2023)			


codebook iso3 if currency1== "EUR" | currency2== "EUR" | currency3== "EUR" 


*********************************************************************************************************
**** 22. The New Zealand Dollar *** NOT CONSIDERED IN Glick and Rose (2002)
* https://en.wikipedia.org/wiki/New_Zealand_dollar
*********************************************************************************************************

** 1. New Zealand
replace currency2= "NZD" if (iso3=="NZL") & (year>=1967) 			

** 2. Tokelau (a dependent territory of New Zealand)
replace currency2= "NZD" if (iso3=="TKL") & (year>=1967)	

** 3. Niue (self-governing island country in free association with NZL)
replace currency2= "NZD" if (iso3=="NIU") & (year>=1967)
   			
** 4. Cook Islands (self-governing island country in free association with NZL)
replace currency2= "NZD" if (iso3=="COK") & (year>=1967)   

tab currency2
codebook iso3 if currency2== "NZD" 



*********************************************************************************************************
**** 23. The Deutsch Mark Zone *** NOT CONSIDERED IN Glick and Rose (2002)
* https://en.wikipedia.org/wiki/Deutsche_Mark
*********************************************************************************************************

** 1. Germany
replace currency1= "DMK" if (iso3=="DEU") & (year<2002) 
* Germany was one of the first countries to adopt the euro after its introduction in 1999, phasing out its previous national currency, the Deutsche Mark, entirely after 2001. (https://en.wikipedia.org/wiki/German_adoption_of_the_euro)			

** 2. Kosovo
replace currency1= "DMK" if (iso3=="XKK") & (year>=1999 & year<2002)	
* see also: https://en.wikipedia.org/wiki/Kosovo_and_the_euro

** 3. Montenegro
replace currency1= "DMK" if (iso3=="MNE") & (year>=1999 & year<2002)	
   			
** 4. Serbia
replace currency1= "DMK" if (iso3=="SRB") & (year>=1992 & year<=1995)   

** 5. Bosnia and Herzegovina
replace currency1= "DMK" if (iso3=="BIH") & (year>=1992 & year<=1998)   

tab currency1
codebook iso3 if currency1== "DMK" 


tab currency1
tab currency2
tab currency3

save tempcurrency, replace

exit
