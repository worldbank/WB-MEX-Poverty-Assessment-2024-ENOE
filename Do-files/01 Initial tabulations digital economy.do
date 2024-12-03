*v0.1	iosoriorodarte@worldbank.org 	Mar 27, 2024
clear
frame reset

* User 1: Israel Osorio Rodarte
	if c(username)=="israel"|c(username)=="Israel" {
		global path 		"/Users/`c(username)'/OneDrive/WBG/ETIRI/Projects/FY24/FY24 4 LAC - Mexico"
	}

* Availability of p2d6 variable for unemployed, number of observations
	use year quarter p2d6 using "$path/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	contract year quarter p2d6
	drop if p2d6==.
	rename _freq n
	reshape wide n, i(year) j(quarter)
	order p2d6 year
	export excel using "$path/XLSX/ENOE Coverage of p2d and p3n variables.xlsx", sheet("p2d6") firstrow(variables) sheetmodify

* Availability of p2d* variable for unemployed, number of observations
	use year quarter p2d* using "$path/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	egen p2D = rsum(p2d*)
	replace p2D = 1 if p2D>0 & p2D!=.
	contract year quarter p2D
	drop if p2D==0
	rename _freq n
	reshape wide n, i(year) j(quarter)
	order p2D year
	export excel using "$path/XLSX/ENOE Coverage of p2d and p3n variables.xlsx", sheet("p2d_all") firstrow(variables) sheetmodify
	
* Availability of p3n==6 variable for employed, number of observations
	use year quarter p3n using "$path/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	contract year quarter p3n
	drop if p3n==.
	keep if p3n==6
	rename _freq n
	reshape wide n, i(year) j(quarter)
	order p3n
	export excel using "$path/XLSX/ENOE Coverage of p2d and p3n variables.xlsx", sheet("p3n_6") firstrow(variables) sheetmodify
	
* Availability of p3n variable for employed, number of observations
	use year quarter p3n using "$path/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	drop if p3n==.
	gen p3N=1
	contract year quarter p3N
	rename _freq n
	reshape wide n, i(year) j(quarter)
	order p3N
	export excel using "$path/XLSX/ENOE Coverage of p2d and p3n variables.xlsx", sheet("p3n_all") firstrow(variables) sheetmodify
	
	