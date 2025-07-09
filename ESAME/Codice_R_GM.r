# PROGETTO D'ESAME (09/07/2025) - ANALISI DI UN'AREA CANADESE SOGGETTA A INCENDIO NELLA PRIMAVERA 2025
# Telerilevamento geologico in R
# Greta Marchisotti

# CODICE IN R PER L'ELABORAZIONE DELLE IMMAGINI

# Le immagini sono relative agli incendi verificatisi nella primavera del 2025 in Canada, nell'area a confine tra le regioni Manitoba e Saskatchewan
# Grazie a Google Earth Engine sono state scaricate due immagini di Sentinel-2 (per il codice si veda lo script Esame.js)
# La prima riguarda una mediana delle immagini di giugno 2024, la seconda una mediana delle immagini di giugno 2025, dopo che si sono verificati gli incendi

# Il salvataggio delle immagini da R è stato fatto con il menù a tendina di R, in formato .png

# Pacchetti richiesti e utilizzati
library(terra) # Pacchetto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2) # Pacchetto per creare grafici ggplot
library(patchwork) # Pacchetto per comporre più grafici ggplot insieme

# Imposto la working directory
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

# ---
# IMPORTAZIONE DELLE IMMAGINI
# Importo in R le immagini scaricate con Google Earth Engine
sentinel2024 <- rast("Canada2024.tif")
sentinel2024

sentinel2025 <- rast("Canada2025.tif")
sentinel2025

# Visualizzo entrambe le immagini in RGB creando un multiframe
im.multiframe(1,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# Visualizzo le quattro bande separate (RGB e NIR) per entrambe le immagini
plot(sentinel2024, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))
plot(sentinel2025, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# ---
# CLASSIFICAZIONE DELLE IMMAGINI
# Creo un multiframe per osservare le due immagini classificate insieme
im.multiframe(1,2)

# Classifico le due immagini in due classi (class 1; class 2)
sentinel2024_cl = im.classify(sentinel2024, num_clusters=2)
sentinel2025_cl = im.classify(sentinel2025, num_clusters=2)
# In blu osserviamo l'area della foresta, in giallo tutto ciò che non è foresta
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# Calcolo la percentuale per le due classi, per entrambe le immagini; poi osservo i risultati
perc2024 = freq(sentinel2024_cl)*100/ncell(sentinel2024_cl)
perc2024 # Forest: 76%, Everything else: 24%

perc2025 = freq(sentinel2025_cl)*100/ncell(sentinel2025_cl)
perc2025 # Forest: 51%, Everything else: 49%

# Creo una tabella con i risultati
classi = c("Forest", "Everything else")
a2024 = c(76,24)
a2025 = c(51,49)
tab = data.frame(classi, a2024, a2025)
tab # Osservo il risultato, riportato qui di seguito
#    classi           a2024 a2025
# 1  Forest             76   51
# 2  Everything else    24   49

# Creo i due grafici e li inserisco uno accanto all'altro, aggiustando le scale
p1 = ggplot(tab, aes(x=classi, y=a2024, fill=classi, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 = ggplot(tab, aes(x=classi, y=a2025, fill=classi, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# ---
# NIR
# Visualizzo le due immagini con il NIR ponendo la banda 8 al posto della banda del rosso e le inserisco in un multiframe con le immagini in RGB
im.multiframe(2,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
im.plotRGB(sentinel2024, r=4, g=1, b=3)
im.plotRGB(sentinel2025, r=4, g=1, b=3)
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# ---
# NDVI
# Calcolo l'NDVI per entrambe le immagini e le visualizzo graficamente in un multiframe, modificandone il colore con una delle palette di viridis 
ndvi2024 = im.ndvi(sentinel2024, 4, 1)
ndvi2025 = im.ndvi(sentinel2025, 4, 1)

im.multiframe(1,2)
plot(ndvi2024, col=rocket(100), main="NDVI 2024")
plot(ndvi2025, col=rocket(100), main="NDVI 2025")
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png

# ---
# ANALISI MULTITEMPORALE
# Faccio la differenza tra l'immagine del 2024 e quella del 2025, scegliendo solo la banda B8 relativa al NIR
nir_diff = sentinel2024[[4]]-sentinel2025[[4]]

# Ripeto la stessa procedura per l'NDVI
ndvi_diff = ndvi2024-ndvi2025

# Faccio un multiframe con i plot di entrambe le differenze
im.multiframe(1,2)
plot(nir_diff, col=mako(100), main="NIR")
plot(ndvi_diff, col=mako(100), main="NDVI")
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
