use "Data_EA2020.dta",clear

*Generate Variables:
	label define early 1 "ED" 0 "REA",replace
	label values ed early
	gen admis= accept/applic //Admission Rate
	gen needbl_and_meetn=needbl*meetfull_n //Need blind and meets full need US citizen
	gen needbl_and_meeti=needbl*meetfull_n*meetfull_i //need blind and meets full need international
	gen overdem=applic/enrolled //excess demand
	gen yield= enrolled/ accept //Yield Rate
	gen sat=sat_mat+sat_read //Total SAT
	gen admis_e=admis_pct_ea //Early Admission Rate
	replace admis_e=admis_pct_ed if ed==1 //Early Admission Rate
	gen applic_e=enroll*_class_enrolled_ea/admis_e //Number of Early Applications
	gen applic_e_pct=applic_e/applic //% of total applications from Early
	gen sg_to_self=avg_need_sg/ avg_need_self //Ratio of grants and scholarshipts to self help aid
	gen cost=tuition+room //cost of attendance

*General
	tab ed
	tabstat needbl, by(ed)
*College Characteristics
	tabstat rank_u rank_pref fin_rank endow_fte_2018 cost, by(ed)
*Admissions
	tabstat applic applic_e_pct enroll _class_enrolled_ea overdem yield admis, by(ed)
*Student Characteristics
	tabstat sat gpa fresh_top10_pct, by(ed)
*Financial Aid
	tabstat needbl_and_meetn needbl_and_meeti,by(ed) 
	tabstat sg_to_self avgcost30to48 avgcost110000 if needbl_and_meetn==1,by(ed)
	

