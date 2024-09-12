create database healthcare;

select * from total_discharge;
select Year,sum(DIS_TOT) as total_discharge from total_discharge
group by YEAR;

-------- Category and Year wise Discharge
select YEAR, concat(round((sum(DIS_MCAR)/1000),2)," K") as Medicare_Traditional ,
concat(round((sum(DIS_MCAR_MC)/1000),2)," K") as Medicare_Managed_Care ,
concat(round((sum(DIS_MCAL)/1000),2)," K") as Medical_Traditional ,
concat(round((sum(DIS_MCAL_MC)/1000),2)," K")as Medical_ManagedCare ,
concat(round((sum(DIS_CNTY)/1000),2)," K")as County_Indigent_Programs_Traditional,
concat(round((sum(DIS_CNTY_MC)/1000),2)," K") as County_Indigent_Prgrams_Managed_Care,
concat(round((sum(DIS_THRD)/1000),2)," K")as Other_Third_Parties_Tradional,
concat(round((sum(DIS_THRD_MC)/1000),2)," K") as Other_Third_Parties_Managed_Care,
concat(round((sum(DIS_INDGNT)/1000),2)," K")as Other_Indigent,
concat(round((sum(DIS_OTH)/1000),2)," K") as Other_Payers
 from total_discharge
 group by YEAR;
 
 
 
  ### KPI 2:Patient Days
  select  * from kp1_2_patient_days;
  ----- Year wise Patient Days
	select Year,sum(DAY_TOT) as total_patientdays from kp1_2_patient_days
	group by YEAR;
  
  
  
  -------- Category - Yearly Patient Days
  select  YEAR,
  concat(round((sum(DAY_MCAR)/1000),2)," K") as Medicare_Traditional ,
concat(round((sum(DAY_MCAR_MC)/1000),2)," K") as Medicare_Managed_Care ,
concat(round((sum(DAY_MCAL)/1000),2)," K")as Medical_Traditional ,
concat(round((sum(DAY_MCAL_MC)/1000),2)," K") as Medical_ManagedCare ,
concat(round((sum(DAY_CNTY)/1000),2)," K") as County_Indigent_Programs_Traditional,
concat(round((sum(DAY_CNTY_MC)/1000),2)," K") as County_Indigent_Prgrams_Managed_Care,
concat(round((sum(DAY_THRD)/1000),2)," K")as Other_Third_Parties_Tradional,
concat(round((sum(DAY_THRD_MC)/1000),2)," K") as Other_Third_Parties_Managed_Care,
concat(round((sum(DAY_INDGNT)/1000),2)," K") as Other_Indigent,
concat(round((sum(DAY_OTH)/1000),2)," K") as Other_Payers
 from kp1_2_patient_days
 group by YEAR;
 
 #### KPI :3NET PATIENT Revenue
 ------- Yearly Net Patient Revenue
 	select Year, concat(round(sum(NET_TOT_in_K),2)," K") as NET_Patient_Revenue from net_patient_revenue
	group by YEAR;  
    
-------- Category , Yearly Wise NetPatient Revenue
 select YEAR ,
 concat(round(sum(NET_MCAR_In_K),2)," K") as Medicare_Traditional ,
concat(round(sum(NET_MCAR_MC_in_K),2)," K") as Medicare_Managed_Care ,
concat(round(sum(NET_MCAL_in_K),2)," K") as Medical_Traditional ,
concat(round(sum(NET_MCAL_MC_in_K),2)," K")as Medical_ManagedCare ,
concat(round(sum(NET_CNTY_in_K),2)," K") as County_Indigent_Programs_Traditional,
concat(round(sum(NET_CNTY_MC_in_K),2)," K")as County_Indigent_Prgrams_Managed_Care,
concat(round(sum(NET_THRD_in_K),2)," K") as Other_Third_Parties_Tradional,
concat(round(sum(NET_THRD_MC_in_K),2)," K")as Other_Third_Parties_Managed_Care,
concat(round(sum(NET_INDGNT_in_K),2)," K") as Other_Indigent,
concat(round(sum(NET_OTH_in_K),2)," K")as Other_Payers
 from net_patient_revenue
 group by YEAR;
   
   ######State  Hospital Revenue 
   -------- State Hospital Total Revenue yearly
   Select  YEAR, concat(round(sum(NET_TOT_IN_K),2), "K") as Net_Revenue
   from state_hospital_revenue
   where  TYPE_HOSP = "State Hospitals"
   group by YEAR ;
   ---------- State Hospital Revenue 
   Select  YEAR, FAC_NAME, concat(round(sum(NET_TOT_IN_K),2), "K") as Net_Revenue
   from state_hospital_revenue
   where  TYPE_HOSP = "State Hospitals"
   group by FAC_NAME ,YEAR
   order by YEAR;
   
   
    
   
   
### Types of Hospital Revenue
select  YEAR, 
concat(round(sum(_in_thousand),2)," K") as Total_Gross_In_Patient_Revenueas, 
concat(round((sum(GROP_TOT_in_K)),2)," K") as Total_Gross_Out_Patient_Revenue,
concat(round(sum(CAP_TOT_in_K),2)," K") as Total_Capitation_Premium_Revenue,
concat(round(sum(NET_TOT_in_K) ,2)," K") as TOtal_Net_Patient_Revenue
from type_of_hospital_revenue
group by YEAR ;

### Total Patient, total Hospitals
 select count(FAC_NAME) as Total_Hospitals ,
 sum(DAY_TOT) +sum(VIS_TOT) as Total_Patient
   from total_patient_hospital;
   
   
  ##### cUstomised Kpi: Country wise Revenue 
   
 select COUNTY_NAME ,   concat(round(sum(NET_TOT_IN_K),2), "K") as Net_Revenue 
 from country_wise_revenue
 group by COUNTY_NAME;
 
 ####Customised KPI : City wise count of available Beds
  select CITY , Count(AVL_BEDS) as Available_Beds 
   from city_wise_available_beds
 group by CITY 
 order by Available_Beds desc;

 ##QTD
select Quarter, CONCAT(ROUND(SUM(NET_TOT_in_K)/1000, 2), "K") as Total_Revenue
from qtd_ytd
group by Quarter
order by Quarter;


   
   ###YTD
   select YEAR, CONCAT(ROUND(SUM(NET_TOT_in_K)/1000, 2), "K") as Total_Revenue
from qtd_ytd
group by YEAR
order by YEAR;


## Revenue Trend 
 select count(*) from revenue_trend;

select Year, 
concat(round(sum(GROP_TOT_in_M), 2), "M") as Total_Gross_Outpatient_Revenue ,
concat(round( sum(GRIP_TOT_IN_M), 2), "M") as Total_Gross_Inpatient_Revenue ,
concat(round(sum(CAP_TOT_in_M), 2), "M") as Total_Capitation_Preminum_Revenue ,
concat(round(sum(NET_TOT_in_M), 2), "M") as Total_Net_Patient_Revenue ,
concat(round(sum(DED_TOT_in_K), 2), "M") as Total_Deducation_from_revenue,
concat(round(sum(OTH_OP_REV_in_M), 2), "M") as Other_Operating_revenue
from revenue_trend
group by YEAR;