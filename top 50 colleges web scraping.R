library(rvest)
library(dplyr)
link='https://www.edudwar.com/top-and-best-schools-in-india/'
web=read_html(link)
schoolname=web%>%html_nodes(".grippy-host , a strong , .tp_btn_default")%>%html_text()
View(schoolname)
affiliation=web%>%html_node("ol+ p")%>%html_text()
View(affiliation)
affiliation=web%>%html_node("ol+ p")%>%html_text()
View(affiliation)
schools=data.frame(schoolname,affiliation)
View(schools)
write.csv(collegs,'top 30 school.csv')

