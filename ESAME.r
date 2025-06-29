# Pacchetti richiesti e utilizzati
library(terra)
library(imageRy)

# Imposto la working directory
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

# Importo le immagini
sentinel2024 <- rast("sentinel2_Canada2024.tif")
sentinel2024

sentinel2025 <- rast("sentinel2_Canada2025.tif")
sentinel2025

# Visualizzo le immagini in RGB
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel (median) 2025")

# Il salvataggio delle immagini è stato fatto con il menù a tendina di R

# ----------------------------------------------------
# Visualizzazione dell'immagine con il NIR
im.multiframe(3,2)
# NIR ontop of red
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato2006, r=1, g=2, b=3)

# ----------------------------------------------------
# Calcolo del DVI

# Functions from imageRy
dvi1992auto = im.dvi(mato1992, 1, 2)
dev.off()
plot(dvi1992auto)

dvi2006auto = im.dvi(mato2006, 1, 2)
dev.off()
plot(dvi2006auto)

ndvi1992auto = im.ndvi(mato1992, 1, 2)
dev.off()
plot(ndvi1992auto)

ndvi2006auto = im.ndvi(mato2006, 1, 2)
dev.off()
plot(ndvi2006auto)

im.multiframe(1,2)
plot(ndvi1992)
plot(ndvi1992auto)

# -----------------------------------------------------
# Analisi multitemporale
gr = im.import("greenland")

im.multiframe(1,2)
plot(gr[[1]], col=rocket(100))
plot(gr[[4]], col=rocket(100))

grdif = gr[[4]] - gr[[1]] # 2015 - 2000
plot(grdif)
# All the yellow parts are those in which there is a higher value in 2015

# Ridgeline plots
im.ridgeline(gr, scale=1)
im.ridgeline(gr, scale=2)
im.ridgeline(gr, scale=2, palette="inferno")
im.ridgeline(gr, scale=3, palette="inferno")

# Exercise: import the NDVI data from Sentinel 
ndvi = im.import("Sentinel2_NDVI")
im.ridgeline(ndvi, scale=2)

# Changing names
# sources     : Sentinel2_NDVI_2020-02-21.tif  
#               Sentinel2_NDVI_2020-05-21.tif  
#               Sentinel2_NDVI_2020-08-01.tif  
#               Sentinel2_NDVI_2020-11-27.tif  

names(ndvi) = c("02_Feb", "05_May", "08_Aug", "11_Nov")
im.ridgeline(ndvi, scale=2)
im.ridgeline(ndvi, scale=2, palette="mako")

pairs(ndvi)

plot(ndvi[[1]], ndvi[[2]])
# y = x # may y, feb x
# y = a + bx
# a=0, b=1
# y = a + bx = 0 + 1x = x

abline(0, 1, col="red")

plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")

im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")

# -------------------------------------------------------
# Classificazione?

# -------------------------------------------------------
# Deviazione standard

# Exercise: import the NDVI data from Sentinel 
ndvi = im.import("Sentinel2_NDVI")
im.ridgeline(ndvi, scale=2)

names(ndvi) = c("02_Feb", "05_May", "08_Aug", "11_Nov")
im.ridgeline(ndvi, scale=2)
im.ridgeline(ndvi, scale=2, palette="mako")

pairs(ndvi)

plot(ndvi[[1]], ndvi[[2]])
# y = x # may y, feb x
# y = a + bx
# a=0, b=1
# y = a + bx = 0 + 1x = x

abline(0, 1, col="red")

plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")

im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")
