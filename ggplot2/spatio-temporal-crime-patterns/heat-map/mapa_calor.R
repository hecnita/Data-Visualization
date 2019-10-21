### Mapa de calor: Concentración de delitos

# Paquete para dibujar el objeto ráster
install.packages(ggmap)
library(ggmap)

# Caja con los límites del mapa
lat <- c(41.63, 42.03)
long <- c(-87.95, -87.51)
bbox <- make_bbox(long,lat,f=0.05)

# Petición de mapa a servidor Stamen Maps con los límites indicados 
b <- get_map(bbox,maptype="toner-lite",source="stamen")

# Carga fichero .shp con los polígonos correspondientes a las áreas comunitarias
lim.commu.area = readOGR(dsn = "../datos/Chicago", layer = "geo_export_19d85543-9cf6-462c-b00d-44cf71220775")

# Convierte los objetos espaciales a la clase SpatialPolygonsDataFrame para poder
# incrustar las áreas comunitarias en el mapa de calor
pol = fortify(lim.commu.area)

# Mapa de calor
ggmap(b) + 
  geom_density2d(data = datos, aes(x = Longitude, y = Latitude), 
                 size = 0.3) + 
  stat_density2d(data = datos, aes(x = Longitude, y = Latitude, 
                                     fill = ..level.., 
                                     alpha = ..level..), 
                 size = 0.01, bins = 100, geom = "polygon") + 
  scale_fill_gradientn(colours=c(rev(rainbow(100, start=0, end=.7)))) + 
  scale_alpha(range = c(0,0.8)) + 
  geom_map(data = pol, map = pol, 
           aes(x = long, y = lat, map_id = id, group = group), 
           colour = "black", fill = NA, size = 0.5) +
  guides(alpha=FALSE) + 
  labs(x = "longitude", y = "latitude", title = "Concentración de delitos") + 
  theme(legend.title=element_blank())