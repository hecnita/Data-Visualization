### Histograma con la distribución de delitos por coordenadas sin outliers

# Se eliminan los valores atípicos en base a la latitud
datos_sin_outliers <- datos %>% 
  filter(between(Latitude, 41, 43))

# Histograma en función de la latitud
distr_lan = ggplot(datos_sin_outliers, aes(x = Latitude, y = ..density..)) + 
  geom_histogram(binwidth = 0.005, fill = "grey", colour = "grey60", size = .2) + 
  geom_density(colour = "blue", size = 0.6) + 
  xlim(41.6, 42.1) + 
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank()) + 
  ylab("")

# Histograma en función de la longitud
distr_lon = ggplot(datos_sin_outliers, aes(x = Longitude, y = ..density..)) + 
  geom_histogram(binwidth = 0.005, fill = "grey", colour = "grey60", size = .2) + 
  geom_density(colour = "blue", size = 0.6) + 
  xlim(-87.95, -87.5) + 
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank()) + 
  ylab("")

# Paquetes para dibujar el lienzo
install.packages(grid)
install.packages(gridExtra)
library(grid)
library(gridExtra)

# Lienzo con ambos histogramas
grid.arrange(distr_lan, distr_lon, ncol = 2, top = "Distribución de delitos por coordenadas")