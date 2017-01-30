seg <- read.csv("./data/portefeuille.2014.15.csv")

# 1. Préparation des données du CAD

nouv_noms <- c("id", "dac2", "dac2.Name", "dac3", "dac3.Name", "dac5", 
               "dac5.voluntary.code", "dac5.Name", "comment")
names(dac) <- nouv_noms
rm(nouv_noms)

dac$dac2.Name <- str_to_title(dac$dac2.Name)
dac$dac3.Name <- str_to_title(dac$dac3.Name)
dac$dac5.Name <- str_to_title(dac$dac5.Name)


# Les données DAC2 n'existent pas formellement: elles sont constituées des deux premiers
# chiffres des codes CAD5. Dans la majorité des cas, elles peuvent être inférées à partir 
# du chapeau d'un groupe de code DAC3 -- par exemple, 11 pour ÉDUCATION (chapeautant 110 à 
# 119). Dans certains cas, elles ont été reconstituées de la même manière, mais sans que le
# chapeau ne soit explicite. C'est le cas de Agriculture, Forestry & Fisheries.

df.dac2 <- dac %>% select(dac2, dac2.Name)
df.dac2 <- unique(df.dac2)
df.dac2 <- df.dac2 %>% filter(dac2 < 100)  # Pour remédier à une erreur


# Raccourcir les définitions des codes et les formater pour ggplot2
df.dac2$dac2.N.f <- c("Education", "Health", 
                      "Pop. Policies &\nReproductive Health", 
                      "Water & San.", "Gov.\nCivil Soc.", 
                      "Other Social Infrastr.\n& Services",
                      "Transport & Storage", "Comms", "Energy", "Financial Serv.", 
                      "Business &\nOther Services", "Ag., Forestry\n& Fishing", 
                      "Industry, Mining,\n& Construction", "Trade & Tourism", 
                      "Env. Protection", "Multisector", "GBS",
                      "Food Aid\nFood Security", "Other Commodity\nAssistance", "Debt Relief",
                      "Emergency\nResponse", "Reconstr. Relief\n&Rehab.", "Disaster\nPrevention", 
                      "Donor Admin.\nCosts", "Refugees In\nDonor Countries", "Unallocated\nUnspecified")

write.csv(df.dac2, "./data/df.dac2.csv")

# Les données DAC3 sont celles fournies par le site du CAD, à l'exception des grands
# titres (SANTÉ, ÉDUCATION), qui apparaissent en majuscules dans le document
# du CAD et qui correspondent généralement à des catégories du deuxième niveau -- DAC2. 

df.dac3 <- dac %>% select(dac3, dac3.Name)
df.dac3 <- unique(df.dac3)
write.csv(df.dac3, "./data/df.dac3.csv")


# Racourcir les définitions des codes Aid.Type et les formater pour ggplot2

atf <- data.frame(Aid.Type = as.character(), Aid.Type.f = as.character())
atf1 <- unique(seg$Aid.Type)
atf2 <- c("Basket funds", "Contrib. to specific-\npurpose prog.", "Core contrib. to\nmulti.institutions", 
          "Core support to NGOs, etc.", "Donor Country\npersonnel", "GBS", 
          "Other TA", "Project-Type\ninterventions", "Scholarships/Training\nin donor country", 
          "Sector budget\nsupport")
atf <- as.data.frame(cbind(sort(atf1), sort(atf2)))
names(atf) <- c("Aid.Type", "Aid.Type.f")

write.csv(atf, "./data/atf.csv")
rm(atf1)
rm(atf2)


# Intégrer Aide.Type.f formatté à portefeuille
seg <- left_join(seg, atf)
rm(atf)


# DAC5

df.dac5 <- dac %>% select(dac5, dac5.Name)
df.dac5 <- unique(df.dac5)
write.csv(df.dac5, "./data/df.dac5.csv")


# Intégrer ces codes au tableau seg
# Pour dac2, on ne garde qque les 2 premiers chiffres de Sector
# pour dac 3, les 3 premiers chiffres

seg <- as.tbl(seg)
seg$dac3 <- as.integer(str_sub(seg$Sector, 1, 3))
seg <- left_join(seg, df.dac3)
seg$dac2 <- as.integer(str_sub(seg$Sector, 1, 2))
seg <- left_join(seg, df.dac2)


# Rajouter les numéros de code devant les noms DAC 2 et 3
seg <- seg %>% 
  mutate(dac2.Name = paste("(", dac2, ") ", dac2.Name, sep = ""))
seg <- seg %>% 
  mutate(dac2.N.f = paste("(", dac2, ") ", dac2.N.f, sep = ""))
seg <- seg %>% 
  mutate(dac3.Name = paste("(", dac3, ") ", dac3.Name, sep = ""))


## Renommer les variables

nouv_noms <- c("Branch", "Branch.Name", "Division", "Division.Name", "Section", 
  "Section.Name", "Fund.Centre", "Fund.Centre.Name", "Authority.Code", 
  "Fund", "Fund.Name", "Business.Deliv.Model", "Investment.Type", 
  "Aid.Type", "Selection.Mechanism", "WBS", "Title", "Sector", 
  "Sector.Name", "Sector.pct", "Country.Code", "Country", "Country.pct", 
  "Francophonie", "Gender.Equality", "Amount", "Environmental.sust", 
  "Climate.Change.Adaptation", "Climate.change.mitigation", "Desertification", 
  "Biodiversity", "Participatory.dev.and.gov", 
  "Trade.development", "Childrens.issues", "Youth.issues", "Disability.issues", 
  "Indigenous.issues", "Urban.issues", "ICT.for.dev", 
  "Knowledge.for.dev", "Aid.type.f", "dac3", "dac3.Name", "dac2", "dac2.Name", "dac2.N.f"
  )
names(seg) <- nouv_noms


# Rajouter les Montants par millions

seg$Amount.m <- seg$Amount / 1e6

write.csv(seg, "./data/seg.csv")

