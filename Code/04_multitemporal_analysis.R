# R code for performing multitemporal analysis

install.packages("ggridges") # This is needed to create ridgeline plot
library(terra)
library(imageRy)
library(viridis)

# Listing the data
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

# Ridgeline plots
im.ridgeline(gr, scale=1)
# Il parametro di scala (scale=) dice quando può essere grande ogni picco
# Si può cambiare colore con l'argomento palette=
im.ridgeline(gr, scale=2, palette="inferno")




















