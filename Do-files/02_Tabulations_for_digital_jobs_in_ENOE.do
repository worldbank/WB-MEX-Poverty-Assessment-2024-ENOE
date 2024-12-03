*v0.1	iosoriorodarte@worldbank.org 	Mar 27, 2024
*v0.1	iosoriorodarte@worldbank.org 	Mar 11, 2024
*v0.1	iosoriorodarte@worldbank.org 	Nov 11, 2023
/*******************************************************************************
ENOE Surveys from 2005.Q1 to 2023.Q3 were harmonized using the World Bank 
Global Labor Database (GLD V06 template)
Visit: https://github.com/worldbank/gld

The ENOE surveys were assembled in a single file called: 
"$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta"

This do-file calculates means and standard errors for employment variables 
related with internet job search
Results are exported to Excel using "[Table X raw]" sheet names.
Raw sheets are hidden in Excel

Calculations can de done in parallel
	- Write yes in: local parallel "yes"
	
	Adjust and run in MacOSX terminal, the following code:
	cd "/Users/Israel/OneDrive/WBG/ETIRI/Projects/FY24/FY24 4 LAC - Mexico/Do"
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2005.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2006.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2007.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2008.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2009.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2010.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2011.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2012.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2013.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2014.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2015.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2016.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2017.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2018.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2019.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2020.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2021.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2022.do &
	stata-mp -b do 02_Tabulations_for_digital_jobs_in_ENOE_2023.do &
	
	In Windows, run the following command. See Stata Manual page 4 (https://www.stata.com/manuals/gswb.pdf)
	cd "C:/Users/WB308767/OneDrive/WBG/ETIRI/Projects/FY24/FY24 4 LAC - Mexico/Do"
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2005.do" |	
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2006.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2007.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2008.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2009.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2010.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2011.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2012.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2013.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2014.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2015.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2016.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2017.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2018.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2019.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2020.do" |
	"C:/Program Files/Stata18/StataMP-64" /e /i do "02_Tabulations_for_digital_jobs_in_ENOE_2023.do" 

*******************************************************************************/
clear
frame reset
matrix drop _all

capture which estout 
	if _rc ssc install estout

* User 1: Israel Osorio Rodarte - MacOSX
	if (c(username)=="israel"|c(username)=="Israel") & (c(os)=="MacOSX"|c(os)=="Unix") {
		global output   "/users/`c(username)'/OneDrive/WBG/ETIRI/Projects/FY24/FY24 4 LAC - Mexico"
		global path 	"/Users/`c(username)'/OneDrive/Data/GLD/MEX copy"
	}

* User 1: Israel Osorio Rodarte - Windows
	if c(username)=="WB308767" {
		global output   "C:/users/`c(username)'/OneDrive/WBG/ETIRI/Projects/FY24/FY24 4 LAC - Mexico"
		global path 	"C:/users/`c(username)'/OneDrive/Data/GLD/MEX copy"
	}
	
	
clear

* Options for sequential processing 
	local runGLD        "yes"
	local runtable1and2 ""
	local runtable3 	"" // Can be run on parallel
	local runtable3_1 	""	// Assemble results from previous step
	local runtable4		""
	local runtable4_1	""	// Assemble results from previous step
	local runtable5		""
	local runtable5N	""
	local runtable6		""
	local runtable6_1	"" // Assemble results from previous step

	local runtable7		""
	local runtable7_1	""

	local runtable8		""
	local runtable8_1	""
	
	local runtable9		""	// Runs only with Q1
	local runtable10	""	
	
	local iniyear = 2005	
	local finyear = 2023	
	local iniq    = 1
	local finq	  = 4	
	local maxcycle = 76


* Options for paralllel processing (over years)
	local parallel 		"yes"
		local iniparallelyear = 2005
		local finparallelyear = 2023
		*local iniyear = xrxx	// Do not modify
		*local finyear = xrxy	// Do not modify

/*******************************************************************************
Parallel Set up
*******************************************************************************/
{
	if "`parallel'" == "yes" & "`c(os)'"=="MacOSX" {
		
		cd "$output/do"
		forval i = `iniparallelyear'/`finparallelyear' {
			cp "02_Tabulations_for_digital_jobs_in_ENOE.do" "02_Tabulations_for_digital_jobs_in_ENOE_`i'.do", replace
			!sed -i '' "s/xrxx/`i'/g" 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do
			!sed -i '' "s/xrxy/`i'/g" 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do
			!sed -i '' "s/local[[:space:]]parallel/*local parallel/g" 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do
			!sed -i '' "s/*local[[:space:]]iniyear/local iniyear/g" 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do
			!sed -i '' "s/*local[[:space:]]finyear/local finyear/g" 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do
		}
		
		exit
	}

	if "`parallel'"=="yes" & "`c(os)'"=="Windows" {
		cd "$output/do"
		forval i = `iniparallelyear'/`finparallelyear' {
			!copy "02_Tabulations_for_digital_jobs_in_ENOE.do" "02_Tabulations_for_digital_jobs_in_ENOE_`i'.do"
			!powershell -command " (Get-Content 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do) -replace 'xrxx', '`i''                       | Out-File -encoding ASCII 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do "
			!powershell -command " (Get-Content 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do) -replace 'xrxy', '`i''                       | Out-File -encoding ASCII 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do "
			!powershell -command " (Get-Content 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do) -replace 'local parallel', '*local parallel' | Out-File -encoding ASCII 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do "
			!powershell -command " (Get-Content 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do) -replace '*local iniyear', 'local iniyear'   | Out-File -encoding ASCII 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do "
			!powershell -command " (Get-Content 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do) -replace '*local finyear', 'local finyear'   | Out-File -encoding ASCII 02_Tabulations_for_digital_jobs_in_ENOE_`i'.do "
		}

		exit	
	}	
}

/*******************************************************************************
RUN GLD harmonization
*******************************************************************************/
if "`runGLD '"=="yes" {

	forvalues yyyy = `iniyear'/`finyear' {
	forvalues q = `iniq'/`finq' {
		local counter = (`yyyy'-2005)*4 + `q'
		if (`counter'!=62) {
			quietly cd "$path/MEX_`yyyy'_ENOE-Q`q'/MEX_`yyyy'_ENOE_V01_M_V06_A_GLD/Programs/"
			noi di "`yyyy' `q' - counter: `counter'"
			do "MEX_`yyyy'_ENOE_V01_M_V06_A_GLD_ALL.do"
		}

	}
	}

}

/*******************************************************************************
Table 1 and Table 2 
*******************************************************************************/
if "`runtable1and2'"=="yes" {
	
	* Read only variables of interest from the full sample
	local keepvars "psu strata weight year quarter age lstatus p2d6"
	
	local counter = 1
	forval yyyy = 2005/2023 {
	forval q = 1/4 {
		
		if (`counter'!=62) {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", replace
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1
				
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
			* SVY Tabulations
				* Total unemployed
					svy: total unemployed
					matrix t1_a_`yyyy'q`q' = r(table)
					matrix t1_a_`yyyy'q`q' = t1_a_`yyyy'q`q'[1,1]
						
				
				* Unemployed, as percent of labor force
					estpost svy: tabulate unemployed, level(95) proportion se ci nototal
					matrix  t1_b_`yyyy'q`q'  = e(b)
					matrix  t1_b_`yyyy'q`q'  = t1_b_`yyyy'q`q'[1,2]
					matrix  t1_c_`yyyy'q`q' = e(se)
					matrix  t1_c_`yyyy'q`q' = t1_c_`yyyy'q`q'[1,2]
					
				* Unemployed using internet search, answer = 1 to p2d6
					svy: total internetseeker
					matrix t1_d_`yyyy'q`q' = r(table)
					matrix t1_d_`yyyy'q`q' = t1_d_`yyyy'q`q'[1,1]
						
				* Internet job-seekers, as percentage of unemployed
					svyset psu [w=weight]
					estpost svy: tabulate internetseeker, level(95) proportion se ci nototal
					matrix t1_e_`yyyy'q`q' = e(b)
					matrix t1_e_`yyyy'q`q' = t1_e_`yyyy'q`q'[1,2]
					matrix t1_f_`yyyy'q`q' = e(se)
					matrix t1_f_`yyyy'q`q' = t1_f_`yyyy'q`q'[1,2]
					
			* Arrange tables
				#delimit ; 
				matrix define t1_`yyyy'q`q' = [t1_a_`yyyy'q`q' \
											 t1_b_`yyyy'q`q' \ 
											 t1_c_`yyyy'q`q' \ 
											 t1_d_`yyyy'q`q' \ 
											 t1_e_`yyyy'q`q' \ 
											 t1_f_`yyyy'q`q'] ; 
				#delimit cr
				
				if `counter'==1 {
						local keepmatrix "t1_`yyyy'q`q'"
						local t1colnames `" "t1`yyyy'`q'" "'
				}
				if `counter'> 1 {
						local keepmatrix "`keepmatrix' , t1_`yyyy'q`q'"
						local t1colnames `"  `t1colnames'   "t1`yyyy'`q'" "'
				}
		}
			
				local counter = `counter'+1
		}
		
	}
	
		matrix define t1 = [`keepmatrix']
		matrix colnames t1 = `t1colnames'
	
	* Calculate Table 2
		local n = 1
		forval j = 2005/2023 {
			
			local m = 4*(`n'-1) + 4
			local p = 4*(`n'-1) + 4-1
			
			if `j'==2005 			local t2matrix = "t1[1..6,`m']"
			if `j'> 2005 & `j'<2020 local t2matrix = "`t2matrix' , t1[1..6,`m']"
			if `j'>=2020 			local t2matrix = "`t2matrix' , t1[1..6,`p']"
			
			local n = `n'+1
		}

		matrix define t2 = `t2matrix'

		
putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 1 raw") modify
putexcel A1 = matrix(t1), colnames

putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 2 raw") modify
putexcel A1 = matrix(t2), colnames
					   
}

/*******************************************************************************
Table 3. (Parallel enabled)
*******************************************************************************/
if "`runtable3'"=="yes" {
	
	* Read the full sample
	local keepvars "psu strata weight year quarter age lstatus p2d* male educy educat7"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		if `counter'!=62 {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
			
			* Note: Missing standard errors because of stratum with single sampling unit. 	
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1
				
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
				
				* Age Group
					gen agegroup = .
					replace agegroup = 0 if age>=0  & age<=14
					replace agegroup = 1 if age>=15 & age<=29
					replace agegroup = 2 if age>=30 & age<=34
					replace agegroup = 3 if age>=45 & age<=59
					replace agegroup = 4 if age>=60 & age!=.
					label define lblagegroup 0 "0-14" 1 "15-29" 2 "30-34" 3 "45-59" 4 "60 and more"
					label values agegroup lblagegroup
				
				* Educational attainment, based on years of schooling and educat7
					gen schooling = .
					*replace schooling = 0 if educat7==1
					*replace schooling = 1 if educat7==2|educat7==3
					replace schooling = 1 if  educat7==1|educat7==2|educat7==3
					replace schooling = 2 if (educy>=7  & educy<=9)  & (educat7==4)
					replace schooling = 3 if (educy>=10 & educy<=12) & (educat7==4|educat7==5)
					replace schooling = 4 if (educy>=13 & educy<=17)
					replace schooling = 5 if (educy>=18 & educy!=.)
					
					#delimit ;
					label define lblschooling
					1 "a lo mas primaria completa" 2 "secundaria completa o incompleta" 3 "preparatoria completa o incompleta"
					4 "profesional completa o incompleta" 5 "postgrado completo o incompleto";
					#delimit cr
					label values schooling lblschooling
					
			* SVY Tabulations	
				* Internet job-seekers, by gender
					svyset psu [w=weight]
					*estpost svy: tab male if internetseeker==1, level(95) proportion se ci nototal
					estpost svy: tab male internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t3_ac_`yyyy'q`q' = e(b)'
						matrix t3_ac_`yyyy'q`q' = t3_ac_`yyyy'q`q'[3..4,1]
					matrix t3_bd_`yyyy'q`q' = e(se)'
						matrix t3_bd_`yyyy'q`q' = t3_bd_`yyyy'q`q'[3..4,1]
						
				* Internet job-seekers, by age
					svyset psu [w=weight]
					estpost svy: tab agegroup internetseeker if unemployed==1 & agegroup>0, level(95) proportion se ci nototal
					matrix t3_ek_`yyyy'q`q' = e(b)'
						matrix t3_ek_`yyyy'q`q' = t3_ek_`yyyy'q`q'[5..8,1]
					matrix t3_fl_`yyyy'q`q' = e(se)'
						matrix t3_fl_`yyyy'q`q' = t3_fl_`yyyy'q`q'[5..8,1]
				
				* Internet job-seekers, by schooling
					svyset psu [w=weight]
					estpost svy: tab schooling internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t3_m1_`yyyy'q`q' = e(b)'
						matrix t3_m1_`yyyy'q`q' = t3_m1_`yyyy'q`q'[6..10,1]
					matrix t3_n1_`yyyy'q`q' = e(se)'
						matrix t3_n1_`yyyy'q`q' = t3_n1_`yyyy'q`q'[6..10,1]
				
				* Other job-seekers, by gender
					svyset psu [w=weight]
					estpost svy: tab male internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t3_AC_`yyyy'q`q' = e(b)'
						matrix t3_AC_`yyyy'q`q' = t3_AC_`yyyy'q`q'[1..2,1]
					matrix t3_BD_`yyyy'q`q' = e(se)'
						matrix t3_BD_`yyyy'q`q' = t3_BD_`yyyy'q`q'[1..2,1]

				* Other job-seekers, by age
					svyset psu [w=weight]
					estpost svy: tab agegroup internetseeker if unemployed==1 & agegroup>0, level(95) proportion se ci nototal
					matrix t3_EK_`yyyy'q`q' = e(b)'
						matrix t3_EK_`yyyy'q`q' = t3_EK_`yyyy'q`q'[1..4,1]
					matrix t3_FL_`yyyy'q`q' = e(se)'
						matrix t3_FL_`yyyy'q`q' = t3_FL_`yyyy'q`q'[1..4,1]
					
				* Other job-seekers, by schooling
					svyset psu [w=weight]
					estpost svy: tab schooling internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t3_M1_`yyyy'q`q' = e(b)'
						matrix t3_M1_`yyyy'q`q' = t3_M1_`yyyy'q`q'[1..5,1]
					matrix t3_N1_`yyyy'q`q' = e(se)'
						matrix t3_N1_`yyyy'q`q' = t3_N1_`yyyy'q`q'[1..5,1]
				
			* Arrange tables
				
				#delimit ;
				matrix define t3_`yyyy'q`q' = [	t3_ac_`yyyy'q`q'[1,1] \ t3_bd_`yyyy'q`q'[1,1] \ t3_ac_`yyyy'q`q'[2,1] \ t3_bd_`yyyy'q`q'[2,1] \
												t3_ek_`yyyy'q`q'[1,1] \ t3_fl_`yyyy'q`q'[1,1] \ t3_ek_`yyyy'q`q'[2,1] \ t3_fl_`yyyy'q`q'[2,1] \ t3_ek_`yyyy'q`q'[3,1] \ t3_fl_`yyyy'q`q'[3,1] \ t3_ek_`yyyy'q`q'[4,1] \ t3_fl_`yyyy'q`q'[4,1] \
												t3_m1_`yyyy'q`q'[1,1] \ t3_n1_`yyyy'q`q'[1,1] \ t3_m1_`yyyy'q`q'[2,1] \ t3_n1_`yyyy'q`q'[2,1] \ t3_m1_`yyyy'q`q'[3,1] \ t3_n1_`yyyy'q`q'[3,1] \ t3_m1_`yyyy'q`q'[4,1] \ t3_n1_`yyyy'q`q'[4,1] \ t3_m1_`yyyy'q`q'[5,1] \ t3_n1_`yyyy'q`q'[5,1] \
												t3_AC_`yyyy'q`q'[1,1] \ t3_BD_`yyyy'q`q'[1,1] \ t3_AC_`yyyy'q`q'[2,1] \ t3_BD_`yyyy'q`q'[2,1] \	
												t3_EK_`yyyy'q`q'[1,1] \ t3_FL_`yyyy'q`q'[1,1] \ t3_EK_`yyyy'q`q'[2,1] \ t3_FL_`yyyy'q`q'[2,1] \ t3_EK_`yyyy'q`q'[3,1] \ t3_FL_`yyyy'q`q'[3,1] \ t3_EK_`yyyy'q`q'[4,1] \ t3_FL_`yyyy'q`q'[4,1] \
												t3_M1_`yyyy'q`q'[1,1] \ t3_N1_`yyyy'q`q'[1,1] \ t3_M1_`yyyy'q`q'[2,1] \ t3_N1_`yyyy'q`q'[2,1] \ t3_M1_`yyyy'q`q'[3,1] \ t3_N1_`yyyy'q`q'[3,1] \ t3_M1_`yyyy'q`q'[4,1] \ t3_N1_`yyyy'q`q'[4,1] \ t3_M1_`yyyy'q`q'[5,1] \ t3_N1_`yyyy'q`q'[5,1] 
												];
				#delimit cr
				
				if `cycle'==1 {
						local keepmatrix "t3_`yyyy'q`q'"
						local t3colnames `" "t3`yyyy'`q'" "'
				}
				if `cycle'> 1 {
						local keepmatrix "`keepmatrix' , t3_`yyyy'q`q'"
						local t3colnames `"  `t3colnames'   "t3`yyyy'`q'" "'
				}
		}
			
				local cycle = `cycle'+1
	}	
	}
	
		matrix define   t3 = [`keepmatrix']
		matrix colnames t3 = `t3colnames'
	
		clear
		svmat t3, names(col)
		gen n = _n
		save "$output/temp/t3`iniyear'.dta", replace	

}

/*******************************************************************************
Sub Process Table 3.1 
*******************************************************************************/
if "`runtable3_1'"=="yes" {
	clear
	
	forval yyyy = `iniyear'/`finyear' {
		if `yyyy'==2005 use "$output/temp/t3`yyyy'.dta"
		else {
			merge 1:1 n using "$output/temp/t3`yyyy'.dta"
				drop _merge
			}
	}
	sort n
	drop n
	
	export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 3 raw") sheetmodify firstrow(variables)

}

/*******************************************************************************
Table 4.
*******************************************************************************/
if "`runtable4'"=="yes" {
	
* Read the full sample
	local keepvars "psu strata weight year quarter lstatus p2d* urban subnatid1"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		local counter = (`yyyy'-2005)*4 + `q'
		
		if `counter'!=62 {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1
				
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
									
			* SVY Tabulations	
				* Internet job-seekers, by urban
					svyset psu [w=weight]
					estpost svy: tab urban internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t4_a1_`yyyy'q`q' = e(b)'
						matrix t4_a1_`yyyy'q`q' = t4_a1_`yyyy'q`q'[3..4,1]
					matrix t4_b1_`yyyy'q`q' = e(se)'
						matrix t4_b1_`yyyy'q`q' = t4_b1_`yyyy'q`q'[3..4,1]
				
				
				* Other job-seekers, by urban
					svyset psu [w=weight]
					estpost svy: tab urban internetseeker if unemployed==1, level(95) proportion se ci nototal
					matrix t4_A1_`yyyy'q`q' = e(b)'
						matrix t4_A1_`yyyy'q`q' = t4_A1_`yyyy'q`q'[1..2,1]
					matrix t4_B1_`yyyy'q`q' = e(se)'
						matrix t4_B1_`yyyy'q`q' = t4_B1_`yyyy'q`q'[1..2,1]

				#delimit ;
				matrix define t4_`yyyy'q`q' = [	t4_a1_`yyyy'q`q'[1,1] \ t4_b1_`yyyy'q`q'[1,1] \ t4_a1_`yyyy'q`q'[2,1] \ t4_b1_`yyyy'q`q'[2,1] \
												t4_A1_`yyyy'q`q'[1,1] \ t4_B1_`yyyy'q`q'[1,1] \ t4_A1_`yyyy'q`q'[2,1] \ t4_B1_`yyyy'q`q'[2,1] 
												];
				#delimit cr
				
				if `cycle'==1 {
						local keepmatrix "t4_`yyyy'q`q'"
						local t4colnames `" "t4`yyyy'`q'" "'
				}
				if `cycle'> 1 {
						local keepmatrix "`keepmatrix' , t4_`yyyy'q`q'"
						local t4colnames `"  `t4colnames'   "t4`yyyy'`q'" "'
				}
				
				local cycle = `cycle'+1
		}
			
	}	
	}
	
		matrix define   t4A = [`keepmatrix']
		matrix colnames t4A = `t4colnames'
		
		
	clear
	local keepvars "psu strata weight year quarter lstatus p2d* urban subnatid1"
	use `keepvars' if year>=`iniyear' & year<=`finyear' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	
		* SVY SET
		svyset psu [w=weight]
	
		* Generate varibles for tabulation
		* Unemployed out of labor force
			gen byte unemployed = . 
			replace unemployed = 1 if lstatus==2
			replace unemployed = 0 if lstatus==1
		
		* Internet search out of unemployed
			gen byte internetseeker = . 
			replace  internetseeker = 0 if           unemployed==1
			replace  internetseeker = 1 if p2d6==6 & unemployed==1
		
		* Type of Search
			gen otherseeker = .
			* Skip option 6 for internet search and omit option 99
			foreach i in 1 2 3 4 5 7 8 9 10 11 {
				replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
			}
			drop p2d*
		
		* Dummies for all subnatid1
			tab subnatid1, gen(S)
		
		* Save frame global
			frame put _all, into(global)
		
		* Frame to Store Results
			frame create results t4mean 
		
		* SVY
			svyset psu [w=weight]
		
		* Save frames and perform tabulations
		
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			
			local counter = (`yyyy'-2005)*4 + `q'
			
			if `counter'!=62 {
				noi di ""
				noi di "`yyyy' `q'"
				noi di ""
				
				cap frame drop t4`yyyy'q`q'
				frame copy global t4`yyyy'q`q'
				frame t4`yyyy'q`q' : keep if year==`yyyy' & quarter==`q'
				
				forval s = 1/32 {
					
					frame t4`yyyy'q`q' : estpost svy: tab internetseeker S`s' if unemployed==1, level(95) proportion se ci nototal
					matrix t4S`s'_e1_`yyyy'q`q' = e(b)'
						matrix t4S`s'_e1_`yyyy'q`q' = t4S`s'_e1_`yyyy'q`q'[4,1]
					matrix t4S`s'_f1_`yyyy'q`q' = e(se)'
						matrix t4S`s'_f1_`yyyy'q`q' = t4S`s'_f1_`yyyy'q`q'[4,1]
						
					matrix t4S`s'_ef_`yyyy'q`q' = t4S`s'_e1_`yyyy'q`q' \ t4S`s'_f1_`yyyy'q`q'
					
					if `s'==1 local savematrix1 "t4S`s'_ef_`yyyy'q`q'"
					if `s'> 1 local savematrix1 "`savematrix1' \ t4S`s'_ef_`yyyy'q`q' "
					
				}
				
				
				forval s = 1/32 {
					
					frame t4`yyyy'q`q' : estpost svy: tab internetseeker S`s' if unemployed==1, level(95) proportion se ci nototal
					matrix t4S`s'_E1_`yyyy'q`q' = e(b)'
						matrix t4S`s'_E1_`yyyy'q`q' = t4S`s'_E1_`yyyy'q`q'[3,1]
					matrix t4S`s'_F1_`yyyy'q`q' = e(se)'
						matrix t4S`s'_F1_`yyyy'q`q' = t4S`s'_F1_`yyyy'q`q'[3,1]
						
					matrix t4S`s'_EF_`yyyy'q`q' = t4S`s'_E1_`yyyy'q`q' \ t4S`s'_F1_`yyyy'q`q'
					
					if `s'==1 local savematrix2 "t4S`s'_EF_`yyyy'q`q'"
					if `s'> 1 local savematrix2 "`savematrix2' \ t4S`s'_EF_`yyyy'q`q' "
					
				}
				
				matrix t4_`yyyy'q`q' = `savematrix1' \ `savematrix2'
			}
		}
		}

		
		local cycle = 1
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			local counter = (`yyyy'-2005)*4 + `q'
				if `counter'!=62 {
				if `cycle'==1 {
					local keepmatrix "t4_`yyyy'q`q'"
					local t4colnames `" "t4`yyyy'`q'" "'
				}
				if `cycle'> 1 {
					local keepmatrix "`keepmatrix' , t4_`yyyy'q`q'"
					local t4colnames `"  `t4colnames'   "t4`yyyy'`q'" "'
				}
			}
			local cycle = `cycle'+1
		}
		}

		matrix define   t4B = [`keepmatrix']
		matrix colnames t4B = `t4colnames'
		
		matrix define t4 = [t4A \ t4B]
		
		clear
		svmat t4, names(col)
		gen n = _n
		save "$output/temp/t4`iniyear'.dta", replace		
		
}
/*******************************************************************************
Sub Process Table 4.1 
*******************************************************************************/
if "`runtable4_1'"=="yes" {
	clear
	
	forval yyyy = `iniyear'/`finyear' {
		if `yyyy'==2005 use "$output/temp/t4`yyyy'.dta"
		else {
			merge 1:1 n using "$output/temp/t4`yyyy'.dta"
				drop _merge
			}
	}
	sort n
	drop n
	
	export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 4 raw") sheetmodify firstrow(variables)

}
/*******************************************************************************
Table 5.
*******************************************************************************/
if "`runtable5'"=="yes" {
	
	* Read the full sample
	local keepvars "psu strata weight year quarter age lstatus p2d6 p3n"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		if `counter'!=62 {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", replace
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1

				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2
					
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
					
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1
					
			* SVY Tabulations
				* Total unemployed
					svy: total employed
					matrix t5_a_`yyyy'q`q' = r(table)
					matrix t5_a_`yyyy'q`q' = t5_a_`yyyy'q`q'[1,1]
						
				
				* Employed, as percent of labor force
					estpost svy: tabulate employed, level(95) proportion se ci nototal
					matrix  t5_b_`yyyy'q`q'  = e(b)
					matrix  t5_b_`yyyy'q`q'  = t5_b_`yyyy'q`q'[1,2]
					matrix  t5_c_`yyyy'q`q' = e(se)
					matrix  t5_c_`yyyy'q`q' = t5_c_`yyyy'q`q'[1,2]
					
				* Employed using internet finder, answer = 1 to p2d6
					svy: total internetfinder
					matrix t5_d_`yyyy'q`q' = r(table)
					matrix t5_d_`yyyy'q`q' = t5_d_`yyyy'q`q'[1,1]
						
				* Internet job-finders, as percentage of unemployed
					svyset psu [w=weight]
					estpost svy: tabulate internetfinder, level(95) proportion se ci nototal
					matrix t5_e_`yyyy'q`q' = e(b)
					matrix t5_e_`yyyy'q`q' = t5_e_`yyyy'q`q'[1,2]
					matrix t5_f_`yyyy'q`q' = e(se)
					matrix t5_f_`yyyy'q`q' = t5_f_`yyyy'q`q'[1,2]
					
			* Arrange tables
				#delimit ; 
				matrix define t5_`yyyy'q`q' = [t5_a_`yyyy'q`q' \
											 t5_b_`yyyy'q`q' \ 
											 t5_c_`yyyy'q`q' \ 
											 t5_d_`yyyy'q`q' \ 
											 t5_e_`yyyy'q`q' \ 
											 t5_f_`yyyy'q`q'] ; 
				#delimit cr
				
				if `cycle'==1 {
						local keepmatrix "t5_`yyyy'q`q'"
						local t5colnames `" "t5`yyyy'`q'" "'
				}
				if `cycle'> 1 {
						local keepmatrix "`keepmatrix' , t5_`yyyy'q`q'"
						local t5colnames `"  `t5colnames'   "t5`yyyy'`q'" "'
				}
		}
			
				local cycle = `counter'+1
		}
		
	}
	
		matrix define t5 = [`keepmatrix']
		matrix colnames t5 = `t5colnames'
	
	* Calculate Table 5b
		local n = 1
		forval j = 2005/2023 {
			
			local m = 4*(`n'-1) + 1
			local p = 4*(`n'-1) + 1 -1
			
			if `j'==2005 			local t5bmatrix = "t5[1..6,`m']"
			if `j'> 2005 & `j'<2020 local t5bmatrix = "`t5bmatrix' , t5[1..6,`m']"
			if `j'>=2020 			local t5bmatrix = "`t5bmatrix' , t5[1..6,`p']"
			
			local n = `n'+1
		}

		matrix define t5b = `t5bmatrix'

		
putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 5a raw") modify
putexcel A1 = matrix(t5), colnames

putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 5b raw") modify
putexcel A1 = matrix(t5b), colnames
					   
}
/*******************************************************************************
Table 5.N
*******************************************************************************/
if "`runtable5N'"=="yes" {
	
	* Read the full sample
	local keepvars "psu strata weight year quarter age lstatus p2d6 p2d9 p3n"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		if `counter'!=62 {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", replace
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1

				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2
					
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1

				* Network search out of unemployed
					gen byte networkseeker = . 
					replace  networkseeker = 0 if           unemployed==1
					replace  networkseeker = 1 if p2d9==9 & unemployed==1
					
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1
					
				* Network finder out of unemployed
					gen byte networkfinder = . 
					replace  networkfinder = 0 if          employed==1
					replace  networkfinder = 1 if p3n==8 & employed==1					
					
			* SVY Tabulations
				* Total unemployed
					svy: total employed
					matrix t5_a_`yyyy'q`q' = r(table)
					matrix t5_a_`yyyy'q`q' = t5_a_`yyyy'q`q'[1,1]
						
				
				* Employed, as percent of labor force
					estpost svy: tabulate employed, level(95) proportion se ci nototal
					matrix  t5_b_`yyyy'q`q'  = e(b)
					matrix  t5_b_`yyyy'q`q'  = t5_b_`yyyy'q`q'[1,2]
					matrix  t5_c_`yyyy'q`q' = e(se)
					matrix  t5_c_`yyyy'q`q' = t5_c_`yyyy'q`q'[1,2]
					
				* Employed using network finder, answer = 1 to p2d6
					svy: total networkfinder
					matrix t5_d_`yyyy'q`q' = r(table)
					matrix t5_d_`yyyy'q`q' = t5_d_`yyyy'q`q'[1,1]
						
				* Network job-finders, as percentage of unemployed
					svyset psu [w=weight]
					estpost svy: tabulate networkfinder, level(95) proportion se ci nototal
					matrix t5_e_`yyyy'q`q' = e(b)
					matrix t5_e_`yyyy'q`q' = t5_e_`yyyy'q`q'[1,2]
					matrix t5_f_`yyyy'q`q' = e(se)
					matrix t5_f_`yyyy'q`q' = t5_f_`yyyy'q`q'[1,2]
					
			* Arrange tables
				#delimit ; 
				matrix define t5_`yyyy'q`q' = [t5_a_`yyyy'q`q' \
											 t5_b_`yyyy'q`q' \ 
											 t5_c_`yyyy'q`q' \ 
											 t5_d_`yyyy'q`q' \ 
											 t5_e_`yyyy'q`q' \ 
											 t5_f_`yyyy'q`q'] ; 
				#delimit cr
				
				if `cycle'==1 {
						local keepmatrix "t5_`yyyy'q`q'"
						local t5colnames `" "t5`yyyy'`q'" "'
				}
				if `cycle'> 1 {
						local keepmatrix "`keepmatrix' , t5_`yyyy'q`q'"
						local t5colnames `"  `t5colnames'   "t5`yyyy'`q'" "'
				}
		}
			
				local cycle = `counter'+1
		}
		
	}
	
		matrix define t5 = [`keepmatrix']
		matrix colnames t5 = `t5colnames'
	
	* Calculate Table 5b
		local n = 1
		forval j = 2005/2023 {
			
			local m = 4*(`n'-1) + 1
			local p = 4*(`n'-1) + 1 -1
			
			if `j'==2005 			local t5bmatrix = "t5[1..6,`m']"
			if `j'> 2005 & `j'<2020 local t5bmatrix = "`t5bmatrix' , t5[1..6,`m']"
			if `j'>=2020 			local t5bmatrix = "`t5bmatrix' , t5[1..6,`p']"
			
			local n = `n'+1
		}

		matrix define t5b = `t5bmatrix'

		
putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 5Na raw") modify
putexcel A1 = matrix(t5), colnames

putexcel set "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 5Nb raw") modify
putexcel A1 = matrix(t5b), colnames
					   
}
/*******************************************************************************
Table 6.
*******************************************************************************/
if "`runtable6'"=="yes" {
	
	* Read the full sample
	local keepvars "psu strata weight year quarter age lstatus p2d* p3n male educy educat7"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		if `counter'!=62 {
			
			noi di ""
			noi di "`yyyy' q`q' counter: `counter'"
			noi di ""
			
			use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
			
			sum p3n 
			local nobs = r(N)
			
			if `nobs'>0 & `nobs'!=. {
				* Note: Missing standard errors because of stratum with single sampling unit. 	
				svyset psu [w=weight] // , strata(strata)
				
				* Generate varibles for tabulation
					* Unemployed out of labor force
						gen byte unemployed = . 
						replace unemployed = 1 if lstatus==2
						replace unemployed = 0 if lstatus==1

					* Employed out of labor force
						gen byte employed = . 
						replace employed = 1 if lstatus==1
						replace employed = 0 if lstatus==2					
						
					* Internet search out of unemployed
						gen byte internetseeker = . 
						replace  internetseeker = 0 if           unemployed==1
						replace  internetseeker = 1 if p2d6==6 & unemployed==1
					
					* Type of Search
						gen otherseeker = .
						* Skip option 6 for internet search and omit option 99
						foreach i in 1 2 3 4 5 7 8 9 10 11 {
							replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
						}
					
					* Internet finder out of unemployed
						gen byte internetfinder = . 
						replace  internetfinder = 0 if          employed==1
						replace  internetfinder = 1 if p3n==6 & employed==1				
					
					* Age Group
						gen agegroup = .
						replace agegroup = 0 if age>=0  & age<=14
						replace agegroup = 1 if age>=15 & age<=29
						replace agegroup = 2 if age>=30 & age<=34
						replace agegroup = 3 if age>=45 & age<=59
						replace agegroup = 4 if age>=60 & age!=.
						label define lblagegroup 0 "0-14" 1 "15-29" 2 "30-34" 3 "45-59" 4 "60 and more"
						label values agegroup lblagegroup
					
					* Educational attainment, based on years of schooling and educat7
						gen schooling = .
						*replace schooling = 0 if educat7==1
						*replace schooling = 1 if educat7==2|educat7==3
						replace schooling = 1 if  educat7==1|educat7==2|educat7==3
						replace schooling = 2 if (educy>=7  & educy<=9)  & (educat7==4)
						replace schooling = 3 if (educy>=10 & educy<=12) & (educat7==4|educat7==5)
						replace schooling = 4 if (educy>=13 & educy<=17)
						replace schooling = 5 if (educy>=18 & educy!=.)
						
						#delimit ;
						label define lblschooling
						1 "a lo mas primaria completa" 2 "secundaria completa o incompleta" 3 "preparatoria completa o incompleta"
						4 "profesional completa o incompleta" 5 "postgrado completo o incompleto";
						#delimit cr
						label values schooling lblschooling
						
				* SVY Tabulations	
					* Internet job-finders, by gender
						svyset psu [w=weight]
						estpost svy: tab male internetfinder if employed==1, level(95) proportion se ci nototal
						matrix t6_ac_`yyyy'q`q' = e(b)'
							matrix t6_ac_`yyyy'q`q' = t6_ac_`yyyy'q`q'[3..4,1]
						 
						matrix t6_bd_`yyyy'q`q' = e(se)'
							matrix t6_bd_`yyyy'q`q' = t6_bd_`yyyy'q`q'[3..4,1]
						 
							
					* Internet job-finders, by age
						svyset psu [w=weight]
						estpost svy: tab agegroup internetfinder if employed==1 & agegroup>0, level(95) proportion se ci nototal
						matrix t6_ek_`yyyy'q`q' = e(b)'
							matrix t6_ek_`yyyy'q`q' = t6_ek_`yyyy'q`q'[5..8,1]
						 
						matrix t6_fl_`yyyy'q`q' = e(se)'
							matrix t6_fl_`yyyy'q`q' = t6_fl_`yyyy'q`q'[5..8,1]
						 
					
					* Internet job-finders, by schooling
						svyset psu [w=weight]
						estpost svy: tab schooling internetfinder if employed==1, level(95) proportion se ci nototal
						matrix t6_m1_`yyyy'q`q' = e(b)'
							matrix t6_m1_`yyyy'q`q' = t6_m1_`yyyy'q`q'[6..10,1]
						 						
						matrix t6_n1_`yyyy'q`q' = e(se)'
							matrix t6_n1_`yyyy'q`q' = t6_n1_`yyyy'q`q'[6..10,1]
					
					* Other job-finders, by gender
						svyset psu [w=weight]
						estpost svy: tab male internetfinder if employed==1, level(95) proportion se ci nototal
						matrix t6_AC_`yyyy'q`q' = e(b)'
							matrix t6_AC_`yyyy'q`q' = t6_AC_`yyyy'q`q'[1..2,1]
						 						
						matrix t6_BD_`yyyy'q`q' = e(se)'
							matrix t6_BD_`yyyy'q`q' = t6_BD_`yyyy'q`q'[1..2,1]
						 							
					* Other job-finders, by age
						svyset psu [w=weight]
						estpost svy: tab agegroup internetfinder if employed==1 & agegroup>0, level(95) proportion se ci nototal
						matrix t6_EK_`yyyy'q`q' = e(b)'
							matrix t6_EK_`yyyy'q`q' = t6_EK_`yyyy'q`q'[1..4,1]
						 						
						matrix t6_FL_`yyyy'q`q' = e(se)'
							matrix t6_FL_`yyyy'q`q' = t6_FL_`yyyy'q`q'[1..4,1]
						 						
					* Other job-finders, by schooling
						svyset psu [w=weight]
						estpost svy: tab schooling internetfinder if employed==1, level(95) proportion se ci nototal
						matrix t6_M1_`yyyy'q`q' = e(b)'
							matrix t6_M1_`yyyy'q`q' = t6_M1_`yyyy'q`q'[1..5,1]
						 						 
						matrix t6_N1_`yyyy'q`q' = e(se)'
							matrix t6_N1_`yyyy'q`q' = t6_N1_`yyyy'q`q'[1..5,1]
						 					
				* Arrange tables
					
					#delimit ;
					matrix define t6_`yyyy'q`q' = [	t6_ac_`yyyy'q`q'[1,1] \ t6_bd_`yyyy'q`q'[1,1] \ t6_ac_`yyyy'q`q'[2,1] \ t6_bd_`yyyy'q`q'[2,1] \
													t6_ek_`yyyy'q`q'[1,1] \ t6_fl_`yyyy'q`q'[1,1] \ t6_ek_`yyyy'q`q'[2,1] \ t6_fl_`yyyy'q`q'[2,1] \ t6_ek_`yyyy'q`q'[3,1] \ t6_fl_`yyyy'q`q'[3,1] \ t6_ek_`yyyy'q`q'[4,1] \ t6_fl_`yyyy'q`q'[4,1] \
													t6_m1_`yyyy'q`q'[1,1] \ t6_n1_`yyyy'q`q'[1,1] \ t6_m1_`yyyy'q`q'[2,1] \ t6_n1_`yyyy'q`q'[2,1] \ t6_m1_`yyyy'q`q'[3,1] \ t6_n1_`yyyy'q`q'[3,1] \ t6_m1_`yyyy'q`q'[4,1] \ t6_n1_`yyyy'q`q'[4,1] \ t6_m1_`yyyy'q`q'[5,1] \ t6_n1_`yyyy'q`q'[5,1] \
													t6_AC_`yyyy'q`q'[1,1] \ t6_BD_`yyyy'q`q'[1,1] \ t6_AC_`yyyy'q`q'[2,1] \ t6_BD_`yyyy'q`q'[2,1] \	
													t6_EK_`yyyy'q`q'[1,1] \ t6_FL_`yyyy'q`q'[1,1] \ t6_EK_`yyyy'q`q'[2,1] \ t6_FL_`yyyy'q`q'[2,1] \ t6_EK_`yyyy'q`q'[3,1] \ t6_FL_`yyyy'q`q'[3,1] \ t6_EK_`yyyy'q`q'[4,1] \ t6_FL_`yyyy'q`q'[4,1] \
													t6_M1_`yyyy'q`q'[1,1] \ t6_N1_`yyyy'q`q'[1,1] \ t6_M1_`yyyy'q`q'[2,1] \ t6_N1_`yyyy'q`q'[2,1] \ t6_M1_`yyyy'q`q'[3,1] \ t6_N1_`yyyy'q`q'[3,1] \ t6_M1_`yyyy'q`q'[4,1] \ t6_N1_`yyyy'q`q'[4,1] \ t6_M1_`yyyy'q`q'[5,1] \ t6_N1_`yyyy'q`q'[5,1] 
													];
					#delimit cr
			}
			if `nobs'==0 {
					#delimit ;
					matrix define t6_`yyyy'q`q' = [	. \ . \ . \ . \
													. \ . \ . \ . \ . \ . \ . \ . \
													. \ . \ . \ . \ . \ . \ . \ . \ . \ . \
													. \ . \ . \ . \	
													. \ . \ . \ . \ . \ . \ . \ . \
													. \ . \ . \ . \ . \ . \ . \ . \ . \ . 
													];
					#delimit cr
			}
					if `cycle'==1 {
							local keepmatrix "t6_`yyyy'q`q'"
							local t6colnames `" "t6`yyyy'`q'" "'
					}
					if `cycle'> 1 {
							local keepmatrix "`keepmatrix' , t6_`yyyy'q`q'"
							local t6colnames `"  `t6colnames'   "t6`yyyy'`q'" "'
					}
		
			local cycle = `cycle'+1
		}
		}
		}
		
			matrix define   t6 = [`keepmatrix']
			matrix colnames t6 = `t6colnames'
	
		clear
		svmat t6, names(col)
		gen n = _n
		save "$output/temp/t6`iniyear'.dta", replace	

}
/*******************************************************************************
Sub Process Table 6.1
*******************************************************************************/
if "`runtable6_1'"=="yes" {
	clear
	
	forval yyyy = `iniyear'/`finyear' {
		if `yyyy'==2005 use "$output/temp/t6`yyyy'.dta"
		else {
			merge 1:1 n using "$output/temp/t6`yyyy'.dta"
				drop _merge
			}
	}
	sort n
	drop n
	
	export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 6 raw") sheetmodify firstrow(variables)

}
/*******************************************************************************
Table 7
*******************************************************************************/
if "`runtable7'"=="yes" {
	
* Read the full sample
	local keepvars "psu strata weight year quarter lstatus p2d* p3n informal urban subnatid1"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		
		if `counter'!=62 {
			
		noi di ""
		noi di "`yyyy' q`q' counter: `counter'"
		noi di ""
		
		use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear

		sum p3n 
		local nobs = r(N)			
		if `nobs'>0 & `nobs'!=. {
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1

				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2					
					
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
				
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1				
						
				* Informal
					replace informal = 1 if informal==3 & lstatus==1
						
			* SVY Tabulations	
				* Internet job-seekers, by informal
					svyset psu [w=weight]
					estpost svy: tab informal internetfinder if employed==1, level(95) proportion se ci nototal
					matrix t7_a1_`yyyy'q`q' = e(b)'
						matrix t7_a1_`yyyy'q`q' = t7_a1_`yyyy'q`q'[3..4,1]
					matrix t7_b1_`yyyy'q`q' = e(se)'
						matrix t7_b1_`yyyy'q`q' = t7_b1_`yyyy'q`q'[3..4,1]
				
				
				* Other job-seekers, by informal
					svyset psu [w=weight]
					estpost svy: tab informal internetfinder if employed==1, level(95) proportion se ci nototal
					matrix t7_A1_`yyyy'q`q' = e(b)'
						matrix t7_A1_`yyyy'q`q' = t7_A1_`yyyy'q`q'[1..2,1]
					matrix t7_B1_`yyyy'q`q' = e(se)'
						matrix t7_B1_`yyyy'q`q' = t7_B1_`yyyy'q`q'[1..2,1]

				#delimit ;
				matrix define t7_`yyyy'q`q' = [	t7_a1_`yyyy'q`q'[1,1] \ t7_b1_`yyyy'q`q'[1,1] \ t7_a1_`yyyy'q`q'[2,1] \ t7_b1_`yyyy'q`q'[2,1] \
												t7_A1_`yyyy'q`q'[1,1] \ t7_B1_`yyyy'q`q'[1,1] \ t7_A1_`yyyy'q`q'[2,1] \ t7_B1_`yyyy'q`q'[2,1] 
												];
				#delimit cr
				
				
				
			}
		if `nobs'==0 {
			#delimit ;
			matrix define t7_`yyyy'q`q' = [	. \ . \ . \ . \
											. \ . \ . \ . 
											];
			#delimit cr
			
		}

		if `cycle'==1 {
				local keepmatrix "t7_`yyyy'q`q'"
				local t7colnames `" "t7`yyyy'`q'" "'
		}
		if `cycle'> 1 {
				local keepmatrix "`keepmatrix' , t7_`yyyy'q`q'"
				local t7colnames `"  `t7colnames'   "t7`yyyy'`q'" "'
		}	
		
		local cycle = `cycle'+1
		}	
	}
	}
	
		* Assuming that at least one cycle was valid
		matrix define   t7A = [`keepmatrix']
		matrix colnames t7A = `t7colnames'
		
		
	clear
	local keepvars "psu strata weight year quarter lstatus p2d* p3n informal industry_orig urban subnatid1"
	use `keepvars' if year>=`iniyear' & year<=`finyear' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	
		* SVY SET
		svyset psu [w=weight]
	
		* Generate varibles for tabulation
		* Unemployed out of labor force
			gen byte unemployed = . 
			replace unemployed = 1 if lstatus==2
			replace unemployed = 0 if lstatus==1
		
		* Employed out of labor force
			gen byte employed = . 
			replace employed = 1 if lstatus==1
			replace employed = 0 if lstatus==2					
		
		* Internet search out of unemployed
			gen byte internetseeker = . 
			replace  internetseeker = 0 if           unemployed==1
			replace  internetseeker = 1 if p2d6==6 & unemployed==1
		
		* Type of Search
			gen otherseeker = .
			* Skip option 6 for internet search and omit option 99
			foreach i in 1 2 3 4 5 7 8 9 10 11 {
				replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
			}
			drop p2d*
		
		* Internet finder out of unemployed
			gen byte internetfinder = . 
			replace  internetfinder = 0 if          employed==1
			replace  internetfinder = 1 if p3n==6 & employed==1						
	
		* Informal
			replace informal = 1 if informal==3 & lstatus==1
		
		* Industries
			gen industry_orig2d = int(industry_orig/100)
				#delimit ;
				recode industry_orig2d (11 = 1)
									   (21 22 = 2)
									   (23 = 3)
									   (31/33 = 4)
									   (43 46 = 5)
									   (48 49 = 6)
									   (51 = 7)
									   (52 53 = 8)
									   (54 55 = 9)
									   (61 =10)
									   (62 =11)
									   (71 =12)
									   (72 =13)
									   (93 =14)
									   (99 81 56 =15)
										, gen(myind);
				#delimit cr
		
		* Dummies for all subnatid1
			tab myind, gen(S)
		
		* Save frame global
			frame put _all, into(global)
		
		* Frame to Store Results
			frame create results t7mean 
		
		* SVY
			svyset psu [w=weight]
		
		* Save frames and perform tabulations
			
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			
		local counter = (`yyyy'-2005)*4 + `q'			
			
			if `counter'!=62 {
				
			sum p3n if year==`yyyy' & quarter==`q'
			local nobs = r(N)			
			
			if `nobs'>0 & `nobs'!=. {
				
				noi di ""
				noi di "`yyyy' `q'"
				noi di ""
				
				cap frame drop t7`yyyy'q`q'
				frame copy global t7`yyyy'q`q'
				frame t7`yyyy'q`q' : keep if year==`yyyy' & quarter==`q'
				
				forval s = 1/15 {
					
					frame t7`yyyy'q`q' : estpost svy: tab internetfinder S`s' if employed==1, level(95) proportion se ci nototal
					matrix t7S`s'_e1_`yyyy'q`q' = e(b)'
						matrix t7S`s'_e1_`yyyy'q`q' = t7S`s'_e1_`yyyy'q`q'[4,1]
					matrix t7S`s'_f1_`yyyy'q`q' = e(se)'
						matrix t7S`s'_f1_`yyyy'q`q' = t7S`s'_f1_`yyyy'q`q'[4,1]
						
					matrix t7S`s'_ef_`yyyy'q`q' = t7S`s'_e1_`yyyy'q`q' \ t7S`s'_f1_`yyyy'q`q'
					
					if `s'==1 local savematrix1 "t7S`s'_ef_`yyyy'q`q'"
					if `s'> 1 local savematrix1 "`savematrix1' \ t7S`s'_ef_`yyyy'q`q' "
					
				}
				
				
				forval s = 1/15 {
					
					frame t7`yyyy'q`q' : estpost svy: tab internetfinder S`s' if employed==1, level(95) proportion se ci nototal
					matrix t7S`s'_E1_`yyyy'q`q' = e(b)'
						matrix t7S`s'_E1_`yyyy'q`q' = t7S`s'_E1_`yyyy'q`q'[3,1]
					matrix t7S`s'_F1_`yyyy'q`q' = e(se)'
						matrix t7S`s'_F1_`yyyy'q`q' = t7S`s'_F1_`yyyy'q`q'[3,1]
						
					matrix t7S`s'_EF_`yyyy'q`q' = t7S`s'_E1_`yyyy'q`q' \ t7S`s'_F1_`yyyy'q`q'
					
					if `s'==1 local savematrix2 "t7S`s'_EF_`yyyy'q`q'"
					if `s'> 1 local savematrix2 "`savematrix2' \ t7S`s'_EF_`yyyy'q`q' "
					
				}
				
				matrix t7_`yyyy'q`q' = `savematrix1' \ `savematrix2'
			}
			if `nobs'== 0 {
				
				forval s = 1/15 {
					matrix t7S`s'_ef_`yyyy'q`q' = [. \ .]
					if `s'==1 local savematrix1 "t7S`s'_ef_`yyyy'q`q'"
					if `s'> 1 local savematrix1 "`savematrix1' \ t7S`s'_ef_`yyyy'q`q' "
				}
				forval s = 1/15 {
					matrix t7S`s'_EF_`yyyy'q`q' = [. \ .]
					if `s'==1 local savematrix2 "t7S`s'_EF_`yyyy'q`q'"
					if `s'> 1 local savematrix2 "`savematrix2' \ t7S`s'_EF_`yyyy'q`q' "
					
				}
				
				matrix t7_`yyyy'q`q' = `savematrix1' \ `savematrix2'
			}
			}
		}
		}

		local cycle = 1
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			local counter = (`yyyy'-2005)*4 + `q'
				if `counter'!=62 {
				if `cycle'==1 {
					local keepmatrix "t7_`yyyy'q`q'"
					local t7colnames `" "t7`yyyy'`q'" "'
				}
				if `cycle'> 1 {
					local keepmatrix "`keepmatrix' , t7_`yyyy'q`q'"
					local t7colnames `"  `t7colnames'   "t7`yyyy'`q'" "'
				}
			}
			local cycle = `cycle'+1
		}
		}

		matrix define   t7B = [`keepmatrix']
		matrix colnames t7B = `t7colnames'
		
		matrix define t7 = [t7A \ t7B]
		
		clear
		svmat t7, names(col)
		gen n = _n
		save "$output/temp/t7`iniyear'.dta", replace		
		
}
/*******************************************************************************
Sub Process Table 7.1 
*******************************************************************************/
if "`runtable7_1'"=="yes" {
	clear
	
	forval yyyy = `iniyear'/`finyear' {
		if `yyyy'==2005 use "$output/temp/t7`yyyy'.dta"
		else {
			merge 1:1 n using "$output/temp/t7`yyyy'.dta"
				drop _merge
			}
	}
	sort n
	drop n
	
	export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 7 raw") sheetmodify firstrow(variables)

}
/*******************************************************************************
Table 8
*******************************************************************************/
if "`runtable8'"=="yes" {
	
* Read the full sample
	local keepvars "psu strata weight year quarter lstatus p2d* p3n urban subnatid1"
	
	local cycle = 1
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		local counter = (`yyyy'-2005)*4 + `q'
		
		if `counter'!=62 {
			
		noi di ""
		noi di "`yyyy' q`q' counter: `counter'"
		noi di ""
		
		use `keepvars' if year==`yyyy' & quarter==`q' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear

		sum p3n 
		local nobs = r(N)			
		if `nobs'>0 & `nobs'!=. {
			
			* Note: Missing standard errors because of stratum with single sampling unit. 
			svyset psu [w=weight] // , strata(strata)
			
			* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1

				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2					
					
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
				
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1				
									
			* SVY Tabulations	
				* Internet job-seekers, by urban
					svyset psu [w=weight]
					estpost svy: tab urban internetfinder if employed==1, level(95) proportion se ci nototal
					matrix t8_a1_`yyyy'q`q' = e(b)'
						matrix t8_a1_`yyyy'q`q' = t8_a1_`yyyy'q`q'[3..4,1]
					matrix t8_b1_`yyyy'q`q' = e(se)'
						matrix t8_b1_`yyyy'q`q' = t8_b1_`yyyy'q`q'[3..4,1]
				
				
				* Other job-seekers, by urban
					svyset psu [w=weight]
					estpost svy: tab urban internetfinder if employed==1, level(95) proportion se ci nototal
					matrix t8_A1_`yyyy'q`q' = e(b)'
						matrix t8_A1_`yyyy'q`q' = t8_A1_`yyyy'q`q'[1..2,1]
					matrix t8_B1_`yyyy'q`q' = e(se)'
						matrix t8_B1_`yyyy'q`q' = t8_B1_`yyyy'q`q'[1..2,1]

				#delimit ;
				matrix define t8_`yyyy'q`q' = [	t8_a1_`yyyy'q`q'[1,1] \ t8_b1_`yyyy'q`q'[1,1] \ t8_a1_`yyyy'q`q'[2,1] \ t8_b1_`yyyy'q`q'[2,1] \
												t8_A1_`yyyy'q`q'[1,1] \ t8_B1_`yyyy'q`q'[1,1] \ t8_A1_`yyyy'q`q'[2,1] \ t8_B1_`yyyy'q`q'[2,1] 
												];
				#delimit cr
				
				
				
			}
		if `nobs'==0 {
			#delimit ;
			matrix define t8_`yyyy'q`q' = [	. \ . \ . \ . \
											. \ . \ . \ . 
											];
			#delimit cr
			
		}

		if `cycle'==1 {
				local keepmatrix "t8_`yyyy'q`q'"
				local t8colnames `" "t8`yyyy'`q'" "'
		}
		if `cycle'> 1 {
				local keepmatrix "`keepmatrix' , t8_`yyyy'q`q'"
				local t8colnames `"  `t8colnames'   "t8`yyyy'`q'" "'
		}	
		
		local cycle = `cycle'+1
		}	
	}
	}
	
		* Assuming that at least one cycle was valid
		matrix define   t8A = [`keepmatrix']
		matrix colnames t8A = `t8colnames'
		
		
	clear
	local keepvars "psu strata weight year quarter lstatus p2d* p3n urban subnatid1"
	use `keepvars' if year>=`iniyear' & year<=`finyear' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta", clear
	
		* SVY SET
		svyset psu [w=weight]
	
		* Generate varibles for tabulation
		* Unemployed out of labor force
			gen byte unemployed = . 
			replace unemployed = 1 if lstatus==2
			replace unemployed = 0 if lstatus==1
		
		* Employed out of labor force
			gen byte employed = . 
			replace employed = 1 if lstatus==1
			replace employed = 0 if lstatus==2					
		
		* Internet search out of unemployed
			gen byte internetseeker = . 
			replace  internetseeker = 0 if           unemployed==1
			replace  internetseeker = 1 if p2d6==6 & unemployed==1
		
		* Type of Search
			gen otherseeker = .
			* Skip option 6 for internet search and omit option 99
			foreach i in 1 2 3 4 5 7 8 9 10 11 {
				replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
			}
			drop p2d*
		
		* Internet finder out of unemployed
			gen byte internetfinder = . 
			replace  internetfinder = 0 if          employed==1
			replace  internetfinder = 1 if p3n==6 & employed==1						
		
		* Dummies for all subnatid1
			tab subnatid1, gen(S)
		
		* Save frame global
			frame put _all, into(global)
		
		* Frame to Store Results
			frame create results t8mean 
		
		* SVY
			svyset psu [w=weight]
		
		* Save frames and perform tabulations
		
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			
		local counter = (`yyyy'-2005)*4 + `q'			
			
			if `counter'!=62 {
				
			sum p3n if year==`yyyy' & quarter==`q'
			local nobs = r(N)			
			
			if `nobs'>0 & `nobs'!=. {
				
				noi di ""
				noi di "`yyyy' `q'"
				noi di ""
				
				cap frame drop t8`yyyy'q`q'
				frame copy global t8`yyyy'q`q'
				frame t8`yyyy'q`q' : keep if year==`yyyy' & quarter==`q'
				
				forval s = 1/32 {
					
					frame t8`yyyy'q`q' : estpost svy: tab internetfinder S`s' if employed==1, level(95) proportion se ci nototal
					matrix t8S`s'_e1_`yyyy'q`q' = e(b)'
						matrix t8S`s'_e1_`yyyy'q`q' = t8S`s'_e1_`yyyy'q`q'[4,1]
					matrix t8S`s'_f1_`yyyy'q`q' = e(se)'
						matrix t8S`s'_f1_`yyyy'q`q' = t8S`s'_f1_`yyyy'q`q'[4,1]
						
					matrix t8S`s'_ef_`yyyy'q`q' = t8S`s'_e1_`yyyy'q`q' \ t8S`s'_f1_`yyyy'q`q'
					
					if `s'==1 local savematrix1 "t8S`s'_ef_`yyyy'q`q'"
					if `s'> 1 local savematrix1 "`savematrix1' \ t8S`s'_ef_`yyyy'q`q' "
					
				}
				
				
				forval s = 1/32 {
					
					frame t8`yyyy'q`q' : estpost svy: tab internetfinder S`s' if employed==1, level(95) proportion se ci nototal
					matrix t8S`s'_E1_`yyyy'q`q' = e(b)'
						matrix t8S`s'_E1_`yyyy'q`q' = t8S`s'_E1_`yyyy'q`q'[3,1]
					matrix t8S`s'_F1_`yyyy'q`q' = e(se)'
						matrix t8S`s'_F1_`yyyy'q`q' = t8S`s'_F1_`yyyy'q`q'[3,1]
						
					matrix t8S`s'_EF_`yyyy'q`q' = t8S`s'_E1_`yyyy'q`q' \ t8S`s'_F1_`yyyy'q`q'
					
					if `s'==1 local savematrix2 "t8S`s'_EF_`yyyy'q`q'"
					if `s'> 1 local savematrix2 "`savematrix2' \ t8S`s'_EF_`yyyy'q`q' "
					
				}
				
				matrix t8_`yyyy'q`q' = `savematrix1' \ `savematrix2'
			}
			if `nobs'== 0 {
				
				forval s = 1/32 {
					matrix t8S`s'_ef_`yyyy'q`q' = [. \ .]
					if `s'==1 local savematrix1 "t8S`s'_ef_`yyyy'q`q'"
					if `s'> 1 local savematrix1 "`savematrix1' \ t8S`s'_ef_`yyyy'q`q' "
				}
				forval s = 1/32 {
					matrix t8S`s'_EF_`yyyy'q`q' = [. \ .]
					if `s'==1 local savematrix2 "t8S`s'_EF_`yyyy'q`q'"
					if `s'> 1 local savematrix2 "`savematrix2' \ t8S`s'_EF_`yyyy'q`q' "
					
				}
				
				matrix t8_`yyyy'q`q' = `savematrix1' \ `savematrix2'
			}
			}
		}
		}

		local cycle = 1
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			local counter = (`yyyy'-2005)*4 + `q'
				if `counter'!=62 {
				if `cycle'==1 {
					local keepmatrix "t8_`yyyy'q`q'"
					local t8colnames `" "t8`yyyy'`q'" "'
				}
				if `cycle'> 1 {
					local keepmatrix "`keepmatrix' , t8_`yyyy'q`q'"
					local t8colnames `"  `t8colnames'   "t8`yyyy'`q'" "'
				}
			}
			local cycle = `cycle'+1
		}
		}

		matrix define   t8B = [`keepmatrix']
		matrix colnames t8B = `t8colnames'
		
		matrix define t8 = [t8A \ t8B]
		
		clear
		svmat t8, names(col)
		gen n = _n
		save "$output/temp/t8`iniyear'.dta", replace		
		
}
/*******************************************************************************
Sub Process Table 8.1 
*******************************************************************************/
if "`runtable8_1'"=="yes" {
	clear
	
	forval yyyy = `iniyear'/`finyear' {
		if `yyyy'==2005 use "$output/temp/t8`yyyy'.dta"
		else {
			merge 1:1 n using "$output/temp/t8`yyyy'.dta"
				drop _merge
			}
	}
	sort n
	drop n
	
	export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 8 raw") sheetmodify firstrow(variables)

}
/*******************************************************************************
Table 9.
*******************************************************************************/
if "`runtable9'"=="yes" {
	
	* This is a panel of workers.
	* It covers all workers with 5 interviews
	* It has been xtset with pid_d n_ent - and it is a strongly balanced panel
		* pid_d is a unique identifier of individuals in the panel
		* n_ent is the consecutive interview.
	
	local keepvars "pid_p n_ent psu strata weight attweight year quarter lstatus p3n p2d* tipo"
	
	forval yyyy = `iniyear'/`finyear' {
	forval q = `iniq'/`finq' {
		
		noi di "`yyyy' q`q'"

		local counter = (`yyyy'-2005)*4 + `q'	// 2

		local lcounter = `counter'-1
		if `q'> 1 & `q'<=4 local lq = `q'-1
		if `q'==1          local lq = 4
		
		local lyyyy = ((`lcounter'-`lq')/4)+2005
		
		noi di "From `lyyyy' q`lq' to `yyyy' q`q' - counter: `counter'"
		
		if `counter'>=2 & `counter'!=62 & `counter'!=63 {
		
			noi di `" use `keepvars' if ((year==`yyyy' & quarter==`q')|(year==`lyyyy' & quarter==`lq')) using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta", clear "'
			use `keepvars' if ((year==`yyyy' & quarter==`q')|(year==`lyyyy' & quarter==`lq')) using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta", clear
			
			drop if tipo=="2"
			
			sum p3n
			local nobs = r(N)
			if `nobs'>0 & `nobs'!= . {
					xtset
					sort pid_p n_ent
			
				* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1
				
				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2					
				
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
					drop p2d*
				
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1						
			
				* For those workers in the panel that were 
					* a) observed in Q1
					* a) unemployed in Q4 of last year
					gen byte multi_lstatus = . 
						replace multi_lstatus = 1 if l.lstatus==2 & lstatus==2   
						replace multi_lstatus = 2 if l.lstatus==1 & lstatus==2   
						replace multi_lstatus = 3 if l.lstatus==1 & lstatus==1   
						replace multi_lstatus = 4 if l.lstatus==2 & lstatus==1   
				
				* Internet categories
						gen internetcategory = .
							replace internetcategory = 1 if l.internetseeker==1 & internetfinder==1 & multi_lstatus==4
							replace internetcategory = 2 if l.internetseeker==1 & internetfinder==0 & multi_lstatus==4
							replace internetcategory = 3 if l.internetseeker==0 & internetfinder==1 & multi_lstatus==4
							replace internetcategory = 4 if l.internetseeker==0 & internetfinder==0 & multi_lstatus==4
						label define lblinternetcategory 1 "Seeker / Finder" 2 "Seeker / No-Finder" 3 "No-Seeker / Finder" 4 "No-Seeker / No-Finder"
							label values internetcategory lblinternetcategory
						
				* SVY Summary
					svyset psu [w=weight]
					estpost svy: tab multi_lstatus, level(95) proportion se ci nototal	
						matrix t9_A1_`yyyy'q`q' = e(b)'
						matrix t9_a1_`yyyy'q`q' = e(count)'
			
					estpost svy: tab internetcategory if multi_lstatus==4, level(95) proportion se ci nototal	
						matrix t9_B1_`yyyy'q`q' = e(b)'
						matrix t9_b1_`yyyy'q`q' = e(count)'

				* Assemble Matrix
						matrix t9_`yyyy'q`q' = [t9_a1_`yyyy'q`q' \ t9_A1_`yyyy'q`q' \ t9_b1_`yyyy'q`q' \ t9_B1_`yyyy'q`q' ]
			
		}
			if `nobs'==0 {
					#delimit ;
						matrix t9_`yyyy'q`q' = [. \ . \ . \ . \
												. \ . \ . \ . \
												. \ . \ . \ . \
												. \ . \ . \ . 
												];
					#delimit cr
			}
		}	
	}
	}

	local iniyear = 2009
	local finyear = 2023
	local iniq = 1
	local finq = 1
		local cycle = 1
		forval yyyy = `iniyear'/`finyear' {
		forval q = `iniq'/`finq' {
			
			local counter = (`yyyy'-2005)*4 + `q'
			if `counter'>=2 & `counter'!=62 & `counter'!=63 {
				if `cycle'==1 {
					local keepmatrix "t9_`yyyy'q`q'"
					local t9colnames `" "t9`yyyy'`q'" "'
				}
				if `cycle'> 1 {
					local keepmatrix "`keepmatrix' , t9_`yyyy'q`q'"
					local t9colnames `"  `t9colnames'   "t9`yyyy'`q'" "'
					}
				local cycle = `cycle'+1
			}
		}
		}

		matrix define   t9 = [`keepmatrix']
		matrix colnames t9 = `t9colnames'
				
		clear
		svmat t9, names(col)
		
		export excel using "$output/digital jobs in ENOE (2nd).xlsx", sheet("table 9 raw") sheetmodify firstrow(variables)

}

/*******************************************************************************
Table 10.
*******************************************************************************/
if "`runtable10'"=="yes" {

	* This is a panel of workers.
	* It covers all workers with 5 interviews
	* It has been xtset with pid_d n_ent - and it is a strongly balanced panel
		* pid_d is a unique identifier of individuals in the panel
		* n_ent is the consecutive interview.
	
	local keepvars "pid_p n_ent psu strata weight attweight male  age year quarter lstatus p3n p2d* educat7 educy informal industry_orig urban subnatid1"

	use `keepvars' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta", clear
	
				* Generate varibles for tabulation
				* Unemployed out of labor force
					gen byte unemployed = . 
					replace unemployed = 1 if lstatus==2
					replace unemployed = 0 if lstatus==1
				
				* Employed out of labor force
					gen byte employed = . 
					replace employed = 1 if lstatus==1
					replace employed = 0 if lstatus==2					
				
				* Internet search out of unemployed
					gen byte internetseeker = . 
					replace  internetseeker = 0 if           unemployed==1
					replace  internetseeker = 1 if p2d6==6 & unemployed==1
				
				* Type of Search
					gen otherseeker = .
					* Skip option 6 for internet search and omit option 99
					foreach i in 1 2 3 4 5 7 8 9 10 11 {
						replace otherseeker = 1 if p2d`i'==`i' & unemployed==1	// 
					}
					drop p2d*
				
				* Internet finder out of unemployed
					gen byte internetfinder = . 
					replace  internetfinder = 0 if          employed==1
					replace  internetfinder = 1 if p3n==6 & employed==1						
			
			
				* For those workers in the panel that were 
					* a) observed in Q1
					* a) unemployed in Q4 of last year
					gen byte multi_lstatus = . 
						replace multi_lstatus = 1 if l.lstatus==2 & lstatus==2   
						replace multi_lstatus = 2 if l.lstatus==1 & lstatus==2   
						replace multi_lstatus = 3 if l.lstatus==1 & lstatus==1   
						replace multi_lstatus = 4 if l.lstatus==2 & lstatus==1   
				
				* Internet categories
						gen internetcategory = .
							replace internetcategory = 1 if l.internetseeker==1 & internetfinder==1 & multi_lstatus==4
							replace internetcategory = 2 if l.internetseeker==1 & internetfinder==0 & multi_lstatus==4
							replace internetcategory = 3 if l.internetseeker==0 & internetfinder==1 & multi_lstatus==4
							replace internetcategory = 4 if l.internetseeker==0 & internetfinder==0 & multi_lstatus==4
						label define lblinternetcategory 1 "Seeker / Finder" 2 "Seeker / No-Finder" 3 "No-Seeker / Finder" 4 "No-Seeker / No-Finder"
							label values internetcategory lblinternetcategory
				* Age Group
					gen agegroup = .
					replace agegroup = 0 if age>=0  & age<=14
					replace agegroup = 1 if age>=15 & age<=29
					replace agegroup = 2 if age>=30 & age<=34
					replace agegroup = 3 if age>=45 & age<=59
					replace agegroup = 4 if age>=60 & age!=.
					label define lblagegroup 0 "0-14" 1 "15-29" 2 "30-34" 3 "45-59" 4 "60 and more"
					label values agegroup lblagegroup
				
				* Educational attainment, based on years of schooling and educat7
					gen schooling = .
					*replace schooling = 0 if educat7==1
					*replace schooling = 1 if educat7==2|educat7==3
					replace schooling = 1 if  educat7==1|educat7==2|educat7==3
					replace schooling = 2 if (educy>=7  & educy<=9)  & (educat7==4)
					replace schooling = 3 if (educy>=10 & educy<=12) & (educat7==4|educat7==5)
					replace schooling = 4 if (educy>=13 & educy<=17)
					replace schooling = 5 if (educy>=18 & educy!=.)
					
					#delimit ;
					label define lblschooling
					1 "a lo mas primaria completa" 2 "secundaria completa o incompleta" 3 "preparatoria completa o incompleta"
					4 "profesional completa o incompleta" 5 "postgrado completo o incompleto";
					#delimit cr
					label values schooling lblschooling
					
				* Informal
					replace informal = 1 if informal==3 & lstatus==1
					
				* Industries
					gen industry_orig2d = int(industry_orig/100)
						#delimit ;
						recode industry_orig2d (11 = 1)
											   (21 22 = 2)
											   (23 = 3)
											   (31/33 = 4)
											   (43 46 = 5)
											   (48 49 = 6)
											   (51 = 7)
											   (52 53 = 8)
											   (54 55 = 9)
											   (61 =10)
											   (62 =11)
											   (71 =12)
											   (72 =13)
											   (93 =14)
											   (97 98 99 81 56 =15)
												, gen(myind);
						#delimit cr
					
				* Modify internet category
					gen internet = .
						replace internet = 0 if internetseeker==0 | internetfinder==0
						replace internet = 1 if internetseeker==1 | internetfinder==1
				
			xtset
			sort pid_p n_ent
			
			* Dependent Variable (From unemployed to employed)
			gen depvar = .
				replace depvar = 0 if l.lstatus==2 & lstatus==2 & agegroup>0 & agegroup!=.
				replace depvar = 1 if l.lstatus==2 & lstatus==1 & agegroup>0 & agegroup!=.
			
			drop if depvar==.
			
			gen sample = .
			forval i = 1/20 {
				local m = 2008 + `i' - 1
				local n = 2008 + `i' 
				replace sample = `i' if (year==`m' & quarter==4)|(year==`n' & quarter==1)
			}
			
			label list lblsample 1 ""
			
			drop if sample==.
			
			logit depvar   ib0.internet ib0.male ib4.agegroup ib5.schooling ib0.urban i.subnatid1 if sample==1
			
			xtlogit depvar ib0.internet ib0.male ib4.agegroup ib5.schooling ib1.urban i.subnatid1 if sample==1 
			
			reghdfe depvar ib0.internet ib0.male ib4.agegroup ib5.schooling ib1.urban             if sample==1 , absorb(i.subnatid1)
			

			
			
			logit depvar   ib0.internet ib0.male ib4.agegroup ib5.schooling ib0.urban i.subnatid1 if sample==16
			
			xtlogit depvar ib0.internet ib0.male ib4.agegroup ib5.schooling ib1.urban i.subnatid1 if sample==16 
			
			reghdfe depvar              ib0.male ib4.agegroup ib5.schooling ib1.urban             if sample==12 , absorb(i.subnatid1)
			
			
		
}

