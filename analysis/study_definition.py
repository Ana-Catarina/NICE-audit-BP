from cohortextractor import (
    StudyDefinition,
    codelist,
    codelist_from_csv,
    combine_codelists,
    filter_codes_by_category,
    patients,
)

from codelists import *

study = StudyDefinition(
    
    index_date = '2021-01-01',
    
    default_expectations={
        "date": {"earliest": "1900-01-01", "latest": "today"},
        "rate": "uniform",
        "incidence": 0.5,
    },
    
    #hypertension diags (Milan's boolean implementation)
    hypertension = patients.with_these_clinical_events(
        on_or_before="last_day_of_year(index_date)",
        codelist=hypertension_diag_code,
        returning="binary_flag",
        find_last_match_in_period=True,
        include_date_of_match=True,
        date_format="YYYY-MM-DD",
    ),    
    
    hypertension_resolved=patients.with_these_clinical_events(
        on_or_before="last_day_of_year(index_date)",
        codelist=hypertension_resolved_code,
        returning="binary_flag",
        find_last_match_in_period=True,
        include_date_of_match=True,
        date_format="YYYY-MM-DD",
    ),
    
    
    
    population = patients.satisfying("""
                                     registered AND 
                                     (pat_age >= 18) AND
                                     ((hypertension AND (NOT hypertension_resolved)) OR
                                     (hypertension_resolved_date <= hypertension_date))
                                     """,
                                     registered = patients.registered_as_of("index_date"),
                                     pat_age = patients.age_as_of("last_day_of_year(index_date)"),
                                     ),
                                     
    age=patients.age_as_of(
        "last_day_of_year(index_date)",
        return_expectations={
            "rate": "universal",
            "int": {"distribution": "population_ages"},
        },
    ),
    
    sex = patients.sex(
        return_expectations = {
            "rate": "universal",
            "category": {"ratios": {"M": 0.49, "F": 0.51}}
            }
    ),
    
    CKD_code = patients.with_these_clinical_events(CKD_codes,
                                                   on_or_before = "last_day_of_year(index_date)",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.1}
                                                   ),
    
    CVD_code = patients.with_these_clinical_events(CVD_codes,
                                                   on_or_before = "last_day_of_year(index_date)",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),
                                                   
    T1D_code = patients.with_these_clinical_events(T1D_codes,
                                                   on_or_before = "last_day_of_year(index_date)",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.1}
                                                   ),
                                                   
    T2D_code = patients.with_these_clinical_events(T2D_codes,
                                                   on_or_before = "last_day_of_year(index_date)",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),
                                                   
    Overall_diab_code = patients.with_these_clinical_events(Overall_diab_codes,
                                                   on_or_before = "last_day_of_year(index_date)",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),                                               
    
    last_systolic_bp_measure = patients.with_these_clinical_events(all_systolic_codes,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_systolic_bp_date = patients.with_these_clinical_events(all_systolic_codes,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),
                                                                
    last_ambulatory_systolic_bp_measure = patients.with_these_clinical_events(ambulatory_systolic_codes,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_ambulatory_systolic_bp_date = patients.with_these_clinical_events(ambulatory_systolic_codes,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),    
                                                                    
    last_ambulatory_systolic_bp_measure_narrow = patients.with_these_clinical_events(ambulatory_systolic_codes_narrow,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_ambulatory_systolic_bp_date_narrow = patients.with_these_clinical_events(ambulatory_systolic_codes_narrow,
                                                                    between = ["first_day_of_year(index_date)",
                                                                               "last_day_of_year(index_date)"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),    
    
)
