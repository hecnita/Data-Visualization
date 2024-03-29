#Gr�fico de l�neas: evoluci�n de los delitos

datos %>%  
  mutate(year = year(Date)) %>% 
  group_by(year) %>% 
  summarise(
    n = n()
  ) %>%
  ggplot(aes(year, n)) + 
  geom_line() + 
  scale_x_continuous(breaks = pretty(seq(2001, 2018), n = 9)) + 
  xlab("") + ylab("") + 
  ggtitle("Evoluci�n de los delitos")