from cohortextractor import (
    StudyDefinition,
    codelist,
    codelist_from_csv,
    combine_codelists,
    filter_codes_by_category,
    patients,
)

all_systolic_codes = codelist_from_csv("codelists/opensafely-systolic-blood-pressure-qof.csv", system = "snomed", column = "code")
hypertension_diag_code = codelist_from_csv("codelists/nhsd-primary-care-domain-refsets-hyp_cod.csv", system = "snomed", column = "code")
hypertension_resolved_code = codelist_from_csv("codelists/nhsd-primary-care-domain-refsets-hypres_cod.csv", system = "snomed", column = "code")
ambulatory_systolic_codes = codelist_from_csv("codelists/user-rob_w-ambulatory_systolic_bp_qof.csv", system = "snomed", column = "code")
ambulatory_systolic_codes_narrow = codelist_from_csv("codelists/user-rob_w-ambulatory_systolic_bp_narrow.csv", system = "snomed", column = "code")
CKD_codes = codelist_from_csv("codelists/primis-covid19-vacc-uptake-ckd15.csv", system = "snomed", column = "code")
CVD_codes = codelist_from_csv("codelists/primis-covid19-vacc-uptake-chd_cov.csv", system = "snomed", column = "code")
T1D_codes = codelist_from_csv("codelists/opensafely-type-1-diabetes.csv", system="ctv3", column="CTV3ID")
T2D_codes = codelist_from_csv("codelists/opensafely-type-2-diabetes.csv", system="ctv3", column="CTV3ID")
Overall_diab_codes = codelist_from_csv("codelists/primis-covid19-vacc-uptake-diab.csv", system = "snomed", column = "code")
