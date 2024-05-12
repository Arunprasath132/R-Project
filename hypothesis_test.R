x1<-c(16.2,25.4,21,21.1,27.7,21.6)
x2<-c(39.2,41.2,32.6,24.8,29.5,39.8)
data<-data.frame(site=rep(c("urban","rural"),
                          each=6),
                 weight=c(x1,x2))
print(data)
library(car)
leveneTest(weight~site,data)
t.test(data$weight~data$site,
       alternative="two.side",
       mu=0,
       paired=FALSE,
       var.equal=TRUE,
       conf.level=0.95)





x1<-c(16.2,25.4,21,21.1,27.7,21.6)
x2<-c(39.2,41.2,32.6,24.8,29.5,39.8)
data<-data.frame(site=rep(c("urban","rural"),
                          each=6),
                 weight=c(x1,x2))
print(data)
library(car)
leveneTest(weight~site,data)
t.test(data$weight~data$site,
       alternative="greater",
       mu=0,
       paired=FALSE,
       var.equal=TRUE,
       conf.level=0.95)



x1<-c(16.2,25.4,21,21.1,27.7,21.6)
x2<-c(39.2,41.2,32.6,24.8,29.5,39.8)
data<-data.frame(site=rep(c("urban","rural"),
                          each=6),
                 weight=c(x1,x2))
print(data)
library(car)
leveneTest(weight~site,data)
t.test(data$weight~data$site,
       alternative="less",
       mu=0,
       paired=FALSE,
       var.equal=TRUE,
       conf.level=0.95)
