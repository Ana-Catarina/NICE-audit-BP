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
    default_expectations={
        "date": {"earliest": "1900-01-01", "latest": "today"},
        "rate": "uniform",
        "incidence": 0.5,
    },
    
    population = patients.satisfying("""
                                     registered AND (pat_age >= 18) AND hypertension
                                     """,
                                     registered = patients.registered_as_of("2021-03-31"),
                                     pat_age = patients.age_as_of("2021-03-31"),
                                     hypertension = patients.with_these_clinical_events(hypertension_diag_code, on_or_before = "2021-03-31")
                                     ),

    age=patients.age_as_of(
        "2022-01-01",
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
                                                   on_or_before = "2021-03-31",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.1}
                                                   ),
    
    CVD_code = patients.with_these_clinical_events(CVD_codes,
                                                   on_or_before = "2021-03-31",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),
                                                   
    T1D_code = patients.with_these_clinical_events(T1D_codes,
                                                   on_or_before = "2021-03-31",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.1}
                                                   ),
                                                   
    T2D_code = patients.with_these_clinical_events(T2D_codes,
                                                   on_or_before = "2021-03-31",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),
                                                   
    Overall_diab_code = patients.with_these_clinical_events(Overall_diab_codes,
                                                   on_or_before = "2021-03-31",
                                                   returning = "binary_flag",
                                                   return_expectations = {"incidence": 0.2}
                                                   ),                                               
    
    
    msoa_geography = patients.registered_practice_as_of("2021-03-31",
                                                        returning = "msoa",
                                                        return_expectations = {"category": {"ratios": {"E01545789": 0.3, "E15847895": 0.4, "E18523465": 0.3}}, "incidence": 0.95}),
                                                        
    stp_geography = patients.registered_practice_as_of("2021-03-31",
                                                        returning = "stp_code",
                                                        return_expectations = {"category": {"ratios": {"QK1": 0.3, "QUY": 0.4, "E18523465": 0.3}}, "incidence": 0.95}),
                                            
                                                        
    
    last_systolic_bp_measure = patients.with_these_clinical_events(all_systolic_codes,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_systolic_bp_date = patients.with_these_clinical_events(all_systolic_codes,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),
                                                                
    last_ambulatory_systolic_bp_measure = patients.with_these_clinical_events(ambulatory_systolic_codes,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_ambulatory_systolic_bp_date = patients.with_these_clinical_events(ambulatory_systolic_codes,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),    
                                                                    
    last_ambulatory_systolic_bp_measure_narrow = patients.with_these_clinical_events(ambulatory_systolic_codes_narrow,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "numeric_value",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"float" : {"distribution": "normal",
                                                                                                    "mean": 112,
                                                                                                    "stddev": 10},
                                                                                                    "incidence": 0.75}
                                                                    ),
                                                                    
    last_ambulatory_systolic_bp_date_narrow = patients.with_these_clinical_events(ambulatory_systolic_codes_narrow,
                                                                    between = ["2020-04-01", "2021-03-31"],
                                                                    returning = "date",
                                                                    date_format = "YYYY-MM-DD",
                                                                    find_last_match_in_period = "TRUE",
                                                                    return_expectations = {"date" : {"earliest": "2020-04-01",
                                                                                                    "latest": "2021-03-31"},
                                                                                            "rate": "exponential_increase",
                                                                                            "incidence": 0.75}
                                                                    ),    
    
)
