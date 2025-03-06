# Code for visualizing satellite data

library(terra)
library(imageRy)

#Listing files
im.list()

#Sentinel-2 bands: https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/
b2 <- im.import("sentinel.dolomites.b2.tif")
# Tutti gli oggetti che assorbono il blu sono di colore giallo, mentre tutti gli oggetti che riflettono il blu sono di colore blu

cl=colorRampPalette(c("black","darkgrey","lightgrey"))(100)
plot(b2, col=cl)
# Tutti gli oggetti che assorbono il blu sono di colore grigio chiaro, mentre tutti gli oggetti che riflettono il blu sono di colore nero

cl=colorRampPalette(c("black","darkgrey","lightgrey"))(3)
plot(b2, col=cl)
# Se riduco il numero di sfumature avrò un'immagine più grezza

cl=colorRampPalette(c("blue","green","yellow","red"))(100)
plot(b2, col=cl)

# Exercise: change the color ramp
# https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf
cl=colorRampPalette(c("deeppink4", "palevioletred", "pink1", "wheat"))(100)
plot(b2, col=cl)

# Band
b2=im.import("sentinel.dolomites.b2.tif")
b3=im.import("sentinel.dolomites.b3.tif")
b4=im.import("sentinel.dolomites.b4.tif")
b8=im.import("sentinel.dolomites.b8.tif")

# Per plottare tutte le immagini insieme
par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# Per cancellare quello che c'è nel device grafico
dev.off()

# In alternativa a par(), posso usare la funzione im.multiframe(x,y), dove x sono le righe e y le colonne
im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)
# Le tre immagini del visibile sono molto simili fra loro, mentre la banda dell'infrarosso vicino differisce dalle altre

# Exercise: plot the band using im.multiframe() one on top of the other
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

im.multiframe(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)
