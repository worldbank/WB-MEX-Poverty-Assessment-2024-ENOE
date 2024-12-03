*v0.1	iosoriorodarte@worldbank.org 	Apr 26, 2024
/*******************************************************************************
ENOE Surveys from 2005.Q1 to 2023.Q3 were harmonized using the World Bank 
Global Labor Database (GLD V06 template)
Visit: https://github.com/worldbank/gld

The ENOE surveys were assembled in a single file called: 
"$path/PANEL/DATA/MEX_2005_2023_ENOE_V01_M_V06_A_GLD_FULLSAMPLE.dta"
*******************************************************************************/

clear
frame reset
matrix drop _all
scalar drop _all

*capture which estout 
*	if _rc ssc install estout

* User 1: Israel Osorio Rodarte - MacOSX
	if (c(username)=="israel"|c(username)=="Israel") & (c(os)=="MacOSX"|c(os)=="Unix") {
		global path 	"/Users/`c(username)'/OneDrive/Data/GLD/MEX copy"
		global output   "$path/output"
	}

* User 1: Israel Osorio Rodarte - Windows
	if c(username)=="WB308767" {
		global path 	"C:/users/`c(username)'/OneDrive/Data/GLD/MEX copy"
		global output   "$path/output"
	}
	
	
clear

* Options for sequential processing 
	local runtable1        ""
	local runtable2        ""
	local runtable3        ""
	local runtable5        ""
	local runtable6        ""
	
	local iniyear = 2005	
	local finyear = 2023	
	local iniq    = 1
	local finq	  = 4	
	local maxcycle = 76

/*******************************************************************************
RUN Table 1
*******************************************************************************/
if "`runtable1'"=="yes" {

	forval set = 7/7 {
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
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"	
		local crosskeepvars "`myvar' age year quarter relationharm"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}
	
	*set3: agehead
	if `set'==3 {
		local myvar			"agehead"
		local panelkeepvars "age year quarter n_ent relationharm"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}
	
	*set4: schooling
	if `set'==4 {
		local myvar			"schooling"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}	
	
	*set5: employment
	if `set'==5 {
		local myvar			"employment"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7 lstatus informal"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7 lstatus informal"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}	
	
	*set6: myind2
	if `set'==6 {
		local myvar			"myind2"
		local panelkeepvars "age year quarter n_ent relationharm educy educat7 lstatus informal industry_orig"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter relationharm educy educat7 lstatus informal industry_orig"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}
	
	*set7: incomepc
	if `set'==7 {
		local myvar			"incomepc"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm laborincome mv ingreso tamh"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5"
		local crosskeepvars "age year quarter hhid hsize relationharm laborincome mv ingreso tamh"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1"
	}
	
	*set8: famsize
	if `set'==8 {
		local myvar			"famsize"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm laborincome"
		local ifpanelconds 	"if age>=15 & age<=64 & year==`time' & quarter==1 & n_ent==5 & relationharm==1"
		local crosskeepvars "age year quarter hhid hsize relationharm laborincome"
		local ifcrossconds "if age>=15 & age<=64 & year==`time' & quarter==1 & relationharm==1"
	}	
		
	*set9: famtype
	if `set'==9 {
		local myvar			"famtype"
		local panelkeepvars "age year quarter n_ent hhid hsize relationharm"
		local ifpanelconds 	"if  year==`time' & quarter==1 & n_ent==5"
		local crosskeepvars "age year quarter       hhid hsize relationharm"
		local ifcrossconds  "if  year==`time' & quarter==1"
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
			keep if mv==0
			gen double incomepc = ingreso/tamh
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
			keep if mv==0
			gen double incomepc = ingreso/tamh
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
/*******************************************************************************
RUN Table 2
*******************************************************************************/
if "`runtable2'"=="yes" {
di in red "Promedio trimestral de los valores de la  Línea de Pobreza Extrema por Ingresos - CONEVAL" 
#delimit ;
	scalar  uT105 	=	754.20	; 
	scalar  rT105 	=	556.78	; 
	scalar  uT205 	=	778.81	; 
	scalar  rT205 	=	581.33	; 
	scalar  uT305 	=	779.81	; 
	scalar  rT305 	=	579.00	; 
	scalar  uT405 	=	777.34	; 
	scalar  rT405 	=	574.19	; 

	scalar  uT106 	=	793.88	; 
	scalar  rT106 	=	589.73	; 
	scalar  uT206 	=	788.75	; 
	scalar  rT206 	=	583.12	; 
	scalar  uT306 	=	805.16	; 
	scalar  rT306 	=	599.09	; 
	scalar  uT406 	=	834.08	; 
	scalar  rT406 	=	629.22	; 

	scalar  uT107 	=	851.23	; 
	scalar  rT107 	=	641.50	; 
	scalar  uT207 	=	840.49	; 
	scalar  rT207 	=	629.76	; 
	scalar  uT307 	=	846.91	; 
	scalar  rT307 	=	634.21	; 
	scalar  uT407 	=	866.83	; 
	scalar  rT407 	=	650.59	; 

	scalar  uT108 	=	875.77	; 
	scalar  rT108 	=	655.79	; 
	scalar  uT208 	=	893.87	; 
	scalar  rT208 	=	671.92	; 
	scalar  uT308 	=	915.77	; 
	scalar  rT308 	=	689.23	; 
	scalar  uT408 	=	945.75	; 
	scalar  rT408 	=	715.18	; 

	scalar  uT109 	=	959.84	; 
	scalar  rT109 	=	724.50	; 
	scalar  uT209 	=	982.88	; 
	scalar  rT209 	=	747.36	; 
	scalar  uT309 	=	996.59	; 
	scalar  rT309 	=	758.12	; 
	scalar  uT409 	=	998.91	; 
	scalar  rT409 	=	759.10	; 

	scalar  uT110 	=	1026.57	; 
	scalar  rT110 	=	780.73	; 
	scalar  uT210 	=	1017.39	; 
	scalar  rT210 	=	769.93	; 
	scalar  uT310 	=	1008.45	; 
	scalar  rT310 	=	757.71  ; 
	scalar  uT410 	=	1032.81	; 
	scalar  rT410 	=	779.66	; 

	scalar  uT111 	=	1049.07	; 
	scalar  rT111 	=	791.31  ; 
	scalar  uT211 	=	1049.74	; 
	scalar  rT211 	=	793.00  ; 
	scalar  uT311 	=	1051.53	; 
	scalar  rT311 	=	794.21  ; 
	scalar  uT411 	=	1076.46	; 
	scalar  rT411 	=	817.32  ; 

	scalar  uT112 	=	1106.36	; 
	scalar  rT112 	=	843.60  ; 
	scalar  uT212 	=	1113.08	; 
	scalar  rT212 	=	847.74  ; 
	scalar  uT312 	=	1152.23	; 
	scalar  rT312 	=	884.25  ; 
	scalar  uT412 	=	1172.86	; 
	scalar  rT412 	=	901.01  ; 

	scalar  uT113 	=	1185.68	; 
	scalar  rT113 	=	908.25  ; 
	scalar  uT213 	=	1197.91	; 
	scalar  rT213 	=	918.90  ; 
	scalar  uT313 	=	1197.24	; 
	scalar  rT313 	=	913.56  ; 
	scalar  uT413 	=	1220.45	; 
	scalar  rT413 	=	934.09  ; 

	scalar  uT114 	=	1252.56	; 
	scalar  rT114 	=	952.71  ; 
	scalar  uT214 	=	1243.86	; 
	scalar  rT214 	=	939.94  ; 
	scalar  uT314 	=	1264.97	; 
	scalar  rT314 	=	954.15  ; 
	scalar  uT414 	=	1295.15	; 
	scalar  rT414 	=	982.12  ; 

	scalar  uT115 	=	1296.14	; 
	scalar  rT115 	=	981.50  ; 
	scalar  uT215 	=	1300.42	; 
	scalar  rT215 	=	985.56  ; 
	scalar  uT315 	=	1312.35	; 
	scalar  rT315 	=	992.04  ; 
	scalar  uT415 	=	1329.88	; 
	scalar  rT415 	=	1006.05	; 

	scalar  uT116 	=	1366.93	; 
	scalar  rT116 	=	1039.95	; 
	scalar  uT216 	=	1359.11	; 
	scalar  rT216 	=	1028.42	; 
	scalar  uT316 	=	1358.61	; 
	scalar  rT316 	=	1025.84	; 
	scalar  uT416 	=	1388.35	; 
	scalar  rT416 	=	1054.02	; 

	scalar  uT117 	=	1407.01	; 
	scalar  rT117 	=	1061.68	; 
	scalar  uT217 	=	1439.17	; 
	scalar  rT217 	=	1090.56	; 
	scalar  uT317 	=	1490.80	; 
	scalar  rT317 	=	1136.26	; 
	scalar  uT417 	=	1501.22	; 
	scalar  rT417 	=	1141.14	; 

	scalar  uT118 	=	1509.99	; 
	scalar  rT118 	=	1144.85	; 
	scalar  uT218 	=	1508.32	; 
	scalar  rT218 	=	1139.69	; 
	scalar  uT318 	=	1537.71	; 
	scalar  rT318 	=	1159.55	; 
	scalar  uT418 	=	1564.27	; 
	scalar  rT418 	=	1186.53	; 

	scalar  uT119 	=	1594.81	; 
	scalar  rT119 	=	1209.52	; 
	scalar  uT219 	=	1597.63	; 
	scalar  rT219 	=	1209.34	; 
	scalar  uT319 	=	1604.31	; 
	scalar  rT319 	=	1212.42	; 
	scalar  uT419 	=	1619.78	; 
	scalar  rT419 	=	1225.79	; 

	scalar  uT120 	=	1664.71	; 
	scalar  rT120 	=	1266.14	; 
	scalar  uT320 	=	1701.39	; 
	scalar  rT320 	=	1298.60	; 
	scalar  uT420 	=	1719.75	; 
	scalar  rT420 	=	1313.92	; 

	scalar  uT121 	=	1732.14	; 
	scalar  rT121 	=	1317.79	; 
	scalar  uT221 	=	1777.32	; 
	scalar  rT221 	=	1358.60	; 
	scalar  uT321 	=	1828.63	; 
	scalar  rT321 	=	1400.08	; 
	scalar  uT421 	=	1877.13	; 
	scalar  rT421 	=	1443.29	; 

	scalar  uT122	=	1951.74 ; 
	scalar  rT122 	=	1498.46	; 
	scalar  uT222	=	1990.99 ; 
	scalar  rT222 	=	1530.41	; 
	scalar  uT322	=	2081.04 ; 
	scalar  rT322 	=	1597.57	;
	scalar  uT422	=	2115.73 ; 
	scalar  rT422 	=	1625.32	;

	scalar  uT123	=	2154.34 ; 
	scalar  rT123 	=	1651.91 ; 
	scalar  uT223	=	2176.94 ; 
	scalar  rT223 	=	1665.47 ; 	
	scalar  uT323	=	2218.76 ; 
	scalar  rT323 	=	1697.79 ;
	scalar  uT423	=	2239.99 ; 
	scalar  rT423 	=	1716.25	;
#delimit cr

	* No hay valores para el segundo trimestre de 2020
	scalar  uT220	= .
	scalar  rT220	= .

* Crear tabla
	set obs 100

	gen year = .
	gen quarter = .
	gen lpU = .
	gen lpR = .

	local i = 1
	forval y=5/23 {
	forval q=1/4  {
		
		replace year = `y'+2000 if _n==`i'
		replace quarter = `q'	if _n==`i'
		
		if `y'<9 local yy = "0`y'"
		if `y'>9 local yy = "`y'"
		
		replace lpU = uT`q'`yy' if _n==`i'
		replace lpR = rT`q'`yy' if _n==`i'
		
		local i = `i'+1

	} 
	}

	drop if year==.
	tempfile lp
	save `lp', replace

* Importar PPPs de WDI
	* PA.NUS.PPP: PPP conversion factor, GDP (LCU per international $)
	* https://data.worldbank.org/indicator/PA.NUS.PPP?locations=MX
	wbopendata, indicator(FP.CPI.TOTL ; PA.NUS.PPP) country("MEX") long clear
	keep year pa_nus_ppp fp_cpi_totl
	keep if year>=2005 & year<=2023
		sum fp_cpi_totl if year==2017
		scalar cpi2017 = r(mean)
	gen double fp_cpi_totl_2017  = fp_cpi_totl/cpi2017
		drop fp_cpi_totl
	replace fp_cpi_totl = fp_cpi_totl[_n-1] * 1.0553 if year==2023
	replace pa_nus_ppp  = pa_nus_ppp[_n-1] * (17.7323/20.13)*(1.041/1.0553) if year==2023

	
	* Combinar bases de datos y ordenar
	merge 1:m year using `lp'
	drop _merge
	order year quarter lpR lpU
	sort  year quarter

	* Linea de pobreza LCU diaria
	gen double lpR_LCU_daily = (lpR*12/365)
	gen double lpU_LCU_daily = (lpU*12/365)
	
	* Linea de pobreza diaria en PPP (international $) - Usando CPI
	gen double lpR_PPP_daily_cpi = (lpR_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017
	gen double lpU_PPP_daily_cpi = (lpU_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017

	* Linea de pobreza diaria en PPP (international $) - Usando Nivel de Precios de ENOE
	
	sum lpR if year==2017
		scalar pR2017 = r(mean)
	sum lpU if year==2017
		scalar pU2017 = r(mean)

	gen double epi_R_2017 = lpR/pR2017
	gen double epi_U_2017 = lpU/pU2017
	label var epi_R_2017 "CONEVAL Rural Price Index derived from Povery Line"
	label var epi_U_2017 "CONEVAL Urban Price Index derived from Povery Line"
	
	gen double lpR_PPP_daily_epi = (lpR_LCU_daily / pa_nus_ppp)/epi_R_2017
	gen double lpU_PPP_daily_epi = (lpU_LCU_daily / pa_nus_ppp)/epi_U_2017
	

	order year quarter lpR lpU lpR_LCU_daily lpU_LCU_daily  pa_nus_ppp fp_cpi_totl_2017 lpR_PPP_daily_cpi lpU_PPP_daily_cpi epi_R_2017 epi_U_2017 lpR_PPP_daily_epi lpU_PPP_daily_epi
	
	gen double lp_0685LCU_1 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017      // Urban
	gen double lp_0685LCU_0 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017	*.85 // Rural
	
	*gen double lpR_0685LCU = 6.85 * pa_nus_ppp * epi_R_2017
	*gen double lpU_0685LCU = 6.85 * pa_nus_ppp * epi_U_2017
	
	keep year quarter lp_0685LCU_*
	reshape long lp_0685LCU_ , i(year quarter) j(urban)
	
	rename lp_0685LCU_ lpT2 
	tempfile pl
	save `pl', replace
	
	local vars "hhid n_ent year quarter pid pid_p panel hsize relationharm male ingreso mv tamh pob lpT urban"
	local ifuse "if year>=2005 & year!=. & hhid!="" & relationharm==1 & mv==0"
	
	use `vars' `ifuse' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta",clear
	
	merge m:1 year quarter urban using `pl'
	drop if _merge==2
	drop _merge	
	
	gen pob2 = cond((ingreso/tamh)<lpT2,1,0)
	
	isid pid_p n_ent
	bys pid_p: gen N = _N
	keep if N==5
	drop N
	keep if (n_ent==1 & quarter==4)|(n_ent==5 & quarter==4)
	
	replace n_ent = 2 if n_ent==5	// To use lags
	tsset

	preserve 

		keep pid_p n_ent year quarter pob tamh
		
		gen sliders	  = (pob==0 & f.pob==1) 
		gen stayer    = (pob==1 & f.pob==1)
		gen climber   = (pob==1 & f.pob==0)
		gen neverpoor = (pob==0 & f.pob==0)
		
		collapse (mean) slider stayer climber neverpoor if n_ent==1 [fw=tamh], by(year quarter)
		drop quarter
		export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("t2") cell(D4)

	restore

	preserve
		keep pid_p n_ent year quarter pob2 tamh 
		
		gen sliders	  = (pob2==0 & f.pob2==1) 
		gen stayer    = (pob2==1 & f.pob2==1)
		gen climber   = (pob2==1 & f.pob2==0)
		gen neverpoor = (pob2==0 & f.pob2==0)
		
		collapse (mean) slider stayer climber neverpoor if n_ent==1 [fw=tamh], by(year quarter)
		drop quarter
		export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("t2ppp") cell(D4)
	
	restore	
	
}

/*******************************************************************************
RUN Table 3
*******************************************************************************/
if "`runtable3'"=="yes" {
	
di in red "Promedio trimestral de los valores de la  Línea de Pobreza Extrema por Ingresos - CONEVAL" 
#delimit ;
	scalar  uT105 	=	754.20	; 
	scalar  rT105 	=	556.78	; 
	scalar  uT205 	=	778.81	; 
	scalar  rT205 	=	581.33	; 
	scalar  uT305 	=	779.81	; 
	scalar  rT305 	=	579.00	; 
	scalar  uT405 	=	777.34	; 
	scalar  rT405 	=	574.19	; 

	scalar  uT106 	=	793.88	; 
	scalar  rT106 	=	589.73	; 
	scalar  uT206 	=	788.75	; 
	scalar  rT206 	=	583.12	; 
	scalar  uT306 	=	805.16	; 
	scalar  rT306 	=	599.09	; 
	scalar  uT406 	=	834.08	; 
	scalar  rT406 	=	629.22	; 

	scalar  uT107 	=	851.23	; 
	scalar  rT107 	=	641.50	; 
	scalar  uT207 	=	840.49	; 
	scalar  rT207 	=	629.76	; 
	scalar  uT307 	=	846.91	; 
	scalar  rT307 	=	634.21	; 
	scalar  uT407 	=	866.83	; 
	scalar  rT407 	=	650.59	; 

	scalar  uT108 	=	875.77	; 
	scalar  rT108 	=	655.79	; 
	scalar  uT208 	=	893.87	; 
	scalar  rT208 	=	671.92	; 
	scalar  uT308 	=	915.77	; 
	scalar  rT308 	=	689.23	; 
	scalar  uT408 	=	945.75	; 
	scalar  rT408 	=	715.18	; 

	scalar  uT109 	=	959.84	; 
	scalar  rT109 	=	724.50	; 
	scalar  uT209 	=	982.88	; 
	scalar  rT209 	=	747.36	; 
	scalar  uT309 	=	996.59	; 
	scalar  rT309 	=	758.12	; 
	scalar  uT409 	=	998.91	; 
	scalar  rT409 	=	759.10	; 

	scalar  uT110 	=	1026.57	; 
	scalar  rT110 	=	780.73	; 
	scalar  uT210 	=	1017.39	; 
	scalar  rT210 	=	769.93	; 
	scalar  uT310 	=	1008.45	; 
	scalar  rT310 	=	757.71  ; 
	scalar  uT410 	=	1032.81	; 
	scalar  rT410 	=	779.66	; 

	scalar  uT111 	=	1049.07	; 
	scalar  rT111 	=	791.31  ; 
	scalar  uT211 	=	1049.74	; 
	scalar  rT211 	=	793.00  ; 
	scalar  uT311 	=	1051.53	; 
	scalar  rT311 	=	794.21  ; 
	scalar  uT411 	=	1076.46	; 
	scalar  rT411 	=	817.32  ; 

	scalar  uT112 	=	1106.36	; 
	scalar  rT112 	=	843.60  ; 
	scalar  uT212 	=	1113.08	; 
	scalar  rT212 	=	847.74  ; 
	scalar  uT312 	=	1152.23	; 
	scalar  rT312 	=	884.25  ; 
	scalar  uT412 	=	1172.86	; 
	scalar  rT412 	=	901.01  ; 

	scalar  uT113 	=	1185.68	; 
	scalar  rT113 	=	908.25  ; 
	scalar  uT213 	=	1197.91	; 
	scalar  rT213 	=	918.90  ; 
	scalar  uT313 	=	1197.24	; 
	scalar  rT313 	=	913.56  ; 
	scalar  uT413 	=	1220.45	; 
	scalar  rT413 	=	934.09  ; 

	scalar  uT114 	=	1252.56	; 
	scalar  rT114 	=	952.71  ; 
	scalar  uT214 	=	1243.86	; 
	scalar  rT214 	=	939.94  ; 
	scalar  uT314 	=	1264.97	; 
	scalar  rT314 	=	954.15  ; 
	scalar  uT414 	=	1295.15	; 
	scalar  rT414 	=	982.12  ; 

	scalar  uT115 	=	1296.14	; 
	scalar  rT115 	=	981.50  ; 
	scalar  uT215 	=	1300.42	; 
	scalar  rT215 	=	985.56  ; 
	scalar  uT315 	=	1312.35	; 
	scalar  rT315 	=	992.04  ; 
	scalar  uT415 	=	1329.88	; 
	scalar  rT415 	=	1006.05	; 

	scalar  uT116 	=	1366.93	; 
	scalar  rT116 	=	1039.95	; 
	scalar  uT216 	=	1359.11	; 
	scalar  rT216 	=	1028.42	; 
	scalar  uT316 	=	1358.61	; 
	scalar  rT316 	=	1025.84	; 
	scalar  uT416 	=	1388.35	; 
	scalar  rT416 	=	1054.02	; 

	scalar  uT117 	=	1407.01	; 
	scalar  rT117 	=	1061.68	; 
	scalar  uT217 	=	1439.17	; 
	scalar  rT217 	=	1090.56	; 
	scalar  uT317 	=	1490.80	; 
	scalar  rT317 	=	1136.26	; 
	scalar  uT417 	=	1501.22	; 
	scalar  rT417 	=	1141.14	; 

	scalar  uT118 	=	1509.99	; 
	scalar  rT118 	=	1144.85	; 
	scalar  uT218 	=	1508.32	; 
	scalar  rT218 	=	1139.69	; 
	scalar  uT318 	=	1537.71	; 
	scalar  rT318 	=	1159.55	; 
	scalar  uT418 	=	1564.27	; 
	scalar  rT418 	=	1186.53	; 

	scalar  uT119 	=	1594.81	; 
	scalar  rT119 	=	1209.52	; 
	scalar  uT219 	=	1597.63	; 
	scalar  rT219 	=	1209.34	; 
	scalar  uT319 	=	1604.31	; 
	scalar  rT319 	=	1212.42	; 
	scalar  uT419 	=	1619.78	; 
	scalar  rT419 	=	1225.79	; 

	scalar  uT120 	=	1664.71	; 
	scalar  rT120 	=	1266.14	; 
	scalar  uT320 	=	1701.39	; 
	scalar  rT320 	=	1298.60	; 
	scalar  uT420 	=	1719.75	; 
	scalar  rT420 	=	1313.92	; 

	scalar  uT121 	=	1732.14	; 
	scalar  rT121 	=	1317.79	; 
	scalar  uT221 	=	1777.32	; 
	scalar  rT221 	=	1358.60	; 
	scalar  uT321 	=	1828.63	; 
	scalar  rT321 	=	1400.08	; 
	scalar  uT421 	=	1877.13	; 
	scalar  rT421 	=	1443.29	; 

	scalar  uT122	=	1951.74 ; 
	scalar  rT122 	=	1498.46	; 
	scalar  uT222	=	1990.99 ; 
	scalar  rT222 	=	1530.41	; 
	scalar  uT322	=	2081.04 ; 
	scalar  rT322 	=	1597.57	;
	scalar  uT422	=	2115.73 ; 
	scalar  rT422 	=	1625.32	;

	scalar  uT123	=	2154.34 ; 
	scalar  rT123 	=	1651.91 ; 
	scalar  uT223	=	2176.94 ; 
	scalar  rT223 	=	1665.47 ; 	
	scalar  uT323	=	2218.76 ; 
	scalar  rT323 	=	1697.79 ;
	scalar  uT423	=	2239.99 ; 
	scalar  rT423 	=	1716.25	;
#delimit cr

	* No hay valores para el segundo trimestre de 2020
	scalar  uT220	= .
	scalar  rT220	= .

* Crear tabla
	set obs 100

	gen year = .
	gen quarter = .
	gen lpU = .
	gen lpR = .

	local i = 1
	forval y=5/23 {
	forval q=1/4  {
		
		replace year = `y'+2000 if _n==`i'
		replace quarter = `q'	if _n==`i'
		
		if `y'<9 local yy = "0`y'"
		if `y'>9 local yy = "`y'"
		
		replace lpU = uT`q'`yy' if _n==`i'
		replace lpR = rT`q'`yy' if _n==`i'
		
		local i = `i'+1

	} 
	}

	drop if year==.
	tempfile lp
	save `lp', replace

* Importar PPPs de WDI
	* PA.NUS.PPP: PPP conversion factor, GDP (LCU per international $)
	* https://data.worldbank.org/indicator/PA.NUS.PPP?locations=MX
	wbopendata, indicator(FP.CPI.TOTL ; PA.NUS.PPP) country("MEX") long clear
	keep year pa_nus_ppp fp_cpi_totl
	keep if year>=2005 & year<=2023
		sum fp_cpi_totl if year==2017
		scalar cpi2017 = r(mean)
	gen double fp_cpi_totl_2017  = fp_cpi_totl/cpi2017
		drop fp_cpi_totl
	replace fp_cpi_totl = fp_cpi_totl[_n-1] * 1.0553 if year==2023
	replace pa_nus_ppp  = pa_nus_ppp[_n-1] * (17.7323/20.13)*(1.041/1.0553) if year==2023

	
	* Combinar bases de datos y ordenar
	merge 1:m year using `lp'
	drop _merge
	order year quarter lpR lpU
	sort  year quarter

	* Linea de pobreza LCU diaria
	gen double lpR_LCU_daily = (lpR*12/365)
	gen double lpU_LCU_daily = (lpU*12/365)
	
	* Linea de pobreza diaria en PPP (international $) - Usando CPI
	gen double lpR_PPP_daily_cpi = (lpR_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017
	gen double lpU_PPP_daily_cpi = (lpU_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017

	* Linea de pobreza diaria en PPP (international $) - Usando Nivel de Precios de ENOE
	
	sum lpR if year==2017
		scalar pR2017 = r(mean)
	sum lpU if year==2017
		scalar pU2017 = r(mean)

	gen double epi_R_2017 = lpR/pR2017
	gen double epi_U_2017 = lpU/pU2017
	label var epi_R_2017 "CONEVAL Rural Price Index derived from Povery Line"
	label var epi_U_2017 "CONEVAL Urban Price Index derived from Povery Line"
	
	gen double lpR_PPP_daily_epi = (lpR_LCU_daily / pa_nus_ppp)/epi_R_2017
	gen double lpU_PPP_daily_epi = (lpU_LCU_daily / pa_nus_ppp)/epi_U_2017
	

	order year quarter lpR lpU lpR_LCU_daily lpU_LCU_daily  pa_nus_ppp fp_cpi_totl_2017 lpR_PPP_daily_cpi lpU_PPP_daily_cpi epi_R_2017 epi_U_2017 lpR_PPP_daily_epi lpU_PPP_daily_epi
	
	gen double lp_0685LCU_1 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017      // Urban
	gen double lp_0685LCU_0 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017	*.85 // Rural
	
	*gen double lpR_0685LCU = 6.85 * pa_nus_ppp * epi_R_2017
	*gen double lpU_0685LCU = 6.85 * pa_nus_ppp * epi_U_2017
	
	keep year quarter lp_0685LCU_*
	reshape long lp_0685LCU_ , i(year quarter) j(urban)
	
	rename lp_0685LCU_ lpT2 
	tempfile pl
	save `pl', replace
	
	local vars "hhid n_ent year quarter pid pid_p panel hsize relationharm male ingreso mv tamh pob lpT urb"
	local ifuse "if year>=2005 & year!=. & hhid!="" & relationharm==1 & mv==0"
	
	use `vars' `ifuse' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta",clear
	
	
	merge m:1 year quarter urban using `pl'
	drop if _merge==2
	drop _merge
	
	gen pob2 = cond((ingreso/tamh)<lpT2,1,0)
	
	isid pid_p n_ent
	bys pid_p: gen N = _N
	keep if N==5
	drop N
	keep if (n_ent==1 & quarter==4)|(n_ent==2 & quarter==1)|(n_ent==3 & quarter==2)|(n_ent==4 & quarter==3)|(n_ent==5 & quarter==4)
	
	*replace n_ent = 2 if n_ent==5	// To use lags
	tsset

	preserve 
		
		sort pid_p n_ent
		bys  pid_p: egen Npob = sum(pob)
		tab Npob, gen(_Npob)
		
		collapse (mean) _Npob* if n_ent==1 [fw=tamh], by(year quarter)
		drop quarter
		export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("t3") cell(D4)

	restore

	preserve
	
		sort pid_p n_ent
		bys  pid_p: egen Npob = sum(pob2)
		tab Npob, gen(_Npob)
		
		collapse (mean) _Npob* if n_ent==1 [fw=tamh], by(year quarter)
		drop quarter
		export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("t3ppp") cell(D4)
	
	restore
	
	
	tab urb if panel==36 
	
	
}

/*******************************************************************************
RUN Table 5
*******************************************************************************/
if "`runtable5'"=="yes" {
di in red "Promedio trimestral de los valores de la  Línea de Pobreza Extrema por Ingresos - CONEVAL" 
#delimit ;
	scalar  uT105 	=	754.20	; 
	scalar  rT105 	=	556.78	; 
	scalar  uT205 	=	778.81	; 
	scalar  rT205 	=	581.33	; 
	scalar  uT305 	=	779.81	; 
	scalar  rT305 	=	579.00	; 
	scalar  uT405 	=	777.34	; 
	scalar  rT405 	=	574.19	; 

	scalar  uT106 	=	793.88	; 
	scalar  rT106 	=	589.73	; 
	scalar  uT206 	=	788.75	; 
	scalar  rT206 	=	583.12	; 
	scalar  uT306 	=	805.16	; 
	scalar  rT306 	=	599.09	; 
	scalar  uT406 	=	834.08	; 
	scalar  rT406 	=	629.22	; 

	scalar  uT107 	=	851.23	; 
	scalar  rT107 	=	641.50	; 
	scalar  uT207 	=	840.49	; 
	scalar  rT207 	=	629.76	; 
	scalar  uT307 	=	846.91	; 
	scalar  rT307 	=	634.21	; 
	scalar  uT407 	=	866.83	; 
	scalar  rT407 	=	650.59	; 

	scalar  uT108 	=	875.77	; 
	scalar  rT108 	=	655.79	; 
	scalar  uT208 	=	893.87	; 
	scalar  rT208 	=	671.92	; 
	scalar  uT308 	=	915.77	; 
	scalar  rT308 	=	689.23	; 
	scalar  uT408 	=	945.75	; 
	scalar  rT408 	=	715.18	; 

	scalar  uT109 	=	959.84	; 
	scalar  rT109 	=	724.50	; 
	scalar  uT209 	=	982.88	; 
	scalar  rT209 	=	747.36	; 
	scalar  uT309 	=	996.59	; 
	scalar  rT309 	=	758.12	; 
	scalar  uT409 	=	998.91	; 
	scalar  rT409 	=	759.10	; 

	scalar  uT110 	=	1026.57	; 
	scalar  rT110 	=	780.73	; 
	scalar  uT210 	=	1017.39	; 
	scalar  rT210 	=	769.93	; 
	scalar  uT310 	=	1008.45	; 
	scalar  rT310 	=	757.71  ; 
	scalar  uT410 	=	1032.81	; 
	scalar  rT410 	=	779.66	; 

	scalar  uT111 	=	1049.07	; 
	scalar  rT111 	=	791.31  ; 
	scalar  uT211 	=	1049.74	; 
	scalar  rT211 	=	793.00  ; 
	scalar  uT311 	=	1051.53	; 
	scalar  rT311 	=	794.21  ; 
	scalar  uT411 	=	1076.46	; 
	scalar  rT411 	=	817.32  ; 

	scalar  uT112 	=	1106.36	; 
	scalar  rT112 	=	843.60  ; 
	scalar  uT212 	=	1113.08	; 
	scalar  rT212 	=	847.74  ; 
	scalar  uT312 	=	1152.23	; 
	scalar  rT312 	=	884.25  ; 
	scalar  uT412 	=	1172.86	; 
	scalar  rT412 	=	901.01  ; 

	scalar  uT113 	=	1185.68	; 
	scalar  rT113 	=	908.25  ; 
	scalar  uT213 	=	1197.91	; 
	scalar  rT213 	=	918.90  ; 
	scalar  uT313 	=	1197.24	; 
	scalar  rT313 	=	913.56  ; 
	scalar  uT413 	=	1220.45	; 
	scalar  rT413 	=	934.09  ; 

	scalar  uT114 	=	1252.56	; 
	scalar  rT114 	=	952.71  ; 
	scalar  uT214 	=	1243.86	; 
	scalar  rT214 	=	939.94  ; 
	scalar  uT314 	=	1264.97	; 
	scalar  rT314 	=	954.15  ; 
	scalar  uT414 	=	1295.15	; 
	scalar  rT414 	=	982.12  ; 

	scalar  uT115 	=	1296.14	; 
	scalar  rT115 	=	981.50  ; 
	scalar  uT215 	=	1300.42	; 
	scalar  rT215 	=	985.56  ; 
	scalar  uT315 	=	1312.35	; 
	scalar  rT315 	=	992.04  ; 
	scalar  uT415 	=	1329.88	; 
	scalar  rT415 	=	1006.05	; 

	scalar  uT116 	=	1366.93	; 
	scalar  rT116 	=	1039.95	; 
	scalar  uT216 	=	1359.11	; 
	scalar  rT216 	=	1028.42	; 
	scalar  uT316 	=	1358.61	; 
	scalar  rT316 	=	1025.84	; 
	scalar  uT416 	=	1388.35	; 
	scalar  rT416 	=	1054.02	; 

	scalar  uT117 	=	1407.01	; 
	scalar  rT117 	=	1061.68	; 
	scalar  uT217 	=	1439.17	; 
	scalar  rT217 	=	1090.56	; 
	scalar  uT317 	=	1490.80	; 
	scalar  rT317 	=	1136.26	; 
	scalar  uT417 	=	1501.22	; 
	scalar  rT417 	=	1141.14	; 

	scalar  uT118 	=	1509.99	; 
	scalar  rT118 	=	1144.85	; 
	scalar  uT218 	=	1508.32	; 
	scalar  rT218 	=	1139.69	; 
	scalar  uT318 	=	1537.71	; 
	scalar  rT318 	=	1159.55	; 
	scalar  uT418 	=	1564.27	; 
	scalar  rT418 	=	1186.53	; 

	scalar  uT119 	=	1594.81	; 
	scalar  rT119 	=	1209.52	; 
	scalar  uT219 	=	1597.63	; 
	scalar  rT219 	=	1209.34	; 
	scalar  uT319 	=	1604.31	; 
	scalar  rT319 	=	1212.42	; 
	scalar  uT419 	=	1619.78	; 
	scalar  rT419 	=	1225.79	; 

	scalar  uT120 	=	1664.71	; 
	scalar  rT120 	=	1266.14	; 
	scalar  uT320 	=	1701.39	; 
	scalar  rT320 	=	1298.60	; 
	scalar  uT420 	=	1719.75	; 
	scalar  rT420 	=	1313.92	; 

	scalar  uT121 	=	1732.14	; 
	scalar  rT121 	=	1317.79	; 
	scalar  uT221 	=	1777.32	; 
	scalar  rT221 	=	1358.60	; 
	scalar  uT321 	=	1828.63	; 
	scalar  rT321 	=	1400.08	; 
	scalar  uT421 	=	1877.13	; 
	scalar  rT421 	=	1443.29	; 

	scalar  uT122	=	1951.74 ; 
	scalar  rT122 	=	1498.46	; 
	scalar  uT222	=	1990.99 ; 
	scalar  rT222 	=	1530.41	; 
	scalar  uT322	=	2081.04 ; 
	scalar  rT322 	=	1597.57	;
	scalar  uT422	=	2115.73 ; 
	scalar  rT422 	=	1625.32	;

	scalar  uT123	=	2154.34 ; 
	scalar  rT123 	=	1651.91 ; 
	scalar  uT223	=	2176.94 ; 
	scalar  rT223 	=	1665.47 ; 	
	scalar  uT323	=	2218.76 ; 
	scalar  rT323 	=	1697.79 ;
	scalar  uT423	=	2239.99 ; 
	scalar  rT423 	=	1716.25	;
#delimit cr

	* No hay valores para el segundo trimestre de 2020
	scalar  uT220	= .
	scalar  rT220	= .

* Crear tabla
	set obs 100

	gen year = .
	gen quarter = .
	gen lpU = .
	gen lpR = .

	local i = 1
	forval y=5/23 {
	forval q=1/4  {
		
		replace year = `y'+2000 if _n==`i'
		replace quarter = `q'	if _n==`i'
		
		if `y'<9 local yy = "0`y'"
		if `y'>9 local yy = "`y'"
		
		replace lpU = uT`q'`yy' if _n==`i'
		replace lpR = rT`q'`yy' if _n==`i'
		
		local i = `i'+1

	} 
	}

	drop if year==.
	tempfile lp
	save `lp', replace

* Importar PPPs de WDI
	* PA.NUS.PPP: PPP conversion factor, GDP (LCU per international $)
	* https://data.worldbank.org/indicator/PA.NUS.PPP?locations=MX
	wbopendata, indicator(FP.CPI.TOTL ; PA.NUS.PPP) country("MEX") long clear
	keep year pa_nus_ppp fp_cpi_totl
	keep if year>=2005 & year<=2023
		sum fp_cpi_totl if year==2017
		scalar cpi2017 = r(mean)
	gen double fp_cpi_totl_2017  = fp_cpi_totl/cpi2017
		drop fp_cpi_totl
	replace fp_cpi_totl = fp_cpi_totl[_n-1] * 1.0553 if year==2023
	replace pa_nus_ppp  = pa_nus_ppp[_n-1] * (17.7323/20.13)*(1.041/1.0553) if year==2023

	
	* Combinar bases de datos y ordenar
	merge 1:m year using `lp'
	drop _merge
	order year quarter lpR lpU
	sort  year quarter

	* Linea de pobreza LCU diaria
	gen double lpR_LCU_daily = (lpR*12/365)
	gen double lpU_LCU_daily = (lpU*12/365)
	
	* Linea de pobreza diaria en PPP (international $) - Usando CPI
	gen double lpR_PPP_daily_cpi = (lpR_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017
	gen double lpU_PPP_daily_cpi = (lpU_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017

	* Linea de pobreza diaria en PPP (international $) - Usando Nivel de Precios de ENOE
	
	sum lpR if year==2017
		scalar pR2017 = r(mean)
	sum lpU if year==2017
		scalar pU2017 = r(mean)

	gen double epi_R_2017 = lpR/pR2017
	gen double epi_U_2017 = lpU/pU2017
	label var epi_R_2017 "CONEVAL Rural Price Index derived from Povery Line"
	label var epi_U_2017 "CONEVAL Urban Price Index derived from Povery Line"
	
	gen double lpR_PPP_daily_epi = (lpR_LCU_daily / pa_nus_ppp)/epi_R_2017
	gen double lpU_PPP_daily_epi = (lpU_LCU_daily / pa_nus_ppp)/epi_U_2017
	

	order year quarter lpR lpU lpR_LCU_daily lpU_LCU_daily  pa_nus_ppp fp_cpi_totl_2017 lpR_PPP_daily_cpi lpU_PPP_daily_cpi epi_R_2017 epi_U_2017 lpR_PPP_daily_epi lpU_PPP_daily_epi
	
	gen double lp_0685LCU_1 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017      // Urban
	gen double lp_0685LCU_0 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017	*.85 // Rural
	
	*gen double lpR_0685LCU = 6.85 * pa_nus_ppp * epi_R_2017
	*gen double lpU_0685LCU = 6.85 * pa_nus_ppp * epi_U_2017
	
	keep year quarter lp_0685LCU_*
	reshape long lp_0685LCU_ , i(year quarter) j(urban)
	
	rename lp_0685LCU_ lpT2 
	tempfile pl
	save `pl', replace
	
	forval set = 1/9 {
	foreach panel in 36 72 {
	foreach monetaryunit in lcu ppp {
		
		if `set'==1 local oc = 6
		if `set'==2 local oc = 10
		if `set'==3 local oc = 14
		if `set'==4 local oc = 21
		if `set'==5 local oc = 36
		if `set'==6 local oc = 42
		if `set'==7 local oc = 61
		if `set'==8 local oc = 64
		if `set'==9 local oc = 68
		
		if `panel'==36 local op = "I"
		if `panel'==72 local op = "S"

		local outputsheet	"t5"
		local outputcell 	"`op'`oc'"	
	
		*set1: urban
		if `set'==1 {
			local myvar			"urban"
			local panelkeepvars "`myvar' age year quarter urban panel relationharm ingreso lpT tamh pid_p mv n_ent"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set2: male
		if `set'==2 {
			local myvar			"male"
			local panelkeepvars "`myvar' age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"	
		}		
		
		*set3: agehead
		if `set'==3 {
			local myvar			"agehead"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set4: schooling
		if `set'==4 {
			local myvar			"schooling"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
		
		*set5: employment
		if `set'==5 {
			local myvar			"employment"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7 lstatus informal"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
		
		*set6: myind2
		if `set'==6 {
			local myvar			"myind2"
			local panelkeepvars "age year quarter  urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7 lstatus informal industry_orig"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set7: incomepc
		if `set'==7 {
			local myvar			"incomepc"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm laborincome mv ingreso tamh"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set8: famsize
		if `set'==8 {
			local myvar			"famsize"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm laborincome"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
			
		*set8: famtype
		if `set'==9 {
			local myvar			"famtype"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm"
			local ifpanelconds 	"if panel==`panel' & mv==0"
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
			keep if mv==0
			gen double incomepc = ingreso/tamh
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
			
			bys year quarter hhid: egen hashead     	= sum(head)
			bys year quarter hhid: egen hasspouse   	= sum(spouse)
			bys year quarter hhid: egen haschildren 	= sum(child)
			bys year quarter hhid: egen hasgranpa 	= sum(granpa)
			bys year quarter hhid: egen hasfamother 	= sum(famother)
			
			gen famtype = 7
				replace famtype = 1 if hsize==1 & hashead==1 // single person
				replace famtype = 2 if hsize==2 & hashead==1 & (hasspouse==1) & (haschildren==0) & (hasgranpa==0) & (hasfamother==0) // couple without children
				replace famtype = 3 if hsize>=3 & hsize<=5 & hashead==1 & (hasspouse==1) & (haschildren>=1 & haschildren<=3) & (hasgranpa==0) & (hasfamother==0) // couple with up to three children
				replace famtype = 4 if hsize>=6 & hsize!=. & hashead==1 & (hasspouse==1) & (haschildren>=4 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // couple with four children or more
				replace famtype = 5 if hsize>=2 & hsize!=. & hashead==1 & (hasspouse==0) & (haschildren>=1 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // single parent with children
				replace famtype = 6 if hsize>=2 & hsize!=. & hashead==1 & (haschildren>=1 & haschildren!=.) & (hasgranpa>=1 & hasgranpa!=.) & (hasfamother==0) // multi-generational family
			keep if relationharm==1
			drop if pid_p==.
			drop if n_ent==.
			tsset pid_p n_ent
		}			
			
			
		*local vars "hhid n_ent year quarter pid pid_p panel hsize relationharm male ingreso mv tamh pob lpT urban"
		*local ifuse "if year>=2005 & year!=. & hhid!="" & relationharm==1 & mv==0"
		*use `vars' `ifuse' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta",clear
		
		merge m:1 year quarter urban using `pl'
		drop if _merge==2
		drop _merge	
		
		if "`monetaryunit'"=="lcu" gen pob2 = cond((ingreso/tamh)<lpT ,1,0)
		if "`monetaryunit'"=="ppp" gen pob2 = cond((ingreso/tamh)<lpT2,1,0)
		
		isid pid_p n_ent
		bys pid_p: gen N = _N
		keep if N==5
		drop N
		keep if (n_ent==1 & quarter==4)|(n_ent==5 & quarter==4)
		
		replace n_ent = 2 if n_ent==5	// To use lags
		tsset

		gen povstatus = . 
			replace povstatus = 1 if (pob2==0 & f.pob2==1)
			replace povstatus = 2 if (pob2==1 & f.pob2==1)
			replace povstatus = 3 if (pob2==1 & f.pob2==0)
			replace povstatus = 4 if (pob2==0 & f.pob2==0)
			
			gen sliders	  =  (pob2==0 & f.pob2==1)
			gen stayer    =  (pob2==1 & f.pob2==1)
			gen climber   =  (pob2==1 & f.pob2==0)
			gen neverpoor =  (pob2==0 & f.pob2==0)

		preserve
			keep if panel==`panel'
			if `set'==7 {
				collapse (mean) `myvar' if n_ent==1 , by(year quarter povstatus n_ent)
				reshape wide incomepc, i(year quarter) j(povstatus)
				drop year quarter
			}
			else {
				collapse (sum) slider stayer climber neverpoor if n_ent==1 [fw=tamh], by(year quarter `myvar')
				drop year quarter `myvar'
				foreach var in slider stayer climber neverpoor {
					sum `var'
					local T`var' = r(sum)
					replace `var' = `var'/`T`var''
				}
			}
			
			if "`monetaryunit'"=="lcu" export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("`outputsheet' V2") cell(`op'`oc')
			if "`monetaryunit'"=="ppp" export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("`outputsheet'ppp V2") cell(`op'`oc')
		
		restore
				

	}
	}
	}

}


/*******************************************************************************
RUN Table 6
*******************************************************************************/
if "`runtable6'"=="yes" {
di in red "Promedio trimestral de los valores de la  Línea de Pobreza Extrema por Ingresos - CONEVAL" 
#delimit ;
	scalar  uT105 	=	754.20	; 
	scalar  rT105 	=	556.78	; 
	scalar  uT205 	=	778.81	; 
	scalar  rT205 	=	581.33	; 
	scalar  uT305 	=	779.81	; 
	scalar  rT305 	=	579.00	; 
	scalar  uT405 	=	777.34	; 
	scalar  rT405 	=	574.19	; 

	scalar  uT106 	=	793.88	; 
	scalar  rT106 	=	589.73	; 
	scalar  uT206 	=	788.75	; 
	scalar  rT206 	=	583.12	; 
	scalar  uT306 	=	805.16	; 
	scalar  rT306 	=	599.09	; 
	scalar  uT406 	=	834.08	; 
	scalar  rT406 	=	629.22	; 

	scalar  uT107 	=	851.23	; 
	scalar  rT107 	=	641.50	; 
	scalar  uT207 	=	840.49	; 
	scalar  rT207 	=	629.76	; 
	scalar  uT307 	=	846.91	; 
	scalar  rT307 	=	634.21	; 
	scalar  uT407 	=	866.83	; 
	scalar  rT407 	=	650.59	; 

	scalar  uT108 	=	875.77	; 
	scalar  rT108 	=	655.79	; 
	scalar  uT208 	=	893.87	; 
	scalar  rT208 	=	671.92	; 
	scalar  uT308 	=	915.77	; 
	scalar  rT308 	=	689.23	; 
	scalar  uT408 	=	945.75	; 
	scalar  rT408 	=	715.18	; 

	scalar  uT109 	=	959.84	; 
	scalar  rT109 	=	724.50	; 
	scalar  uT209 	=	982.88	; 
	scalar  rT209 	=	747.36	; 
	scalar  uT309 	=	996.59	; 
	scalar  rT309 	=	758.12	; 
	scalar  uT409 	=	998.91	; 
	scalar  rT409 	=	759.10	; 

	scalar  uT110 	=	1026.57	; 
	scalar  rT110 	=	780.73	; 
	scalar  uT210 	=	1017.39	; 
	scalar  rT210 	=	769.93	; 
	scalar  uT310 	=	1008.45	; 
	scalar  rT310 	=	757.71  ; 
	scalar  uT410 	=	1032.81	; 
	scalar  rT410 	=	779.66	; 

	scalar  uT111 	=	1049.07	; 
	scalar  rT111 	=	791.31  ; 
	scalar  uT211 	=	1049.74	; 
	scalar  rT211 	=	793.00  ; 
	scalar  uT311 	=	1051.53	; 
	scalar  rT311 	=	794.21  ; 
	scalar  uT411 	=	1076.46	; 
	scalar  rT411 	=	817.32  ; 

	scalar  uT112 	=	1106.36	; 
	scalar  rT112 	=	843.60  ; 
	scalar  uT212 	=	1113.08	; 
	scalar  rT212 	=	847.74  ; 
	scalar  uT312 	=	1152.23	; 
	scalar  rT312 	=	884.25  ; 
	scalar  uT412 	=	1172.86	; 
	scalar  rT412 	=	901.01  ; 

	scalar  uT113 	=	1185.68	; 
	scalar  rT113 	=	908.25  ; 
	scalar  uT213 	=	1197.91	; 
	scalar  rT213 	=	918.90  ; 
	scalar  uT313 	=	1197.24	; 
	scalar  rT313 	=	913.56  ; 
	scalar  uT413 	=	1220.45	; 
	scalar  rT413 	=	934.09  ; 

	scalar  uT114 	=	1252.56	; 
	scalar  rT114 	=	952.71  ; 
	scalar  uT214 	=	1243.86	; 
	scalar  rT214 	=	939.94  ; 
	scalar  uT314 	=	1264.97	; 
	scalar  rT314 	=	954.15  ; 
	scalar  uT414 	=	1295.15	; 
	scalar  rT414 	=	982.12  ; 

	scalar  uT115 	=	1296.14	; 
	scalar  rT115 	=	981.50  ; 
	scalar  uT215 	=	1300.42	; 
	scalar  rT215 	=	985.56  ; 
	scalar  uT315 	=	1312.35	; 
	scalar  rT315 	=	992.04  ; 
	scalar  uT415 	=	1329.88	; 
	scalar  rT415 	=	1006.05	; 

	scalar  uT116 	=	1366.93	; 
	scalar  rT116 	=	1039.95	; 
	scalar  uT216 	=	1359.11	; 
	scalar  rT216 	=	1028.42	; 
	scalar  uT316 	=	1358.61	; 
	scalar  rT316 	=	1025.84	; 
	scalar  uT416 	=	1388.35	; 
	scalar  rT416 	=	1054.02	; 

	scalar  uT117 	=	1407.01	; 
	scalar  rT117 	=	1061.68	; 
	scalar  uT217 	=	1439.17	; 
	scalar  rT217 	=	1090.56	; 
	scalar  uT317 	=	1490.80	; 
	scalar  rT317 	=	1136.26	; 
	scalar  uT417 	=	1501.22	; 
	scalar  rT417 	=	1141.14	; 

	scalar  uT118 	=	1509.99	; 
	scalar  rT118 	=	1144.85	; 
	scalar  uT218 	=	1508.32	; 
	scalar  rT218 	=	1139.69	; 
	scalar  uT318 	=	1537.71	; 
	scalar  rT318 	=	1159.55	; 
	scalar  uT418 	=	1564.27	; 
	scalar  rT418 	=	1186.53	; 

	scalar  uT119 	=	1594.81	; 
	scalar  rT119 	=	1209.52	; 
	scalar  uT219 	=	1597.63	; 
	scalar  rT219 	=	1209.34	; 
	scalar  uT319 	=	1604.31	; 
	scalar  rT319 	=	1212.42	; 
	scalar  uT419 	=	1619.78	; 
	scalar  rT419 	=	1225.79	; 

	scalar  uT120 	=	1664.71	; 
	scalar  rT120 	=	1266.14	; 
	scalar  uT320 	=	1701.39	; 
	scalar  rT320 	=	1298.60	; 
	scalar  uT420 	=	1719.75	; 
	scalar  rT420 	=	1313.92	; 

	scalar  uT121 	=	1732.14	; 
	scalar  rT121 	=	1317.79	; 
	scalar  uT221 	=	1777.32	; 
	scalar  rT221 	=	1358.60	; 
	scalar  uT321 	=	1828.63	; 
	scalar  rT321 	=	1400.08	; 
	scalar  uT421 	=	1877.13	; 
	scalar  rT421 	=	1443.29	; 

	scalar  uT122	=	1951.74 ; 
	scalar  rT122 	=	1498.46	; 
	scalar  uT222	=	1990.99 ; 
	scalar  rT222 	=	1530.41	; 
	scalar  uT322	=	2081.04 ; 
	scalar  rT322 	=	1597.57	;
	scalar  uT422	=	2115.73 ; 
	scalar  rT422 	=	1625.32	;

	scalar  uT123	=	2154.34 ; 
	scalar  rT123 	=	1651.91 ; 
	scalar  uT223	=	2176.94 ; 
	scalar  rT223 	=	1665.47 ; 	
	scalar  uT323	=	2218.76 ; 
	scalar  rT323 	=	1697.79 ;
	scalar  uT423	=	2239.99 ; 
	scalar  rT423 	=	1716.25	;
#delimit cr

	* No hay valores para el segundo trimestre de 2020
	scalar  uT220	= .
	scalar  rT220	= .

* Crear tabla
	set obs 100

	gen year = .
	gen quarter = .
	gen lpU = .
	gen lpR = .

	local i = 1
	forval y=5/23 {
	forval q=1/4  {
		
		replace year = `y'+2000 if _n==`i'
		replace quarter = `q'	if _n==`i'
		
		if `y'<9 local yy = "0`y'"
		if `y'>9 local yy = "`y'"
		
		replace lpU = uT`q'`yy' if _n==`i'
		replace lpR = rT`q'`yy' if _n==`i'
		
		local i = `i'+1

	} 
	}

	drop if year==.
	tempfile lp
	save `lp', replace

* Importar PPPs de WDI
	* PA.NUS.PPP: PPP conversion factor, GDP (LCU per international $)
	* https://data.worldbank.org/indicator/PA.NUS.PPP?locations=MX
	wbopendata, indicator(FP.CPI.TOTL ; PA.NUS.PPP) country("MEX") long clear
	keep year pa_nus_ppp fp_cpi_totl
	keep if year>=2005 & year<=2023
		sum fp_cpi_totl if year==2017
		scalar cpi2017 = r(mean)
	gen double fp_cpi_totl_2017  = fp_cpi_totl/cpi2017
		drop fp_cpi_totl
	replace fp_cpi_totl = fp_cpi_totl[_n-1] * 1.0553 if year==2023
	replace pa_nus_ppp  = pa_nus_ppp[_n-1] * (17.7323/20.13)*(1.041/1.0553) if year==2023

	
	* Combinar bases de datos y ordenar
	merge 1:m year using `lp'
	drop _merge
	order year quarter lpR lpU
	sort  year quarter

	* Linea de pobreza LCU diaria
	gen double lpR_LCU_daily = (lpR*12/365)
	gen double lpU_LCU_daily = (lpU*12/365)
	
	* Linea de pobreza diaria en PPP (international $) - Usando CPI
	gen double lpR_PPP_daily_cpi = (lpR_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017
	gen double lpU_PPP_daily_cpi = (lpU_LCU_daily / pa_nus_ppp)/fp_cpi_totl_2017

	* Linea de pobreza diaria en PPP (international $) - Usando Nivel de Precios de ENOE
	
	sum lpR if year==2017
		scalar pR2017 = r(mean)
	sum lpU if year==2017
		scalar pU2017 = r(mean)

	gen double epi_R_2017 = lpR/pR2017
	gen double epi_U_2017 = lpU/pU2017
	label var epi_R_2017 "CONEVAL Rural Price Index derived from Povery Line"
	label var epi_U_2017 "CONEVAL Urban Price Index derived from Povery Line"
	
	gen double lpR_PPP_daily_epi = (lpR_LCU_daily / pa_nus_ppp)/epi_R_2017
	gen double lpU_PPP_daily_epi = (lpU_LCU_daily / pa_nus_ppp)/epi_U_2017
	

	order year quarter lpR lpU lpR_LCU_daily lpU_LCU_daily  pa_nus_ppp fp_cpi_totl_2017 lpR_PPP_daily_cpi lpU_PPP_daily_cpi epi_R_2017 epi_U_2017 lpR_PPP_daily_epi lpU_PPP_daily_epi
	
	gen double lp_0685LCU_1 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017      // Urban
	gen double lp_0685LCU_0 = (6.85*365/12) * pa_nus_ppp * fp_cpi_totl_2017	*.85 // Rural
	
	*gen double lpR_0685LCU = 6.85 * pa_nus_ppp * epi_R_2017
	*gen double lpU_0685LCU = 6.85 * pa_nus_ppp * epi_U_2017
	
	keep year quarter lp_0685LCU_*
	reshape long lp_0685LCU_ , i(year quarter) j(urban)
	
	rename lp_0685LCU_ lpT2 
	tempfile pl
	save `pl', replace
	
	forval set = 1/9 {
	foreach panel in 36 72 {
	foreach monetaryunit in lcu ppp {
		
		if `set'==1 local oc = 6
		if `set'==2 local oc = 10
		if `set'==3 local oc = 14
		if `set'==4 local oc = 21
		if `set'==5 local oc = 36
		if `set'==6 local oc = 42
		if `set'==7 local oc = 61
		if `set'==8 local oc = 64
		if `set'==9 local oc = 68
		
		if `panel'==36 local op = "E"
		if `panel'==72 local op = "L"

		local outputsheet	"t6"
		local outputcell 	"`op'`oc'"	
	
		*set1: urban
		if `set'==1 {
			local myvar			"urban"
			local panelkeepvars "`myvar' age year quarter urban panel relationharm ingreso lpT tamh pid_p mv n_ent"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set2: male
		if `set'==2 {
			local myvar			"male"
			local panelkeepvars "`myvar' age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"	
		}		
		
		*set3: agehead
		if `set'==3 {
			local myvar			"agehead"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set4: schooling
		if `set'==4 {
			local myvar			"schooling"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
		
		*set5: employment
		if `set'==5 {
			local myvar			"employment"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7 lstatus informal"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
		
		*set6: myind2
		if `set'==6 {
			local myvar			"myind2"
			local panelkeepvars "age year quarter  urban panel relationharm mv ingreso lpT tamh pid_p n_ent relationharm educy educat7 lstatus informal industry_orig"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set7: incomepc
		if `set'==7 {
			local myvar			"incomepc"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm laborincome mv ingreso tamh"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}
		
		*set8: famsize
		if `set'==8 {
			local myvar			"famsize"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm laborincome"
			local ifpanelconds 	"if age>=15 & age<=64 & panel==`panel' & relationharm==1 & mv==0"
		}	
			
		*set8: famtype
		if `set'==9 {
			local myvar			"famtype"
			local panelkeepvars "age year quarter urban panel relationharm mv ingreso lpT tamh pid_p n_ent hhid hsize relationharm"
			local ifpanelconds 	"if panel==`panel' & mv==0"
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
			keep if mv==0
			gen double incomepc = ingreso/tamh
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
			
			bys year quarter hhid: egen hashead     	= sum(head)
			bys year quarter hhid: egen hasspouse   	= sum(spouse)
			bys year quarter hhid: egen haschildren 	= sum(child)
			bys year quarter hhid: egen hasgranpa 	= sum(granpa)
			bys year quarter hhid: egen hasfamother 	= sum(famother)
			
			gen famtype = 7
				replace famtype = 1 if hsize==1 & hashead==1 // single person
				replace famtype = 2 if hsize==2 & hashead==1 & (hasspouse==1) & (haschildren==0) & (hasgranpa==0) & (hasfamother==0) // couple without children
				replace famtype = 3 if hsize>=3 & hsize<=5 & hashead==1 & (hasspouse==1) & (haschildren>=1 & haschildren<=3) & (hasgranpa==0) & (hasfamother==0) // couple with up to three children
				replace famtype = 4 if hsize>=6 & hsize!=. & hashead==1 & (hasspouse==1) & (haschildren>=4 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // couple with four children or more
				replace famtype = 5 if hsize>=2 & hsize!=. & hashead==1 & (hasspouse==0) & (haschildren>=1 & haschildren!=.) & (hasgranpa==0) & (hasfamother==0) // single parent with children
				replace famtype = 6 if hsize>=2 & hsize!=. & hashead==1 & (haschildren>=1 & haschildren!=.) & (hasgranpa>=1 & hasgranpa!=.) & (hasfamother==0) // multi-generational family
			keep if relationharm==1
			drop if pid_p==.
			drop if n_ent==.
			tsset pid_p n_ent
		}
			
		*local vars "hhid n_ent year quarter pid pid_p panel hsize relationharm male ingreso mv tamh pob lpT urban"
		*local ifuse "if year>=2005 & year!=. & hhid!="" & relationharm==1 & mv==0"
		*use `vars' `ifuse' using "$path/PANEL/DATA/MEX_2005_2023_PANEL_QUARTER_EXPORTS.dta",clear
		
		merge m:1 year quarter urban using `pl'
		drop if _merge==2
		drop _merge	
		
		if "`monetaryunit'"=="lcu" gen pob2 = cond((ingreso/tamh)<lpT ,1,0)
		if "`monetaryunit'"=="ppp" gen pob2 = cond((ingreso/tamh)<lpT2,1,0)
		
		isid pid_p n_ent
		bys pid_p: gen N = _N
		keep if N==5

		sort pid_p n_ent
		bys  pid_p: egen Npob = sum(pob2)
		tab Npob, gen(_Npob)
			
		preserve
			keep if panel==`panel'
			if `set'==7 {
				collapse (mean) `myvar' if n_ent==1 , by(year quarter Npob n_ent)
				reshape wide incomepc, i(year quarter) j(Npob)
				drop year quarter
			}
			else {
				collapse (sum) _Npob* if n_ent==1 [fw=tamh], by(year quarter `myvar')
				drop year quarter `myvar'
				foreach var of varlist _Npob* {
					sum `var'
					local T`var' = r(sum)
					replace `var' = `var'/`T`var''
				}
			}
			
			if "`monetaryunit'"=="lcu" export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("`outputsheet' V2") cell(`op'`oc')
			if "`monetaryunit'"=="ppp" export excel using "$output/paneles para estudio movilidad de ingresos.xlsx", sheetmodify sheet("`outputsheet'ppp V2") cell(`op'`oc')
		restore
	
	}
	}
	}
	
}

/*******************************************************************************
End of do-file
*******************************************************************************/
