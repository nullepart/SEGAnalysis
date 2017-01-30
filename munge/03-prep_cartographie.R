# Téléchargement des données WDI

cache_wdi <- WDIcache()
save(cache_wdi, file = "./data/cache_wdi.RData")

# Téléchargement des cartes

SPATIALDATA <- paste0(getwd(), "/SpatialData")
dir.create(SPATIALDATA, recursive = TRUE)
setSpatialDataDir(SPATIALDATA)
convertTMWorldBordersSimple()
rm(SPATIALDATA)