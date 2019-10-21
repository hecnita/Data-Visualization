#Gráfico de barras: Descripción del lugar

datos %>% 
  filter(`Location Description` %in% c("STREET", "RESIDENCE", "APARTMENT", "SIDEWALK", 
                                       "OTHER", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", 
                                       "SCHOOL, PUBLIC, BUILDING", "RESIDENCE-GARAGE", 
                                       "SMALL RETAIL STORE", "RESIDENCE PORCH/HALLWAY", 
                                       "VEHICLE NON-COMMERCIAL", "RESTAURANT", 
                                       "GROCERY FOOD STORE", "DEPARTMENT STORE", 
                                       "RESIDENTIAL YARD (FRONT/BACK)", "GAS STATION", 
                                       "PARK PROPERTY", "COMMERCIAL / BUSINESS OFFICE", 
                                       "CHA PARKING LOT/GROUNDS", "BAR OR TAVERN",
                                       "CTA PLATFORM", "CHA APARTMENT", 
                                       "HOTEL/MOTEL", "SCHOOL, PUBLIC, GROUNDS", 
                                       "DRUG STORE", "BANK", 
                                       "CTA TRAIN", "VACANT LOT/LAND", 
                                       "CTA BUS")) %>% 
  filter(!is.na(`Location Description`)) %>% 
  mutate(`Location Description` = `Location Description` %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(x = `Location Description`)) + 
  geom_bar(aes(y = ..count..)) + 
  coord_flip() + 
  xlab("") + ylab("") + 
  ggtitle("Descripción de lugar") + 
  theme_classic() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank())