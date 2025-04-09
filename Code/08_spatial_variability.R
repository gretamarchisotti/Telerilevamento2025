# R code for calculating spatial variability

# Deviazione standard: radice della varianza di un campione o della popolazione
# ESEMPIO: età --> 24 26 25
media = (24 + 26 + 25)/3 # 25
num = (24-25)^2 + (26-25)^2 + (25-25)^2 # Scarti quadratici = 2
den = 3
varianza = num/den # Varianza = 0.6666667
stdev = sqrt(varianza) # Deviazione standard della popolazione =  0.8164966

# In alternativa, su R possiamo usare la deviazione standard usando la funzione sd(), che calcola la deviazione standard sul campione
sd(c(24,26,25)) # Deviazione standard del campione = 1

# Se prendo un dato che è molto diverso dagli altri, la deviazione standard aumenta
sd(c(24,26,25,49)) # Deviazione standard del campione = 12.02775

# Cambia anche la media
mean(c(24,26,25)) # 25
mean(c(24,26,25,49)) # 31
# Per questo, spesso, quando si hanno outlier, si utilizza la mediana e non la media

# -----------------------------------------------------------------------------------
library(terra)
library(imageRy)
library(viridis)
library(patchwork)

install.packages("RStoolbox")
library(RStoolbox)

im.list()

sent = im.import("sentinel.png")
sent = flip(sent)
# Band 1 = NIR
# Band 2 = red
# Band 3 = green

# Plot the image in RGB with the NIR ontop of the red component
im.plotRGB(sent, r=1, g=2, b=3) # Nero: acqua, bianco: in questo caso neve

# Make three plots with NIR ontop each component: r, g, b
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1) # Il suolo nudo diventa giallo

# Il calcolo della deviazione standard si può fare su un unico livello: scegliamo il NIR
nir = sent [[1]]

# Plot the NIR band with the inferno color ramp palette
dev.off()
plot(nir, col=inferno(100))

# Per calcolare la deviazione standard usiamo il metodo della moving window, con la funzione focal(), grana 3x3
sd3 = focal(nir, w=c(3,3), fun="sd")
plot(sd3) # Osserviamo tutte le zone in cui c'è stata una variazione del NIR

# Plottiamo l'immagine originale di fianco alla deviazione standard
im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)
# La deviazione standard aumenta nel bordo della neve, nel bordo del lago e nel bordo delle praterie
# Nell'immagine della deviazione standard vediamo molto meglio zone di cambio di vegetazione, perchè aumenta la deviazione standard

# Cambio la moving window in 5x5
dev.off()
sd5 = focal(nir, w=c(5,5), fun="sd")
plot(sd5)
# In tutta l'immagine ho zone con ampia variabilità relativa: la variabilità si espande nello spazio

im.multiframe(1,2)
plot(sd3)
plot(sd5)

# Use ggplot to plot the standard deviation
dev.off()
im.ggplot(sd3)
# ggplot permette di plottare accanto due immagini diverse, ma della stessa dimensione

# Plot the two sd maps (sd3 and sd5) one beside the other with ggplot
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd5)
p1 + p2

# Plot the original nir and the stdev
p3 = im.ggplot(nir)
p3 + p1

# With ggplot, plot the original set in RGB (ggRGB) together with the sd with 3 and 5 pixels
p3 = ggRGB(sent, r=1, g=2, b=3)
p1 + p2 + p3
p3 + p1 + p2












