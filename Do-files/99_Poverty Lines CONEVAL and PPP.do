clear
set more off

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
	
	sort year
	replace fp_cpi_totl = fp_cpi_totl[_n-1] * 1.0553 if year==2023
	replace pa_nus_ppp  = pa_nus_ppp[_n-1] * (17.7323/20.13)*(1.041/1.0553) if year==2023
	
	keep if year>=2005 & year<=2023
		sum fp_cpi_totl if year==2017
		scalar cpi2017 = r(mean)
	gen double fp_cpi_totl_2017  = fp_cpi_totl/cpi2017
		drop fp_cpi_totl
	
	keep year fp_cpi_totl_2017 pa_nus_ppp
	
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
	
	gen double lpN_0685LCU = 6.85 * pa_nus_ppp * fp_cpi_totl_2017
	
	export excel using "$output/Lineas de Pobreza CONEVAL y PPP.xlsx", sheet("LP_data") cell(C5) sheetmodify
	
	
	
	
	
	



