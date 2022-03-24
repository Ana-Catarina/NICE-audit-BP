library(tidyverse)

df_input <- read_csv(
  here::here("output", "input.csv"),
  col_types = cols(patient_id = col_integer(),age = col_double())
)

head(df_input)


## Convert age into categorical variable using cut-off 80 years

df_input$age_c <- ifelse(df_input$age<80,1,0)

data <- df_input[df_input$age_c==1,]

data80 <- df_input[df_input$age_c==0,]

summary(df_input$age_c)

class(df_input$age_c)


#### calculate outcomes for under 80

summary(data$last_systolic_bp_measure)

summary(data$last_ambulatory_systolic_bp_measure)

summary(data$last_ambulatory_systolic_bp_measure_narrow)

summary(data$last_ambulatory_systolic_bp_measure)


# calculate SBP under 140 using different measurements

data$bp140 <- ifelse(data$last_ambulatory_systolic_bp_measure<140,1,0)

data$ambp140_narrow <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<140,1,0)

data$ambp140_broad <- ifelse(data$last_ambulatory_systolic_bp_measure<140,1,0)


# calculate SBP under 135 using different AMBP/HBPM

data$ambp135_narrow <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<135,1,0)

data$ambp135_broad <- ifelse(data$last_ambulatory_systolic_bp_measure<135,1,0)


summary(as.factor(data$ambp140_narrow))

summary(as.factor(data$ambp140_broad))

summary(as.factor(data$ambp135_narrow))

summary(as.factor(data$ambp135_broad))

summary(as.factor(data$bp140))


## Create table with SBP between 140 and 135

all_bp_narrow <- table(data$ambp140_narrow, data$ambp135_narrow,
                useNA = "ifany",
                dnn = c("under140","under135"))

all_bp_narrow <- data.frame(all_bp_narrow)


write_csv(all_bp_narrow, "output/csv_all_bp_narrow.csv")



all_bp_broad <- table(data$ambp140_broad, data$ambp135_broad,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

all_bp_broad <- data.frame(all_bp_broad)


write_csv(all_bp_broad, "output/csv_all_bp_broad.csv")


## stratified analysis by CVD, CKD and DM


## SBP 140 overall

ckd <- table(data$bp140, data$CKD_code,useNA = "ifany", dnn = c("SBP140","CKD"))

ckd <- data.frame(ckd)

cvd <- table(data$bp140, data$CVD_code,useNA = "ifany", dnn = c("SBP140","CVD"))

cvd <- data.frame(cvd)

t1d <- table(data$bp140, data$T1D_code,useNA = "ifany", dnn = c("SBP140","T1D"))

t1d <- data.frame(t1d)

t2d <- table(data$bp140, data$T2D_code,useNA = "ifany", dnn = c("SBP140","T2D"))

t2d <- data.frame(t2d)


bp_subgroups <- data.frame(ckd, cvd, t2d, t2d)

write_csv(bp_subgroups, "output/csv_bp_subgroups.csv")


## SBP between 140 and 135

data.ckd <- data[data$CKD_code==1,]

ckd_bp_narrow <- table(data.ckd$ambp140_narrow, data.ckd$ambp135_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

ckd_bp_narrow <- data.frame(ckd_bp_narrow)


write_csv(ckd_bp_narrow, "output/csv_ckd_bp_narrow.csv")


data.cvd <- data[data$CVD_code==1,]

cvd_bp_narrow <- table(data.cvd$ambp140_narrow, data.cvd$ambp135_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

cvd_bp_narrow <- data.frame(cvd_bp_narrow)


write_csv(cvd_bp_narrow, "output/csv_cvd_bp_narrow.csv")



data.t1d <- data[data$T1D_code==1,]

t1d_bp_narrow <- table(data.t1d$ambp140_narrow, data.t1d$ambp135_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t1d_bp_narrow <- data.frame(t1d_bp_narrow)


write_csv(t1d_bp_narrow, "output/csv_t1d_bp_narrow.csv")


data.t2d <- data[data$T2D_code==1,]

t2d_bp_narrow <- table(data.t2d$ambp140_narrow, data.t2d$ambp135_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t2d_bp_narrow <- data.frame(t2d_bp_narrow)


write_csv(t2d_bp_narrow, "output/csv_t2d_bp_narrow.csv")


#### calculate outcomes for over 80

summary(data80$last_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure_narrow)


# calculate SBP under 150 using different measurements

data80$bp150 <- ifelse(data80$last_ambulatory_systolic_bp_measure<150,1,0)

data80$ambp150_narrow <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<150,1,0)

data80$ambp150_broad <- ifelse(data80$last_ambulatory_systolic_bp_measure<150,1,0)



# calculate SBP under 145 using different AMBP/HBPM

data80$ambp145_narrow <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<145,1,0)

data80$ambp145_broad <- ifelse(data80$last_ambulatory_systolic_bp_measure<145,1,0)


summary(as.factor(data80$ambp150_narrow))

summary(as.factor(data80$ambp150_broad))

summary(as.factor(data80$ambp145_narrow))

summary(as.factor(data80$ambp145_broad))

summary(as.factor(data80$bp150))


## Create table with SBP between 150 and 145

all_bp_narrow80 <- table(data80$ambp150_narrow, data80$ambp145_narrow,
                       useNA = "ifany",
                       dnn = c("under150","under145"))

all_bp_narrow80 <- data.frame(all_bp_narrow80)


write_csv(all_bp_narrow80, "output/csv_all_bp_narrow80.csv")



all_bp_broad80 <- table(data80$ambp150_broad, data80$ambp145_broad,
                      useNA = "ifany",
                      dnn = c("under150","under145"))

all_bp_broad80 <- data.frame(all_bp_broad80)


write_csv(all_bp_broad80, "output/csv_all_bp_broad80.csv")



## stratified analysis by CVD, CKD and DM


## SBP 140 overall

ckd80 <- table(data80$bp150, data80$CKD_code,useNA = "ifany", dnn = c("SBP150","CKD"))

ckd80 <- data.frame(ckd80)

cvd80 <- table(data80$bp150, data80$CVD_code,useNA = "ifany", dnn = c("SBP150","CVD"))

cvd80 <- data.frame(cvd80)

t1d80 <- table(data80$bp150, data80$T1D_code,useNA = "ifany", dnn = c("SBP150","T1D"))

t1d80 <- data.frame(t1d80)

t2d80 <- table(data80$bp150, data80$T2D_code,useNA = "ifany", dnn = c("SBP150","T2D"))

t2d80 <- data.frame(t2d80)


bp_subgroups80 <- data.frame(ckd80, cvd80, t2d80, t2d80)

write_csv(bp_subgroups80, "output/csv_bp_subgroups80.csv")


## SBP between 150 and 145

data.ckd80 <- data80[data80$CKD_code==1,]

ckd_bp_narrow80 <- table(data.ckd80$ambp150_narrow, data.ckd80$ambp145_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

ckd_bp_narrow80 <- data.frame(ckd_bp_narrow80)


write_csv(ckd_bp_narrow80, "output/csv_ckd_bp_narrow80.csv")



data.cvd80 <- data80[data80$CVD_code==1,]

cvd_bp_narrow80 <- table(data.cvd80$ambp150_narrow, data.cvd80$ambp145_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

cvd_bp_narrow80 <- data.frame(cvd_bp_narrow80)


write_csv(cvd_bp_narrow80, "output/csv_cvd_bp_narrow80.csv")



data.t1d80 <- data80[data80$T1D_code==1,]

t1d_bp_narrow80 <- table(data.t1d80$ambp150_narrow, data.t1d80$ambp145_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t1d_bp_narrow80 <- data.frame(t1d_bp_narrow80)


write_csv(t1d_bp_narrow80, "output/csv_t1d_bp_narrow80.csv")


data.t2d80 <- data80[data80$T2D_code==1,]

t2d_bp_narrow80 <- table(data.t2d80$ambp150_narrow, data.t2d80$ambp145_narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t2d_bp_narrow80 <- data.frame(t2d_bp_narrow80)


write_csv(t2d_bp_narrow80, "output/csv_t2d_bp_narrow80.csv")
