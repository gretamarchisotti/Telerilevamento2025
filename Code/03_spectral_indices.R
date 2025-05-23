# Code for calculating spectral indices in R

library(imageRy) # beloved package developed at unibo
library(terra)
library(viridis)

im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")

#Per reinvertire l'immagine
mato1992 = flip(mato1992)
plot(mato1992)

# La composizione di questa immagine, corrisponde alle seguenti bande
# 1 = NIR
# 2 = red
# 3 = green

im.plotRGB(mato1992, r=1, g=2, b=3) # Tutta la vegetazione diventa rossa
im.plotRGB(mato1992, r=2, g=1, b=3) # Tutta la vegetazione diventa rossa e il suolo nudo è rosa
im.plotRGB(mato1992, r=2, g=3, b=1) # Tutta la vegetazione diventa blu e il suolo nudo è giallo, anche l'acqua è gialla perchè ha molti solidi disciolti

# Importiamo l'immagine del 2006 e la invertiamo
mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)

im.plotRGB(mato2006, r=1, g=2, b=3)

# Osserviamo le due immagini messe a confronto
im.multiframe(1,2)
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato2006, r=1, g=2, b=3)

# Mettiamo in risalto il suolo nudo in giallo
im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato2006, r=3, g=2, b=1)


im.multiframe(3,2) # Inserisco tutte e sei le immagini insieme
# NIR ontop of red
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato2006, r=1, g=2, b=3)

# NIR ontop of green
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato2006, r=2, g=1, b=3)

# NIR ontop of blue
im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato2006, r=3, g=2, b=1)

# Exercise: plot only the first layer of mato2006
dev.off()
plot(mato2006[[1]])

plot(mato2006[[1]], col=magma(100)) # Cambiamo il colore
plot(mato2006[[1]], col=mako(100))

# Calculating DVI
im.multiframe(1,2)
plot(mato1992)
plot(mato2006)

# 1 = NIR
# 2= red

dvi1992=mato1992[[1]]-mato1992[[2]] #NIR - red
plot(dvi1992)

# range DVI
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

# Per cambiare la visualizzazione del dato
plot(dvi1992, col=mako(100))

dvi2006=mato2006[[1]]-mato2006[[2]]
plot(dvi2006, col=mako(100))

im.multiframe(1,2)
plot(dvi1992, col=mako(100))
plot(dvi2006, col=mako(100))

# Consideriamo due immagini con diversi livelli di risoluzione radiometrica (n° di bit)
# Queste non sono paragonabili, perchè hanno un range di risoluzione diversa

# DVI 8 bit (0-255): range 
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

# DVI 4 bit (0-15): range 
# maximum: NIR - red = 15 - 0 = 15
# minimum: NIR - red = 0 - 15 = -15

# Per ovviare questo problema, si usa un altro indice, detto NDVI
# NDVI 8 bit (0-255): range 
# maximum: (NIR - red)/(NIR + red) = (255 - 0)/(255 + 0) = 1
# minimum: (NIR - red)/(NIR + red) = (0 - 255)/(0 + 255) = -1

# NDVI 4 bit (0-15): range 
# maximum: (NIR - red)/(NIR + red) = (15 - 0)/(15 + 0) = 1
# minimum: (NIR - red)/(NIR + red) = (0 - 15)/(0 + 15) = -1

im.multiframe(1,2)
ndvi1992 = (mato1992[[1]] - mato1992[[2]])/(mato1992[[1]] + mato1992[[2]]) # Il numeratore si può sostiuire anche come dvi1992
plot(ndvi1992, col=inferno(100))

ndvi2006 = (mato2006[[1]] - mato2006[[2]])/(mato2006[[1]] + mato2006[[2]])
plot(ndvi2006, col=inferno(100))

# Esistono delle funzioni in imageRy apposite: il risultato finale è lo stesso, ma con le funzioni è più veloce
# Per calcolare il DVI: im.dvi(nome immagine, banda NIR, banda red)
dvi1992auto = im.dvi(mato1992, 1, 2)
plot(dvi1992auto)

dvi2006auto = im.dvi(mato2006, 1, 2)
plot(dvi2006auto)

# Per calcolare l'NDVI: im.ndvi(nome immagine, banda NIR, banda red)
ndvi1992auto = im.ndvi(mato1992, 1, 2)
plot(ndvi1992auto)

ndvi2006auto = im.ndvi(mato2006, 1, 2)
plot(ndvi2006auto)




























