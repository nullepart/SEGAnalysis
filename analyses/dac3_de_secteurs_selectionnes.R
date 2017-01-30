# Analyses plus fines de certains secteurs
# On exclut les core contributions et on ne garde que qq secteurs

# dac2 <- seg %>% select(dac2, dac2.Name) %>% unique(.)
df <- seg %>% filter(Aid.type.f != "Core support") %>%
  filter(dac2 %in% c(11, 15, 21, 24, 25, 32))

sum(df$Amount.m) # Il ne reste que 289 m $


g <- ggplot(df, aes(x = Sector.Name), colour = GE)
g + geom_bar(aes(weight = Amount.m, fill = GE), width = 0.5) +
  ggtitle(paste("Selected sectors of intervention (excl. core contributions): $289 m")) +
  xlab("DAC5 Sector") +
  ylab("Million $") +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 30)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("graphiques/dac5/dac5_total.png")
  



# Secteurs (DAC5), regroupés par DAC2
png("test.png", height=400, width=600)
#pdf("./graphiques/DAC3_EFG_secteurs_selectionnes.pdf")
graphe <- function(gg) ggplot(gg, aes(x = Sector.Name), colour = GE) +
  geom_bar(aes(weight = Amount.m, fill = GE)) +
  ggtitle(paste("Selected sectors of intervention, excluding core contributions\nSector:", gg$dac2.Name)) +
  xlab("Sector (DAC5)") +
  ylab("Million $") +
  ylim(c(0, 40)) +
  theme_economist() +
  scale_colour_economist() +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave(sprintf("./graphiques/dac5/dac5_%s.png", make.names(unique(gg$dac2.N.f)))) #pour png 

results <- group_by(df,dac2.Name) %>%
  do(plot = graphe(.))
invisible(lapply(results$plot, print))
dev.off