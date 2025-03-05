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

