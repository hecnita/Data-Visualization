### Gráficos de línea, multivariante: Delitos por hora y tipología

# Paquete para manipulación de fechas
install.packages(lubridate)
library(lubridate)

# Lienzo con todas las gráficas
datos %>%  
  mutate(hour = hour(Date)) %>% 
  group_by(hour, `Type of crime`) %>% 
  summarise(
    n = n()
  ) %>%
  ggplot(aes(hour, n)) + 
  geom_line() + 
  facet_wrap(~ `Type of crime`) + 
  ylab("") + xlab("hora") + 
  ggtitle("Delitos por hora y tipología")