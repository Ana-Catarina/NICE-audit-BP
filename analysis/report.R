library('tidyverse')

df_input <- read_csv(
  here::here("output", "input.csv"),
  col_types = cols(patient_id = col_integer(),age = col_double())
)

head(df_input)

df_input$age_c <- ifelse(df_input$age<80,1,0)

data <- df_input[df_input$age_c==1,]

data80 <- df_input[df_input$age_c==0,]

summary(df_input$age_c)

class(df_input$age_c)


## under 80

summary(data$last_systolic_bp_measure)

summary(data$last_ambulatory_systolic_bp_measure)

summary(data$last_ambulatory_systolic_bp_measure_narrow)

data$bp140 <- ifelse(data$last_ambulatory_systolic_bp_measure<140,1,0)

data$ambp140 <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<140,1,0)

data$ambp135 <- ifelse(data$last_ambulatory_systolic_bp_measure_narrow<135,1,0)

summary(as.factor(data$ambp140))

summary(as.factor(data$ambp135))

summary(as.factor(data$bp140))


## over 80

summary(data80$last_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure)

summary(data80$last_ambulatory_systolic_bp_measure_narrow)

data80$bp150 <- ifelse(data80$last_ambulatory_systolic_bp_measure<150,1,0)

data80$ambp150 <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<150,1,0)

data80$ambp145 <- ifelse(data80$last_ambulatory_systolic_bp_measure_narrow<145,1,0)

summary(as.factor(data80$ambp150))

summary(as.factor(data80$ambp145))

summary(as.factor(data80$bp150))

