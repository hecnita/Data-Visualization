#Gráfico de líneas: evolución de los delitos

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
  ggtitle("Evolución de los delitos")