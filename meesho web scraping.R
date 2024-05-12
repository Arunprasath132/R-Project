
library(rvest)
library(dplyr)
link='https://play.google.com/store/movies'
web=read_html(link)
name=web%>%html_nodes(".DdYX5")%>%html_text()
View(name)
picture=web%>%html_node(.etjhNc)%>%html_text()
View(picture)
amount=web%>%html_node(.ePXqnb)%>%html_text()
View(amount)
movies=data.frame(name,picture,amount)
View(movies)
write.csv(movies,'movie list')