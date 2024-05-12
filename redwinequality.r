library("ggplot2")
library("dplyr")
library("gridExtra")
library(GGally)
library(memisc)
library(pander)
library(corrplot)

wine= read.csv("C:\\Users\\Arun\\Documents\\winequality-red.csv")
View(wine)


wine$quality <- factor(wine$quality, ordered = T)



wine$rating <- ifelse(wine$quality < 5, 'bad', ifelse(
  wine$quality < 7, 'average', 'good'))

wine$rating <- ordered(wine$rating,
                       levels = c('bad', 'average', 'good'))