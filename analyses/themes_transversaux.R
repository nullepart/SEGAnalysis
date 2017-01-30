# GE par type d'aide

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Aid.type.f), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE), width = 0.5) +
  xlab("Aid type") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by aid type") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/GE&Aid_Type.png")
dev.off()


# GE par branche

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Branch.Name), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE), width = 0.5) +
  xlab("Branch") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: GE by Branch") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/GE&Branch.png")
dev.off()


# GE total -- waffle

temp <- seg %>% group_by(GE) %>% summarise(total = sum(Amount.m)) %>% 
  as.data.frame(.)
parts <- temp[, 2] %>% as.numeric(.)
somme <- sum(temp[, 2])
noms <- paste0(temp[, 1], ": ", 100 * round(temp[, 2]/somme, 2), "%")
names(parts) <- noms

png("graphiques/themes_transversaux/GE_waffle.png", height=400, width=600)
waffle(parts, rows=20, title = "Breakdown of SEG budget by GE integration status")
# print(chart)
dev.off()
rm(noms)
rm(temp)
rm(parts)


# Env par type d'aide

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Aid.type.f), colour = Env) +
  geom_bar(aes(weight = Amount.m, fill = Env), width = 0.5) +
  xlab("Aid type") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by aid type & Env. sustainability") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Env&Aid_Type.png")
dev.off()


# Env par branche

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Branch.Name), colour = Env) +
  geom_bar(aes(weight = Amount.m, fill = Env), width = 0.5) +
  xlab("Branch") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Env by Branch") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Env&Branch.png")
dev.off()


# Env total -- waffle

temp <- seg %>% group_by(Env) %>% summarise(total = sum(Amount.m)) %>% 
  as.data.frame(.)
parts <- temp[, 2] %>% as.numeric(.)
somme <- sum(temp[, 2])
noms <- paste0(temp[, 1], ": ", 100 * round(temp[, 2]/somme, 2), "%")
names(parts) <- noms

png("graphiques/themes_transversaux/Env_waffle.png", height=400, width=600)
waffle(parts, rows=20, title = "Breakdown of SEG budget by Env integration status")
dev.off()
rm(noms)
rm(temp)
rm(parts)

# Env par DAC2

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = dac2.N.f), colour = Env) +
  geom_bar(aes(weight = Amount.m, fill = Env), width = 0.5) +
  xlab("Sector (DAC2)") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Env by DAC2 sector") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Env&DAC2_Sector.png")
dev.off()


# ICT par type d'aide

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Aid.type.f), colour = ICT) +
  geom_bar(aes(weight = Amount.m, fill = ICT), width = 0.5) +
  xlab("Aid type") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by aid type & ICT integration") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/ICT&Aid_Type.png")
dev.off()


# ICT par branche

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Branch.Name), colour = ICT) +
  geom_bar(aes(weight = Amount.m, fill = ICT), width = 0.5) +
  xlab("Branch") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: ICT by Branch") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/ICT&Branch.png")
dev.off()


# ICT total -- waffle

temp <- seg %>% group_by(ICT) %>% summarise(total = sum(Amount.m)) %>% 
  as.data.frame(.)
parts <- temp[, 2] %>% as.numeric(.)
somme <- sum(temp[, 2])
noms <- paste0(temp[, 1], ": ", 100 * round(temp[, 2]/somme, 2), "%")
names(parts) <- noms

png("graphiques/themes_transversaux/ICT_waffle.png", height=400, width=600)
waffle(parts, rows=20, title = "Breakdown of SEG budget by ICT integration status")
dev.off()
rm(noms)
rm(temp)
rm(parts)

# ICT par DAC2

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = dac2.N.f), colour = ICT) +
  geom_bar(aes(weight = Amount.m, fill = ICT), width = 0.5) +
  xlab("Sector (DAC2") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: ICT by DAC2 sector") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/ICT&DAC2_Sector.png")
dev.off()

# Trade


# Trade par type d'aide

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Aid.type.f), colour = Trade) +
  geom_bar(aes(weight = Amount.m, fill = Trade), width = 0.5) +
  xlab("Aid type") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by aid type & Trade integration") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Trade&Aid_Type.png")
dev.off()


# Trade par branche

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Branch.Name), colour = Trade) +
  geom_bar(aes(weight = Amount.m, fill = Trade), width = 0.5) +
  xlab("Branch") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Trade support by Branch") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Trade&Branch.png")
dev.off()


# Trade total -- waffle

temp <- seg %>% group_by(Trade) %>% summarise(total = sum(Amount.m)) %>% 
  as.data.frame(.)
parts <- temp[, 2] %>% as.numeric(.)
somme <- sum(temp[, 2])
noms <- paste0(temp[, 1], ": ", 100 * round(temp[, 2]/somme, 2), "%")
names(parts) <- noms

png("graphiques/themes_transversaux/Trade_waffle.png", height=400, width=600)
waffle(parts, rows=20, title = "Breakdown of SEG budget by Trade integration status")
dev.off()
rm(noms)
rm(temp)
rm(parts)

# Trade par DAC2

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = dac2.N.f), colour = Trade) +
  geom_bar(aes(weight = Amount.m, fill = Trade), width = 0.5) +
  xlab("Sector (DAC2") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Trade by DAC2 sector") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Trade&DAC2_Sector.png")
dev.off()

# Urban issues


# Urban par type d'aide

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Aid.type.f), colour = Urban) +
  geom_bar(aes(weight = Amount.m, fill = Urban), width = 0.5) +
  xlab("Aid type") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by aid type & Urban integration") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Urban&Aid_Type.png")
dev.off()


# Urban par branche

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = Branch.Name), colour = Urban) +
  geom_bar(aes(weight = Amount.m, fill = Urban), width = 0.5) +
  xlab("Branch") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Urban support by Branch") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Urban&Branch.png")
dev.off()


# Urban total -- waffle

temp <- seg %>% group_by(Urban) %>% summarise(total = sum(Amount.m)) %>% 
  as.data.frame(.)
parts <- temp[, 2] %>% as.numeric(.)
somme <- sum(temp[, 2])
noms <- paste0(temp[, 1], ": ", 100 * round(temp[, 2]/somme, 2), "%")
names(parts) <- noms

png("graphiques/themes_transversaux/Urban_waffle.png", height=400, width=600)
waffle(parts, rows=20, title = "Breakdown of SEG budget by Urban integration status")
dev.off()
rm(noms)
rm(temp)
rm(parts)

# Urban par DAC2

png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = dac2.N.f), colour = Urban) +
  geom_bar(aes(weight = Amount.m, fill = Urban), width = 0.5) +
  xlab("Sector (DAC2") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15: Urban by DAC2 sector") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("./graphiques/themes_transversaux/Urban&DAC2_Sector.png")
dev.off()
