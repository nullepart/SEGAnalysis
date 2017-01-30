# Cartographie des interventions SEG

# D'abord, créer un code ISO3

z <- sort(unique(seg$Country))
z <- data.frame(Country = z, ISO3 = NA)
z$ISO3 <- countrycode(z$Country, "country.name", "iso3c")


# 7 données manquent (dont celles de 3 continents, qu'on ne remplacera pas)

z %>% filter(is.na(ISO3))
z <- as.tbl(z)
z[z$Country == "Equatorial Guin", "ISO3"] <- "GNQ"
z[z$Country == "Kosovo", "ISO3"] <- "KOS" # ATTENTION: Kosovo n'existe pas ds ISO3
z[z$Country == "S.Tome Principe", "ISO3"] <- "STP"


# Prep sous-ensemble des données: 

df <- seg %>% 
  group_by(Country) %>%
  select(Country, Amount.m) %>% 
  summarize(Amount.m = sum(Amount.m))
df <- left_join(df, z)
df <- df %>% filter(!is.na(ISO3))


# Prep données géo

setSpatialDataDir(SPATIALDATA <- paste0(getwd(), "/SpatialData"))
loadSpatialData("TMWorldBordersSimple")
monde <- TMWorldBordersSimple
afr <- TMWorldBordersSimple
afr@data <- afr@data %>% filter(UN_region == 2) 
afr@data <-left_join(afr@data, df)


# Entrer les données dans des catégories ("cat") de dépenses
# puis les combiner avec données spatiales

breaks <- c(0, 5, 10, 15, max(df$Amount.m))
lab <- c("<5", "5-10", "10-15", "15+")
df$cat <-cut(df$Amount.m, breaks = breaks, labels = lab, include.lowest = T)
monde@data <-left_join(monde@data, df)
monde@data[is.na(monde@data$Amount.m), "ISO3"] <- NA
monde@data[monde@data$cat == "<5" | is.na(monde@data$cat), "cat"] <- NA
monde@data[monde@data$cat == "<5" | is.na(monde@data$cat), "ISO3"] <- NA
monde@data$cat <- droplevels.factor(monde@data$cat)



# Carte

png("carte_decaissements_SEG.png", height=450, width=900)
qtm(shp = monde, fill = "cat", text = "ISO3", text.size = 1, text.color = "Black", fill.palette = "YlOrRd", fill.title = "SEG Disbursements over 5 m in 2014-15")
dev.off()



