# R code for performing multitemporal analysis

library(terra)
library(imageRy)
library(viridis)

im.list()

EN_01 = im.import("EN_01.png")
EN_01 = flip(EN_01)
plot(EN_01)

EN_13 = im.import("EN_13.png")
EN_13 = flip(EN_13)
plot(EN_13)

im.multiframe(1,2)
plot(EN_01)
plot(EN_13)

# Entrambe le immagini sono in RGB
# Differenza tra le due immagini, scegliendo solo il primo livello di entrambe le immagini
ENdif = EN_01[[1]] - EN_13[[1]]
plot(ENdif)

# Cambiamo la legenda dell'immagine
plot(ENdif, col=inferno(100))

# -----------------------------------
# Greenland ice melt

gr = im.import("greenland")

grdif = gr[[4]] - gr[[1]] #2015 - 2000
plot(grdif)
# Tutte le parti gialle sono quelle che nel 2015 mostrano un aumento di temperatura maggiore rispetto alle temperature del 2000

# ---------------------------------------------------------
# Esportazione delle immagini da R e importazione in github

# Selezioniamo la cartella di lavoro
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R")

# Per vedere la cartella selezionata
getwd()

# Creiamo un file PDF con la funzione pdf()
pdf("output.pdf") # Creiamo il file
plot(grdif) # Plottiamo il grafico all'interno del file
dev.off() # Alla fine devo chiudere il file altrimenti il PDF non viene creato

# Creiamo un file immagine con la funzione jpeg
jpeg("output.jpeg")
plot(grdif)
dev.off()
