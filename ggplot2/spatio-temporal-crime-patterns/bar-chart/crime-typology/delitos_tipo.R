#Gráfico de barras: tipología del delito

datos_limpios %>%
  filter(!is.na(`Type of crime`)) %>% 
  mutate(`Type of crime` = `Type of crime` %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(x = `Type of crime`)) + 
  geom_bar() + 
  scale_y_continuous(limits = c(0, 1500000)) +
  coord_flip() + 
  xlab("") + ylab("") + 
  ggtitle("Tipo de delito") + 
  theme_classic() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank())