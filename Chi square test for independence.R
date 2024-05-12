#unit 4 - inferential statistics
#Chi-Square test for independence
data <-read.csv("C:\\Users\\SYS73\\Documents\\Nataraj - CSE (DS)\\Heartstroke_data.csv")
View(data)
str(data)
data$hypertension<- as.factor(data$hypertension)
data$heart_disease<- as.factor(data$heart_disease)
data$bmi<-as.numeric(data$bmi)
data$stroke<-as.factor(data$stroke)
str(data)
# apply chi square test
test1<-chisq.test(table(data$hypertension,data$heart_disease))
print(test1)


test2<-chisq.test(table(data$Residence_type,data$hypertension))
print(test2)

test3<-chisq.test(table(data$smoking_status,data$hypertension))
print(test3)






