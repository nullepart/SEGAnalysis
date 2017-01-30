
# Recodage du type d'aide
seg[seg$Aid.type.f %in% c("Contrib. to specific-\npurpose prog.", "Sector budget\nsupport", "GBS", "Basket funds"), "Aid.type.f"] <- "Multi-donor project"
seg[seg$Aid.type.f %in% c("Other TA", "Donor Country\npersonnel"), "Aid.type.f"] <- "TA"
seg[seg$Aid.type.f %in% c("Core contrib. to\nmulti.institutions", "Core support to NGOs, etc."), "Aid.type.f"] <- "Core support"

# Recoder EFH

EFH <- unique(seg$Gender.Equality)
EFH <- data.frame(Gender.Equality = EFH, GE = NA)
EFH$GE <- c("0-Not integrated", "1-Limited", "2-GE Integrated", "3-GE-specific init.")

seg <- left_join(seg, EFH)
rm(EFH)


# Recoder Sector.Name

seg <- seg %>% 
  mutate(Sector.Name = paste("(", Sector, ") ", Sector.Name, sep = ""))


# Recoder Trade.development -- Nota: il y a un seul "Uncoded": éliminer

seg[seg$Trade.development == "Uncoded", "Trade.development"] <- "Not Targeted"
Trade <- unique(seg$Trade.development)
Trade <- data.frame(Trade.development = Trade, Trade = NA)
Trade$Trade <- c("0-Not Targeted", "1-Significant", "2-Principal")

seg <- left_join(seg, Trade)
rm(Trade)

# Recoder ICT.for.dev

seg[seg$ICT.for.dev == "Uncoded", "ICT.for.dev"] <- "Not Targeted"
ICT <- unique(seg$ICT.for.dev)
ICT <- data.frame(ICT.for.dev = ICT, ICT = NA)
ICT$ICT <- c("0-Not Targeted", "1-Significant", "2-Principal")

seg <- left_join(seg, ICT)
rm(ICT)

# Recoder Environment.sust

Env <- unique(seg$Environmental.sust)
Env <- data.frame(Environmental.sust = Env, Env = NA)
Env$Env <- c("0-Not Targeted", "1-Significant", "2-Principal")

seg <- left_join(seg, Env)
rm(Env)

# Recoder Youth.issues

seg[seg$Youth.issues == "Uncoded", "Youth.issues"] <- "Not Targeted"
Youth <- unique(seg$Youth.issues)
Youth <- data.frame(Youth.issues = Youth, Youth = NA)
Youth$Youth <- c("0-Not Targeted", "1-Significant", "2-Principal")

seg <- left_join(seg, Youth)
rm(Youth)


# Recoder Urban.issues

seg[seg$Urban.issues == "Uncoded", "Urban.issues"] <- "Not Targeted"
Urban <- unique(seg$Urban.issues)
Urban <- data.frame(Environmental.sust = Urban, Urban = NA)
Urban$Urban <- c("0-Not Targeted", "1-Significant", "2-Principal")

seg <- left_join(seg, Urban)
rm(Urban)



# Écrire le fichier

write.csv(seg, "./data/seg.csv")
