library(tidyverse)
library(stringr)
library(tidytext)
library(harrypotter)
library(textdata)

#sentiment dataset
View(sentiments)

#lexicons
get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

View(get_sentiments("afinn"))
View(get_sentiments("bing"))
View(get_sentiments("nrc"))

#books name 
titles <- c("Philosopher's Stone", "Chamber of secrets","Prisoner of Azkaban","Goblet of Fire","Order of the Phoenix","Half-Blood Prince","DEATHLY HALLOWS")

titles

# Books List

books <- list(philosophers_stone,chamber_of_secrets,prisoner_of_azkaban,goblet_of_fire,order_of_the_phoenix,half_blood_prince,deathly_hallows)

View(books)

#Tibbling & unnest tokens for all books

series <- tibble()


for(i in seq_along(titles))
{
  clean <- tibble(chapter= seq_along(books[[i]]),text =books [[i]]) %>%
    unnest_tokens(word,text) %>% mutate(book = titles[i]) %>%
    select(book,everything())
  series <- rbind(series,clean)}
View(clean)
View(series) 


senti <- series %>% right_joint(get_sentiments("nrc")) %>% filter(!is.na(sentiment)) %>%
  count(sentiment,sort = TRUE)
View(senti)

#visualise sentiment across each book 
series %>% group_by(book) %>%
  mutate(word_count = 1:n(), index = word_count %/% 500+1) %>%
  inner_join(get_sentiments("bing")) %>% 
  count(book, index = index,sentiment) %>% ungroup() %>%
  spread(sentiment,n, fill = 0) %>% 
  mutate(sentiment = positive - negative,
         book = factor(book, levels = titles)) %>%
  ggplot(aes(index, sentiment, fill = book)) + 
  geom_bar(alpha = 0.5,stat = "identity", show.legend=FALSE) +
  facet_wrap(~book,ncol = 2,scales="free_x")

#comparing sentiments

afinn <- series %>% group_by(book) %>% mutate(word_count = 1:n(),
                                              index = word_count %/% 500 + 1) %>%
  inner_join(get_sentiments("afinn")) %>% group_by(book, index) %>% 
  summarise(sentiment= sum(value)) %>% mutate(method = "AFINN")
View(afinn)

bing_and_nrc <- bind_rows(series %>% group_by(book) %>% 
                            mutate(word_count = 1:n(), index = word_count %/% 500 + 1) %>%
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method = "Bing"),series %>% group_by(book) %>%
                            mutate(word_count = 1:n(),index = word_count %/% 500+1) %>%
                            inner_join(get_sentiments("nrc") %>%
                                         filter(sentiment %in% c("positibve","negative"))) %>%
                            mutate(method = "NRC")) %>% 
  count(book,method, index = index, sentiment) %>% 
  ungroup() %>% spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  select(book, index, method, sentiment).
View(bing_and_nrc)

bind_rows(afinn, bing_and_nrc) %>% ungroup() %>% 
  mutate(book = factor(book, levels =titles)) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_bar(alpha = 0.8,stat = "identity", show.legend = FALSE) +
  facet_grid(book ~ method)

bing_word_counts <- series %>% inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>% ungroup()
View(bing_word_counts)

bing_word_counts %>% group_by(sentiment) %>% top_n(10) %>% 
  ggplot(aes(record(word, n),n,fill = sentiment)) +
  geom_bar(alpha = 0.8,stat = "identity",show.leghend = FALSE) +
  facet_wrap(~sentiment,scales = "free_y") +
  labs(y = " contribution to sentiment", x = NULL) + coord_flip()