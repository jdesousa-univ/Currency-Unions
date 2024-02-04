# Currency-Unions
Here is a series of programs to create a dataset of bilateral currency unions between 235 countries over 76 years, from 1948 to 2023.

- First version: 4th March 2009
- This version: 4th February 2024
- Author: [Jose De Sousa](https://sites.google.com/site/josedesousauniv/home)

If you use these programs and dataset in your work, please cite: 

> De Sousa, Jose (2012), [The currency union effect on trade is decreasing over time](https://www.sciencedirect.com/science/article/abs/pii/S0165176512003941), _Economics Letters_ 117(3), pp. 917-920. 

The ungated version is [here](https://drive.google.com/file/d/0B0CvAsG5eVPJb1c4Q3dKeHBZTDg/view?hl=en&pli=1&resourcekey=0-YBYzn1wQ-Mcp2heqGFDgjA). 

You'll be joining a group of academics using this dataset: [take a look](https://scholar.google.fr/scholar?oi=bibs&hl=en&cites=3218259387529740408&as_sdt=5). Thank you!                         

## Software
I use Stata to create the data set. Please run the master do-file, called `mastercu_2024.do` for creating a bilateral currency union dataset and executing all of the individual do-files in the appropriate order.

I also provide the final dataset in two formats: `comcur_2024.dta` and `comcur_2024.txt`

Note: you can open the Stata dataset `.dta` with `R` by using the following code:
```
install.packages("foreign")
library(foreign)
comcurdata <- read.dta("data/comcur_2024.dta")
```

## Acknowledgements
I am indebted to 
- [Keith Head](https://www.sauder.ubc.ca/people/keith-head) for much helpful advice and insightful discussions in the construction of this file 
- [Laura Lebastard](https://www.ecb.europa.eu/pub/research/authors/profiles/laura-lebastard.en.html) (a former PhD student now an economist at the European Central Bank) for her help in revising an eralier version of the dataset. 
- [Antoine Chaney](https://fr.linkedin.com/in/antoine-chaney-3898a2192) for his excellent research assistance in allowing me to update an earlier version of this dataset. 
- [Yoto Yotov](https://yotoyotov.com/) for encouraging me to keep updating this dataset and for citing my work!

## Disclaimer 
These data are to the best of my knowledge correct. If you double check them to ensure their accuracy and find errors, I would appreciate it if you would inform me at <jose.de-sousa@u-paris2.fr>. Thank you!
"# Currency-Unions" 
