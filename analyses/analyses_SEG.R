# Analyses de base
options(scipen=9)

seg_bkp <- seg

seg$Amount.m <- seg$Amount / 1e6

# reorder_size <- function(x) {
#   factor(x, levels = names(sort(table(x))))
# }

# TEST: ne fonctionne pas
# gen_histo <- function(df = seg, var_princ, par_var_sec, type = "pdf", titre = "Sectors of DAC support by\n") {
#   graphe <- function(gg)
#     ggplot(gg, aes(x = var_princ)) +
#     geom_bar(aes(weight = Amount.m)) +
#     ggtitle(paste(titre, par_var_sec)) +
#     xlab("DAC2 Purpose Code") +
#     ylab("Million $") +
#     ylim(c(0, 30)) +
#     theme_economist() +
#     scale_colour_economist() +
#     theme(axis.text.x = element_text(angle = 90, hjust = 1))
#   
#   if (type == "pdf") {
#     nom_fichier <- paste0("./analyses/",  make.names(var_princ),   "_par_",  make.names(par_var_sec), ".pdf")
#     pdf(nom_fichier)
#   }
#   
#   if (type == "png") {
#     graphe  + ggsave(sprintf("./analyses/sect_par_type_%s.png", make.names(unique(par_var_sec))))
#     png(height = 400, width = 600)
#   }
#   
#   results <- group_by(df, I(par_var_sec)) %>%
#     do(plot = graphe(.))
#   invisible(lapply(results$plot, print))
#   dev.off()
#   
# }

# Secteurs, DAC2, tous types d'aide confondus
#gen_histo(seg, dac2.N.f,  Aid.type.f, type="pdf")


# Secteurs (DAC2), par type d'aide
png("test.png", height=400, width=600)
g <- ggplot(seg, aes(x = dac2.N.f), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE)) +
  xlab("DAC2 Purpose Code") +
  ylab("Million $") +
  ggtitle("$619 m of SEG disbursements in 2014-15, by high-level sector") +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggsave("./graphiques/total_par_sect.png")
dev.off()


#pdf("graphiques/hist_sect_par_type.pdf")
png("test.png", height=400, width=600)
graphe <- function(gg) ggplot(gg, aes(x = dac2.N.f), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE), width = 0.5) +
  ggtitle(paste("Sectors of SEG support by Aid Type:\n", gg$Aid.type.f)) +
  xlab("DAC2 Purpose Code") +
  ylab("Million $") +
  ylim(c(0, 30)) +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave(sprintf("./graphiques/secteur_par_type/sect_par_type_%s.png",make.names(unique(gg$Aid.type.f))))

results <- group_by(seg, Aid.type.f) %>%
  do(plot = graphe(.))
invisible(lapply(results$plot, print))
dev.off()



# Type d'aide par secteur

# pdf("graphiques/hist_type_par_sect.pdf")
png("test.png", height=400, width=600)

graphe <- function(gg) ggplot(gg, aes(x = Aid.type.f), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE), width = 0.5) +
  ggtitle(paste("Type of aid by sector: ", gg$dac2.Name)) +
  xlab("Type of aid") +
  ylab("Million $") +
  ylim(c(0, 30)) +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave(sprintf("./graphiques/type_par_secteur/type_par_sect_%s.png", make.names(unique(gg$dac2.N.f)))) #pour png

results <- group_by(seg, dac2.N.f) %>%
  do(plot = graphe(.))
invisible(lapply(results$plot, print))
dev.off()
