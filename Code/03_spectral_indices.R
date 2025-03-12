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

