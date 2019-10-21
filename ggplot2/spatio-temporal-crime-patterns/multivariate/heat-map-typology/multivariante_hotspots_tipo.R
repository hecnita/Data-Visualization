### Múltiples mapas de calor: Concentración de delitos por tipología

# ¡Es necesario el código implementado antes de dibujar el mapa de calor ubicado en mapa_calor!

ggmap(b) + 
  geom_map(data = pol, map = pol, 
           aes(x = long, y = lat, map_id = id, group = group), 
           colour = "black", fill = NA, size = 0.5) + 
  facet_wrap(~`Type of crime`) +
  stat_density2d(data = datos, aes(x = Longitude, y = Latitude, 
                                     fill = ..level.., 
                                     alpha = ..level..), 
                 size = 0.1, bins = 1000, geom = "polygon") + 
  scale_fill_gradientn(colours=c(rev(rainbow(100, start=0, end=.7)))) + 
  scale_alpha(range = c(0,0.8)) + 
  scale_x_continuous(breaks = pretty(muestra$Longitude, n = 2)) +
  guides(alpha=FALSE) + 
  labs(x = "longitude", y = "latitude", title = "Concentración de delitos por tipología")