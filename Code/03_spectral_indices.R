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















