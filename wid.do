 
/*==============================================================================
      World Inequality Database 
==============================================================================*/
*Codes Dictionary:  https://wid.world/codes-dictionary/
/* 
*WID command: 
	 options                                             Description
      indicators(list of 6-letter codes|_all)           codes names of the indicators in the database; 
      areas(list of area codes|_all)                    area code names of the database; 
      years(numlist)                                    years; default is all
      perc(list of percentiles|_all)                    list of percentiles; either pXXpYY or pXX; 
      ages(list of age codes|_all)                      age category codes in the database; 999 for all ages, 992 for adults; 
      population(list of population codes|_all)         type of population; one-letter code
 */



/******************** Macro indicators  **************************/
wid, indicators(mnninc  mprico) ///
				areas(BR MX FR ES US)    ///
				years(2003/2019) clear
	 
	 gen var=substr(variable,1,6)
	 drop age pop variable 
	 tempfile macro
	 save "`macro'"
	 

use "`macro'", clear 

*Reshape to wide
reshape wide value, i(country year) j(var) string
rename value* v_*


*----[1] Share of corp prof (mprico) / NNI (mnninc)
 gen share_prico = v_mprico / v_mnninc 
    
*Figure 
	twoway (scatter share_prico year if country =="BR",  c(l) msize(small) lw(thin)) ///
		   (scatter share_prico year if country =="MX",  c(l) msize(small) lw(thin)) ///
		   (scatter share_prico year if country =="FR",  c(l) msize(small) lw(thin)) ///
		   (scatter share_prico year if country =="ES",  c(l) msize(small) lw(thin)) ///
		   (scatter share_prico year if country =="US",  c(l) msize(small) lw(medthick)), ///
			graphregion(fcolor(white) lcolor(gs16)) ///
			ytitle("Share of corporate profits") ylab(, nogrid)  ///
			legend(order (1 "BR" 2 "MX" 3 "FR" 4 "ES" 5 "US") ///
	     	region(lcolor(black))  pos(6) col(12) size(*0.7))  ///
	 	
