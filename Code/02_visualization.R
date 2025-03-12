# R code for visualizing satellite data

install.packages("viridis")

library(terra)
library(imageRy)
library(viridis)

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

# Cambiamo i colori alle immagini
cl = colorRampPalette(c("black","lightgrey"))(100)
plot(b2,col=cl)
plot(b3,col=cl)
plot(b4,col=cl)
plot(b8,col=cl)

# Per fare uno stack
sent = c(b2, b3, b4, b8)
plot(sent, col=cl)

# Per cambiare i nomi
names(sent)=c("b2blue","b3green","b4red","b8NIR")

# Per plottare un solo elemento da uno stack
plot(sent$b8NIR)
# in alternativa
plot(sent[[4]])

# Importing several bands altogether
sentdol=im.import("sentinel.dolomites")

# How to import several sets altogether
pairs(sentdol)

plot(sentdol, col=viridis(100))
plot(sentdol, col=viridis(100))

# 1 - band 2 (blue)
# 2 - band 3 (green)
# 3 - band 4 (red)
# 4 - band 8 (NIR)

# Natural colors: facciamo un plotaggio dell'immagine usando colori naturali
im.plotRGB(sentdol, r=3, g=2, b=1)
# Otteniamo un'immagine piuttosto grezza, che il nostro occhio non riesce a distinguere bene; si vede solo un buon contrasto tra rocce e vegetazione

# False colors: aggiungiamo anche il NIR
# Non possiamo usare più di tre bande, quindi facciamo scorrere tutti di una posizione
im.plotRGB(sentdol, r=4, g=3, b=2)
# Le piante riflettono molto nel NIR, quindi il filtro del NIR corrisponderà alle piante
# Risulta molto più facile distinguere i diversi tipi di vegetazione, quindi conifere e latifoglie e le praterie sommitali (rosso chiaro)
# Vediamo anche l'acqua

# Pongo il NIR al posto del filtro green, quindi la vegetazione sarà verde
im.plotRGB(sentdol, r=3, g=4, b=2)
# Quello che fa variare il colore dell'immagine è dove metto il NIR

# Pongo il NIR al posto del filtro blue, quindi la vegetazione sarà blu
im.plotRGB(sentdol, r=3, g=2, b=4)
# Il suolo nudo in questi casi tende a diventare giallo












