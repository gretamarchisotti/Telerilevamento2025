# R code for classifying images

install.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)
# Già osservando questa immagine, notiamo che c'è stata un'ampia deforestazione

# Per capire quanto esattamente abbiamo perso di foresta, classifichiamo inizialmente l'immagine per vedere quanta foresta abbiamo
mato1992c = im.classify(mato1992, num_clusters=2) # La foresta è gialla (class 1 = forest), mentre il blu rappresenta il suolo nudo e il fiume (class 2 = human)
mato2006c = im.classify(mato2006, num_clusters=2) # La foresta è gialla (class 1 = forest), mentre il blu rappresenta il suolo nudo e il fiume (class 2 = human)

# Possiamo ora calcolare le frequenze nell'immagine, cioè il numero di volte che abbiamo una certa classe
f1992 = freq(mato1992c)
f1992 # 1495563 pixel di foresta e 304437 pixel di umano

# Calcoliamo una percentuale
tot1992 = ncell(mato1992c)
prop1992 = f1992/tot1992
prop1992 # Ci interessa la colonna count: 0.8308683 per la foresta, 0.1691317 per l'umano
perc1992 = prop1992*100
perc1992 # Percentages: forest = 83% and human = 17%

perc2006 = freq(mato2006c)*100/ncell(mato2006c)
perc2006 # Percentages: forest = 45% and human = 55%

# Creiamo delle tabelle
class = c("Forest", "Human")
y1992 = c(83,17)
y2006 = c(45,55)
tabout = data.frame(class,y1992,y2006)
tabout

# Creiamo un grafico
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

# Mettiamo i due grafici uno accanto all'altro e aggiustiamo le scale
p1 = ggplot(tabout, aes(x=class, y=y1992, fill=class, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 = ggplot(tabout, aes(x=class, y=y2006, fill=class, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

# Invertiamo gli assi e inseriamo i grafici uno sopra l'altro
p1 = ggplot(tabout, aes(x=class, y=y1992, fill=class, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) +
 coord_flip()
p2 = ggplot(tabout, aes(x=class, y=y2006, fill=class, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) +
 coord_flip()
p1 / p2

classall = c("Forest1992","Human1992","Forest2006","Human2006")
percentage = c(83,17,45,55)
all = data.frame(classall, percentage)

# Stacked barplot with multiple groups
ggplot(data=all, aes(x=classall, y=percentage, color=classall)) +
  geom_bar(stat="identity", fill="white")

#----- Solar Orbiter

im.list()

solar = im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# Classification of the image in three classes
solar_c = im.classify(solar, num_clusters=3)

im.multiframe(1,2)
plot(solar)
plot(solar_c)

# Class 1 = low energy
# Class 2 = medium energy
# Class 3 = high energy

# Sostituiamo le classi iniziali random con classi coerenti
solar_cs = subst(solar_c, c(1,2,3), c("C1_Low","C2_Medium","C3_High")) # Se non metto C1, C2 e C3 li mette in ordine alfabetico
plot(solar_cs)

# Calculate the percentages of the Sun energy classes with one line of code
perc_solar = freq(solar_cs)$count*100/ncell(solar_cs)
perc_solar # Low energy =  38%, Medium energy = 41%, High energy = 21%

# Create dataframe
class = c("C1_Low", "C2_Medium", "C3_High")
perc = c(38,41,21)
tab_sol = data.frame(class, perc)
tab_sol

# Final ggplot
ggplot(tab_sol, aes(x=class, y=perc, fill=class, color=class)) + geom_bar(stat="identity")

# Invertiamo gli assi
ggplot(tab_sol, aes(x=class, y=perc, fill=class, color=class)) + geom_bar(stat="identity") + coord_flip()
