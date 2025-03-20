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

# Ridgeline plots: data frequency per year
im.ridgeline(gr, scale=1)
# Il parametro di scala (scale=) dice quando può essere grande ogni picco; scale=1 evita sovrapposizioni
# Si può cambiare colore con l'argomento palette=
im.ridgeline(gr, scale=2, palette="inferno")

# Importing the NDVI data from Sentinel
ndvi=im.import("Sentinel2")

# Changing names (if all the names are the same, the fuction plots only one ridgeline plot)
# sources: Sentinel2_NDVI_2020-02-21.tif  
#          Sentinel2_NDVI_2020-05-21.tif  
#          Sentinel2_NDVI_2020-08-01.tif  
#          Sentinel2_NDVI_2020-11-27.tif 
names(ndvi)=c("02_Feb","05_May","08_Aug","11_Nov")

im.ridgeline(ndvi, scale=2, palette="mako")

pairs(ndvi)

plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9)) # Comparing  February and May data
# Adding a line where y=x (May=y, Feb=x), with the function abline()
# y = a + bx, a=0, b=1
abline(0,1, col="red") # May data are above the red line: this means that they are greater than February data

im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9))
abline(0,1, col="red")











