# Telerilevamento geologico in R - Progetto d'esame
# 09/07/2025
## Greta Marchisotti

Il progetto ha lo scopo di analizzare un'area del Canada, al confine tra le regioni Manitoba e Saskatchewan, a nord della cittadina Flin Flon, che nella primavera del 2025 è stata oggetto di un ampio incendio.
L'analisi vuole osservare le differenze in termini di vegetazione tra il 2024 e il 2025 e valutare quindi l'impatto dell'incendio stesso.
Sono state pertanto scelte due immagini di Sentinel-2, che riguardano una media di giugno 2024 e una media di giugno 2025
Le immagini sono relative agli incendi verificatisi nella primavera del 2025 in Canada, nell'area a confine tra le regioni Manitoba e 

## Raccolta delle immagini
Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), scegliendo l'area descritta precedentemente.

## Pacchetti utilizzati
```r
library(terra) # Paccheto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2) # Pacchetto per creare grafici ggplot
library(patchwork) # Pacchetto per comporre più grafici ggplot insieme
```

## Impostazione della working directory e importazione delle immagini
```r
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

sentinel2024 <- rast("Canada2024.tif")
sentinel2024

sentinel2025 <- rast("Canada2025.tif")
sentinel2025
```

Le immagini importate sono state poi visualizzate nello spettro del visibile
```r
im.multiframe(1,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
dev.off()
```

L'immagine risultante è la seguente:















