#Rejilla de color: Patrón horario y semanal

datos %>% 
  mutate(hour = hour(Date), wday = wday(Date, label = TRUE, abbr = FALSE)) %>% 
  group_by(hour, wday) %>% 
  summarise(
    n = n()
  ) %>% 
  ggplot(aes(x = hour, y = wday, fill = n)) + 
  geom_tile() + 
  scale_x_continuous(breaks = pretty(hour(muestra$Date), n = 9)) + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       name = "") + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.background = element_blank()) + 
  xlab("") + ylab("") + 
  ggtitle("")