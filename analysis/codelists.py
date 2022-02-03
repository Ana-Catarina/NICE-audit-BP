from cohortextractor import (
    StudyDefinition,
    codelist,
    codelist_from_csv,
    combine_codelists,
    filter_codes_by_category,
    patients,
)

all_systolic_codes = codelist_from_csv("codelists/opensafely-systolic-blood-pressure-qof.csv", system = "snomed", column = "code")
hypertension_diag_code = codelist_from_csv("codelists/opensafely-hypertension-snomed.csv", system = "snomed", column = "id")
ambulatory_systolic_codes = codelist_from_csv("codelists/user-rob_w-ambulatory_systolic_bp_qof.csv", system = "snomed", column = "code")
ambulatory_systolic_codes_narrow = codelist_from_csv("codelists/user-rob_w-ambulatory_systolic_bp_narrow.csv", system = "snomed", column = "code")
