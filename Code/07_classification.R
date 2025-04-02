# R code for classifying images

library(terra)
library(imageRy)

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
f1992 = freq(mato1992c) # 1495563 pixel di foresta e 304437 pixel di umano

# Calcoliamo una percentuale
tot1992 = ncell(mato1992c)
prop1992 = f1992/tot1992 # Ci interessa la colonna count: 0.8308683 per la foresta, 0.1691317 per l'umano
perc1992 = prop1992*100
# Percentages: forest = 83% and human = 17%

perc2006 = freq(mato2006c)*100/ncell(mato2006c)
# Percentages: forest = 45% and human = 55%


















