library('tidyverse')

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

data$ambp140.narrow <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<140,1,0)

data$ambp140.broad <- ifelse(data$last_ambulatory_systolic_bp_measure<140,1,0)


# calculate SBP under 135 using different AMBP/HBPM

data$ambp135.narrow <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<135,1,0)

data$ambp135.broad <- ifelse(data$last_ambulatory_systolic_bp_measure<135,1,0)


summary(as.factor(data$ambp140.narrow))

summary(as.factor(data$ambp140.broad))

summary(as.factor(data$ambp135.narrow))

summary(as.factor(data$ambp135.broad))

summary(as.factor(data$bp140))


## Create table with SBP between 140 and 135

all.bp.narrow <- table(data$ambp140.narrow, data$ambp135.narrow,
                useNA = "ifany",
                dnn = c("under140","under135"))

all.bp.narrow <- data.frame(all.bp.narrow)


write.csv(all.bp.narrow, file="all.bp.narrow.csv")



all.bp.broad <- table(data$ambp140.broad, data$ambp135.broad,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

all.bp.broad <- data.frame(all.bp.broad)


write.csv(all.bp.broad, file="all.bp.broad.csv")


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


bp.subgroups <- data.frame(ckd, cvd, t2d, t2d)

write.csv(bp.subgroups, file="bp.subgroups.csv")


## SBP between 140 and 135

data.ckd <- data[data$CKD_code==1,]

ckd.bp.narrow <- table(data.ckd$ambp140.narrow, data.ckd$ambp135.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

ckd.bp.narrow <- data.frame(ckd.bp.narrow)


write.csv(ckd.bp.narrow, file="ckd.bp.narrow.csv")



data.cvd <- data[data$CVD_code==1,]

cvd.bp.narrow <- table(data.cvd$ambp140.narrow, data.cvd$ambp135.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

cvd.bp.narrow <- data.frame(cvd.bp.narrow)


write.csv(cvd.bp.narrow, file="cvd.bp.narrow.csv")



data.t1d <- data[data$T1D_code==1,]

t1d.bp.narrow <- table(data.t1d$ambp140.narrow, data.t1d$ambp135.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t1d.bp.narrow <- data.frame(t1d.bp.narrow)


write.csv(t1d.bp.narrow, file="t1d.bp.narrow.csv")


data.t2d <- data[data$T2D_code==1,]

t2d.bp.narrow <- table(data.t2d$ambp140.narrow, data.t2d$ambp135.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t2d.bp.narrow <- data.frame(t2d.bp.narrow)


write.csv(t2d.bp.narrow, file="t2d.bp.narrow.csv")


#### calculate outcomes for over 80

summary(data80$last_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure_narrow)


# calculate SBP under 150 using different measurements

data80$bp150 <- ifelse(data80$last_ambulatory_systolic_bp_measure<150,1,0)

data80$ambp150.narrow <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<150,1,0)

data80$ambp150.broad <- ifelse(data80$last_ambulatory_systolic_bp_measure<150,1,0)



# calculate SBP under 145 using different AMBP/HBPM

data80$ambp145.narrow <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<145,1,0)

data80$ambp145.broad <- ifelse(data80$last_ambulatory_systolic_bp_measure<145,1,0)


summary(as.factor(data80$ambp150.narrow))

summary(as.factor(data80$ambp150.broad))

summary(as.factor(data80$ambp145.narrow))

summary(as.factor(data80$ambp145.broad))

summary(as.factor(data80$bp150))


## Create table with SBP between 150 and 145

all.bp.narrow80 <- table(data80$ambp150.narrow, data80$ambp145.narrow,
                       useNA = "ifany",
                       dnn = c("under150","under145"))

all.bp.narrow80 <- data.frame(all.bp.narrow80)


write.csv(all.bp.narrow80, file="all.bp.narrow80.csv")



all.bp.broad80 <- table(data80$ambp150.broad, data80$ambp145.broad,
                      useNA = "ifany",
                      dnn = c("under150","under145"))

all.bp.broad80 <- data.frame(all.bp.broad80)


write.csv(all.bp.broad80, file="all.bp.broad80.csv")



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


bp.subgroups80 <- data.frame(ckd80, cvd80, t2d80, t2d80)

write.csv(bp.subgroups80, file="bp.subgroups80.csv")


## SBP between 150 and 145

data.ckd80 <- data80[data80$CKD_code==1,]

ckd.bp.narrow80 <- table(data.ckd80$ambp150.narrow, data.ckd80$ambp145.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

ckd.bp.narrow80 <- data.frame(ckd.bp.narrow80)


write.csv(ckd.bp.narrow80, file="ckd.bp.narrow80.csv")



data.cvd80 <- data80[data80$CVD_code==1,]

cvd.bp.narrow80 <- table(data.cvd80$ambp150.narrow, data.cvd80$ambp145.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

cvd.bp.narrow80 <- data.frame(cvd.bp.narrow80)


write.csv(cvd.bp.narrow80, file="cvd.bp.narrow80.csv")



data.t1d80 <- data80[data80$T1D_code==1,]

t1d.bp.narrow80 <- table(data.t1d80$ambp150.narrow, data.t1d80$ambp145.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t1d.bp.narrow80 <- data.frame(t1d.bp.narrow80)


write.csv(t1d.bp.narrow80, file="t1d.bp.narrow80.csv")


data.t2d80 <- data80[data80$T2D_code==1,]

t2d.bp.narrow80 <- table(data.t2d80$ambp150.narrow, data.t2d80$ambp145.narrow,
                       useNA = "ifany",
                       dnn = c("under140","under135"))

t2d.bp.narrow80 <- data.frame(t2d.bp.narrow80)


write.csv(t2d.bp.narrow80, file="t2d.bp.narrow80.csv")
