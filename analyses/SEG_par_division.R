# Type d'aide par branche

#pdf("graphiques/hist_type_par_division.pdf")
png("test.png", height=400, width=600)

g1 <- ggplot(seg, aes(x = Branch.Name)) +
  geom_bar(aes(weight = Amount.m)) +
  xlab("Branch") +
  ylab("Million $") +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

g2 <- ggplot(seg, aes(x = Division.Name)) +
  geom_bar(aes(weight = Amount.m)) +
  xlab("Divisions") +
  ylab("Million $") +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

graphe_branch <- function(gg) ggplot(gg, aes(x = dac2.N.f)) +
  geom_bar(aes(weight = Amount.m)) +
  ggtitle(paste(gg$Branch.Name, "by Sector")) +
  xlab("Type of aid") +
  ylab("Million $") +
  ylim(c(0, 30)) +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave(sprintf("./graphiques/type_par_branche_%s.png", make.names(unique(gg$Branch.Name)))) #pour png


graphe_div <- function(gg) ggplot(gg, aes(x = dac2.N.f)) +
  geom_bar(aes(weight = Amount.m)) +
  ggtitle(paste(gg$Division.Name, "by Sector")) +
  xlab("Type of aid") +
  ylab("Million $") +
  ylim(c(0, 30)) +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave(sprintf("./graphiques/type_par_div_%s.png", make.names(unique(gg$Division.Name)))) #pour png

plot(g1)
plot(g2)

results_branch <- group_by(seg, Branch.Name) %>%
  do(plot = graphe_branch(.))
invisible(lapply(results_branch$plot, print))

results_div <- group_by(seg, Division.Name) %>%
  do(plot = graphe_div(.))
invisible(lapply(results_div$plot, print))

dev.off()