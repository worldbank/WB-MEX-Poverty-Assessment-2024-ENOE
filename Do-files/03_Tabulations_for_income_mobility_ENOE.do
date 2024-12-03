*v0.1	iosoriorodarte@worldbank.org 	Apr 26, 2024
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
scalar drop _all

*capture which estout 
*	if _rc ssc install estout

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
	local runtable1        "yes"
	
	local iniyear = 2005	
	local finyear = 2023	
	local iniq    = 1
	local finq	  = 4	
	local maxcycle = 76

* Options for paralllel processing (over years)
	local parallel 		""
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
RUN Table 1
*******************************************************************************/
if "`runtable1'"=="yes" {

	forval set = 1/9 {
	foreach time in 2009 2014 2018 2023 {

		if `set'==1 local oc = 4
		if `set'==2 local oc = 8
		if `set'==3 local oc = 12
		if `set'==4 local oc = 19
		if `set'==5 local oc = 34
		if `set'==6 local oc = 40
		if `set'==7 local oc = 59
		if `set'==8 local oc = 62
		if `set'==9 local oc = 66
		
		if `time'==2009 local op = "D"
		if `time'==2014 local op = "N"
		if `time'==2018 local op = "X"
		if `time'==2023 local op = "AH"
	
		local outputsheet	"t1"
		local outputcell 	"`op'`oc'"
	
	*set1: urban
	if `set'==1 {
		local myvar			"urban"
		local panelkeepvars "`myvar' age year quarter n_ent"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5"
		local crosskeepvars "`myvar' age year quarter"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1"
	}
	
	*set2: male
	if `set'==2 {
		local myvar			"male"
		local panelkeepvars "`myvar' age year quarter n_ent relationharm"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"	
		local crosskeepvars "`myvar' age year quarter relationharm"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}
	
	*set3: agehead
	if `set'==3 {
		local myvar			"agehead"
		local panelkeepvars "age year quarter n_ent relationharm"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}
	
	*set4: schooling
	if `set'==4 {
		local myvar			"schooling"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}	
	
	*set5: employment
	if `set'==5 {
		local myvar			"employment"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7 lstatus informal"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7 lstatus informal"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}	
	
	*set6: myind2
	if `set'==6 {
		local myvar			"myind2"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7 lstatus informal industry_orig"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7 lstatus informal industry_orig"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}
	
	*set7: tlaborincomepc
	if `set'==7 {
		local myvar			"tlaborincomepc"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm laborincome"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5"
		local crosskeepvars "age year quarter hhid hsize relationharm laborincome"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1"
	}
	
	*set8: famsize
	if `set'==8 {
		local myvar			"famsize"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm laborincome"
		local ifpanelconds 	"if age>=15 & age<=64 & year==2009 & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter hhid hsize relationharm laborincome"
		local ifcrossconds "if age>=15 & age<=64 & year==2009 & quarter==1 & relationharm==1"
	}	
		
	*set8: famtype
	if `set'==9 {
		local myvar			"famtype"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm"
		local ifpanelconds 	"if  year==2009 & quarter==1 & n_ent==5"
		local crosskeepvars "age year quarter       hhid hsize relationharm"
		local ifcrossconds  "if  year==2009 & quarter==1"
	}	

	
	* Panel
	if `set'!=9 use `panelkeepvars' `ifpanelconds' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta", clear
	if `set'==9 use `panelkeepvars' `ifpanelconds' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta",clear
		
		if `set'==3 {
			gen agehead = .
			replace agehead = 1 if age>=15 & age<=29
			replace agehead = 2 if age>=30 & age<=44
			replace agehead = 3 if age>=45 & age<=59
			replace agehead = 4 if age>=60 & age!=.
		}
		
		if `set'==4 {
			gen schooling = .
			*replace schooling = 0 if educat7==1
			*replace schooling = 1 if educat7==2|educat7==3
			replace schooling = 1 if  educat7==1|educat7==2|educat7==3
			replace schooling = 2 if (educy>=7  & educy<=9)  & (educat7==4)
			replace schooling = 3 if (educy>=10 & educy<=12) & (educat7==4|educat7==5)
			replace schooling = 4 if (educy>=13 & educy<=17)
			replace schooling = 5 if (educy>=18 & educy!=.)
		}

		if `set'==5 {
			replace informal = 1 if informal==3 & lstatus==1
			gen employment = .
			replace employment = 1 if lstatus==3
			replace employment = 2 if lstatus==2
			replace employment = 3 if lstatus==1 & informal==1
			replace employment = 4 if lstatus==1 & informal==0
		}
		
		if `set'==6 {
			replace industry_orig = 9999 if industry_orig==. & lstatus==1
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
			gen myind2 = .
			replace myind2 = myind+2
			replace myind2 = 1 if lstatus==3
			replace myind2 = 2 if lstatus==2
		}
		
		if `set'==7 {
			drop if hhid==""
			bys hhid: egen tlaborincome = sum(laborincome)
			gen double tlaborincomepc = tlaborincome/hsize
			keep if relationharm==1
		}
		
		if `set'==8 {
			drop if hhid==""
			drop if hsize==.
			gen famsize = .
			replace famsize = 1 if hsize>=0 & hsize<=4
			replace famsize = 2 if hsize>=5 & hsize!=.
		}
		
		if `set'==9 {
			drop if hhid == ""
			drop if hsize == .
			gen head 		= (relationharm==1)
			gen spouse 		= (relationharm==2)
			gen child   	= (relationharm==3)
			gen granpa  	= (relationharm==4)
			gen famother  	= (relationharm==5|relationharm==6)
			
			bys hhid: egen hashead     	= sum(head)
			bys hhid: egen hasspouse   	= sum(spouse)
			bys hhid: egen haschildren 	= sum(child)
			bys hhid: egen hasgranpa 	= sum(granpa)
			bys hhid: egen hasfamother 	= sum(famother)
			
			gen famtype = 7
				replace famtype = 1 if hsize==1 & hashead==1 // single person
				replace famtype = 2 if hsize==2 & hashead==1 & (hasspouse==1) & (haschildren==0) & (hasgranpa==0) & (hasfamother==0) // couple without children
				replace famtype = 3 if hsize>=3 & hsize<=5 & hashead==1 & (hasspouse==1) & (haschildren>=1 & haschildren<=3) & (hasgranpa==0) & (hasfamother==0) // couple with up to three children
				replace famtype = 4 if hsize>=6 & hsize!=. & hashead==1 & (hasspouse==1) & (haschildren>=4 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // couple with four children or more
				replace famtype = 5 if hsize>=2 & hsize!=. & hashead==1 & (hasspouse==0) & (haschildren>=1 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // single parent with children
				replace famtype = 6 if hsize>=2 & hsize!=. & hashead==1 & (haschildren>=1 & haschildren!=.) & (hasgranpa>=1 & hasgranpa!=.) & (hasfamother==0) // multi-generational family
			keep if relationharm==1
		}		
		
		if `set'!=7 tab `myvar', gen(_`myvar')
		if `set'==7 rename `myvar' _`myvar'
		local counter = 0
		foreach var of varlist _`myvar'* {
		sum `var'
			scalar p`var'_m = r(mean)
			scalar p`var'_v = r(Var)
			scalar p`var'_n = r(N)
			
			matrix p`var' = [p`var'_m , p`var'_v' , p`var'_n]
			
			if `counter' ==0 {
				local _mypmatrix = ""
				local _mypmatrix = "p`var'"
			}
			else             local _mypmatrix = "`_mypmatrix' \ p`var'"
			
			local counter = `counter'+1
		}
		
			matrix P_`myvar' = [`_mypmatrix']
	
	* Cross Section
	use `crosskeepvars' `ifcrossconds' using "$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta",clear
	
		if `set'==3 {
			gen agehead = .
			replace agehead = 1 if age>=15 & age<=29
			replace agehead = 2 if age>=30 & age<=44
			replace agehead = 3 if age>=45 & age<=59
			replace agehead = 4 if age>=60 & age!=.
		}

		if `set'==4 {
			gen schooling = .
			*replace schooling = 0 if educat7==1
			*replace schooling = 1 if educat7==2|educat7==3
			replace schooling = 1 if  educat7==1|educat7==2|educat7==3
			replace schooling = 2 if (educy>=7  & educy<=9)  & (educat7==4)
			replace schooling = 3 if (educy>=10 & educy<=12) & (educat7==4|educat7==5)
			replace schooling = 4 if (educy>=13 & educy<=17)
			replace schooling = 5 if (educy>=18 & educy!=.)
		}
		
		if `set'==5 {
			replace informal = 1 if informal==3 & lstatus==1
			gen employment = .
			replace employment = 1 if lstatus==3
			replace employment = 2 if lstatus==2
			replace employment = 3 if lstatus==1 & informal==1
			replace employment = 4 if lstatus==1 & informal==0
		}
		
		if `set'==6 {
			replace industry_orig = 9999 if industry_orig==. & lstatus==1
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
			gen myind2 = .
			replace myind2 = myind+2
			replace myind2 = 1 if lstatus==3
			replace myind2 = 2 if lstatus==2
		}

		if `set'==7 {
			drop if hhid==""
			bys hhid: egen tlaborincome = sum(laborincome)
			gen double tlaborincomepc = tlaborincome/hsize
			keep if relationharm==1
		}		
		
		if `set'==8 {
			drop if hhid==""
			drop if hsize==.
			gen famsize = .
			replace famsize = 1 if hsize>=0 & hsize<=4
			replace famsize = 2 if hsize>=5 & hsize!=.
		}
		
		if `set'==9 {
			drop if hhid == ""
			drop if hsize == .
			gen head 		= (relationharm==1)
			gen spouse 		= (relationharm==2)
			gen child   	= (relationharm==3)
			gen granpa  	= (relationharm==4)
			gen famother  	= (relationharm==5|relationharm==6)
			
			bys hhid: egen hashead     	= sum(head)
			bys hhid: egen hasspouse   	= sum(spouse)
			bys hhid: egen haschildren 	= sum(child)
			bys hhid: egen hasgranpa 	= sum(granpa)
			bys hhid: egen hasfamother 	= sum(famother)
			
			gen famtype = 7
				replace famtype = 1 if hsize==1 & hashead==1 // single person
				replace famtype = 2 if hsize==2 & hashead==1 & (hasspouse==1) & (haschildren==0) & (hasgranpa==0) & (hasfamother==0) // couple without children
				replace famtype = 3 if hsize>=3 & hsize<=5 & hashead==1 & (hasspouse==1) & (haschildren>=1 & haschildren<=3) & (hasgranpa==0) & (hasfamother==0) // couple with up to three children
				replace famtype = 4 if hsize>=6 & hsize!=. & hashead==1 & (hasspouse==1) & (haschildren>=4 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // couple with four children or more
				replace famtype = 5 if hsize>=2 & hsize!=. & hashead==1 & (hasspouse==0) & (haschildren>=1 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // single parent with children
				replace famtype = 6 if hsize>=2 & hsize!=. & hashead==1 & (haschildren>=1 & haschildren!=.) & (hasgranpa>=1 & hasgranpa!=.) & (hasfamother==0) // multi-generational family
			keep if relationharm==1
		}
		
		if `set'!=7 tab `myvar', gen(_`myvar')
		if `set'==7 rename `myvar' _`myvar'
		local counter = 0
		foreach var of varlist _`myvar'* {
		sum `var'
			scalar c`var'_m = r(mean)
			scalar c`var'_v = r(Var)
			scalar c`var'_n = r(N)
			
			matrix c`var' = [c`var'_m , c`var'_v' , c`var'_n]
			
			if `counter' ==0 {
				local _mycmatrix = ""
				local _mycmatrix = "c`var'"
			}
			else             local _mycmatrix = "`_mycmatrix' \ c`var'"
			
			local counter = `counter'+1
		}
	
			matrix C_`myvar' = [`_mycmatrix']
	
		matrix _`myvar' = [C_`myvar' , P_`myvar']
		
		putexcel set "$output/paneles para estudio movilidad de ingresos.xlsx", modify sheet("`outputsheet'")
		putexcel `outputcell' = matrix(_`myvar')
	}
	}
}
