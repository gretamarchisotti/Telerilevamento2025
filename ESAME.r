# Progetto d'Esame, Greta Marchisotti - Codice in R per l'elaborazione delle immagini
# Le immagini sono relative agli incendi verificatisi nella primavera del 2025 in Canada, nell'area a confine tra le regioni Manitoba e Saskatchewan
# Grazie a Google Earth Engine sono state scaricate due immagini di Sentinel-2 (per il codice vedere lo script Esame.js)
# La prima riguarda una media delle immagini di giugno 2024, la seconda una media delle immagini di giugno 2025, dopo che si sono verificati gli incendi

# Il salvataggio delle immagini da R, salvo diversamente specificato, è stato fatto con il menù a tendina di R

# Pacchetti richiesti e utilizzati
library(terra) # Paccheto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness

# Imposto la working directory
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

# Importo in R le immagini scaricate con Google Earth Engine
sentinel2024 <- rast("Canada2024.tif")
sentinel2024

sentinel2025 <- rast("Canada2025.tif")
sentinel2025

# Visualizzo entrambe le immagini in RGB creando un multiframe e le salvo in .png; infine chiudo il pannello grafico
im.multiframe(1,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
dev.off()

# Visualizzo le quattro bande separate (RGB e NIR) per entrambe le immagini
plot(sentinel2024, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))
plot(sentinel2025, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))

# Salvo le immagini in formato .png

# Visualizzo le due immagini con il NIR ponendo il NIR al posto del filtro red e le inserisco in un multiframe con le immagini in RGB
im.multiframe(2,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
im.plotRGB(sentinel2024, r=4, g=1, b=3)
im.plotRGB(sentinel2025, r=4, g=1, b=3)
dev.off() # Chiudo il pannello grafico dopo aver salvato le immagini in .png

# Calcolo l'NDVI per entrambe le immagini e le visualizzo graficamente in un multiframe, modificandone il colore con una delle palette di viridis 
ndvi2024 = im.ndvi(sentinel2024, 4, 1)
ndvi2025 = im.ndvi(sentinel2025, 4, 1)
im.multiframe(2,1)
plot(ndvi2024, col=rocket(100), main="NDVI 2024")
plot(ndvi2025, col=rocket(100), main="NDVI 2025")
dev.off() # Chiudo il pannello grafico dopo aver salvato le immagini in .png

